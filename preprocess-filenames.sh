#!/bin/bash

# Show errors
set -e

# We want two arguments
if [ $# != 2 ]
then
    echo "Usage: $(basename $0) original-pdf-folder output-pdf-folder"
    exit 1
fi
folder=$1
outfolder=${2// /_}
echo "###"
echo "### Processing filenames (removing spaces)"
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
    outsubfolder=$outfolder/${d// /_}
    mkdir -p "$outsubfolder"
    for f in $(ls -1 "$folder/$d")
    do
        echo "Processing article '$f' (in folder '$d')"
        cp "$folder/$d/$f" "$outsubfolder/${f// /_}"
    done
done

IFS=$SAVEIFS


echo
echo "All done!"
