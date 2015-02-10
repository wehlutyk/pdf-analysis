#!/bin/bash

# Show errors
set -e

# We want four arguments
if [ $# != 4 ]
then
    echo "Usage: $(basename $0) grobid-home grobid-jar pdf-folder tei-folder"
    exit 1
fi
ghome=$1
jar=$2
folder=$3
outfolder=$4
echo "###"
echo "### Extracting PDFs to TEI"
echo "###"
echo
if [ -e "$outfolder" ]
then
    echo "Folder '$outfolder' already exists, I won't overwrite it. Delete it first."
    exit 1
fi


# Our output
mkdir "$outfolder"


# Deal with spaces in filenames
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

for d in $(ls -1 "$folder")
do
    echo "Processing articles in '$d'"
    mkdir -p "$outfolder/$d"
    java -Xmx1024m -jar "$jar" -gH "$ghome" -dIn "$folder/$d" -dOut "$outfolder/$d" -exe processFullText
done

IFS=$SAVEIFS


echo
echo "All done!"
