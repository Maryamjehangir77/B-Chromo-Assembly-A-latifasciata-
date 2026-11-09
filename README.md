# *Astatotilapia latifasciata* B-chromosome genome assembly

This repository contains selected scripts, environment files, and notes associated with the chromosome-level genome assembly and B-chromosome analyses reported in the paper below.

## Publication

Jehangir, M., Ahmad, S.F., Oliveira, J.I.N. et al. “Genome assembly of *Astatotilapia latifasciata* uncovers B chromosome-linked chromatin reorganization.” *Heredity* (2026). [https://doi.org/10.1038/s41437-026-00847-4](https://doi.org/10.1038/s41437-026-00847-4)

Please use the final journal article as the preferred citation; the earlier bioRxiv preprint is superseded.

## Repository contents

`envs/` contains a Conda environment specification. `scripts/` contains selected analysis scripts. `old_notes/` contains technical notes.

The repository does not include the `metadata/` directory shown in an earlier README version. Raw data, sample sheets, and analysis results are also not tracked here.

## Data availability

- Raw sequencing reads: [NCBI BioProject PRJNA1283115](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1283115)
- Genome assembly: [GCA_051989935.1](https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_051989935.1/)
- Repeat annotations, gene annotations, and supporting datasets: [Zenodo, 10.5281/zenodo.15522222](https://doi.org/10.5281/zenodo.15522222)

## Using the scripts

These are project-specific research scripts, not a ready-to-run, end-to-end pipeline. Paths, sample names, metadata, and reference files may need to be supplied or adjusted. The Conda file is a starting environment; the paper reports Pilon v1.22, while the current environment file pins v1.24 and the assembly script refers to a local v1.22 JAR. Resolve this version difference before reproducing the assembly.

The Hi-C matrix script is also a template that needs correction before use: it currently supplies raw FASTQ paths to HiCExplorer's `--samFiles` argument, which expects alignment files, and uses HindIII as an example restriction site while the paper methods report Sau3AI. Prepare the required alignments and match the restriction-site setting to the data before running it.

The scripts have not been validated as a clean-install, end-to-end reproduction from this repository alone. See the paper for the published methods and the data links above for inputs and supporting files.
