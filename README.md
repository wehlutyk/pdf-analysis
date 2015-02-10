# PDF Analysis

## Prerequisites

**Grobid**

You need mavin for this: `sudo apt-get install maven`. Then:

```shell
git clone https://github.com/kermitt2/grobid.git
mvn clean install
```

**Other stuff**
* An IPython installation
* pdftotext: `sudo apt-get install poppler-utils`

## Preprocessing and extraction

Your original pdfs should be in `original_pdfs`, one subfolder per journal, like this:

```shell
original_pdfs/
├── Brain and cognition
│   ├── Adrover-Roig et al. - 2012 - A latent variable approach to executive control in.pdf
│   └── ...
└── Journal of cognitive science
    ├── Acheson y Hagoort - 2013 - Stimulating the Brain's Language Network Syntacti.pdf
    └── ...
```

Then from the root of this repo:

```shell
# Remove spaces from filenames
bash preprocess-filenames.sh original_pdfs pdfs

# Extract pdfs as text
bash all-pdfs-to-text.sh pdfs text

# Extract structured TEI from pdfs
bash all-pdfs-to-tei.sh <grobid-repo>/grobid-home/ <grobid-repo>/grobid-core/target/grobid-core-0.3.3-SNAPSHOT.one-jar.jar pdfs tei
```
