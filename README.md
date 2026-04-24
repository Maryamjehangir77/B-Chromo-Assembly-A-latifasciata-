# B-Chromo-Assembly-A-latifasciata

**Manuscript Title:** *Genome Assembly of Astatotilapia latifasciata Uncovers B Chromosome Linked Chromatin Reorganization*

This repository contains the bioinformatics pipelines, custom scripts, and configuration files used for the chromosome-level assembly and 3D chromatin analysis of the *Astatotilapia latifasciata* B chromosome.

## 🧬 Project Overview
Our study leverages a combination of **PacBio HiFi**, **Illumina**, and **Hi-C** sequencing to resolve the complex genomic landscape of B chromosomes in cichlids. We report a **34 Mb B chromosome assembly** and characterize its unique chromatin architecture, specifically identifying shifts in TAD boundaries and loop formation compared to the A-complement.

### Key Findings:
* **High-Quality Assembly:** 0.93 Gb total genome size with a scaffold N50 of 36.2 Mb.
* **B-Chromosome Content:** Identification of 789 protein-coding genes and a high density of LTR retrotransposons.
* **3D Architecture:** Evidence of large-scale chromatin reorganization and altered compartmentalization on the B chromosome.

---

## 📂 Repository Structure
```text
├── envs/                # Conda environment (yml) for reproducibility
├── scripts/
│   ├── 01_assembly.sh   # Hifiasm parameters for long-read assembly
│   ├── 02_scaffolding.sh # Juicer and 3D-DNA Hi-C integration
│   ├── 03_b_identify.sh  # Coverage-based B-linked scaffold filtering
│   └── 04_hic_analysis.sh # TAD and Loop calling via HiC-Explorer
└── metadata/            # Sample IDs and NCBI accession links

🚀 Getting Started
Prerequisites

The pipeline requires Conda or Mamba. You can recreate the exact environment used in the paper:
Bash

mamba env create -f envs/environment.yml
conda activate alat_b_genome

Usage Example: B-Chromosome Identification

To identify B-linked scaffolds based on the coverage ratio between B+ and B- individuals:
Bash

bash scripts/03_b_identify.sh --input_bam alignment.bam --output b_scaffolds.txt

📊 Data Availability

All genomic data and assemblies generated in this study are available through the National Center for Biotechnology Information (NCBI):

    BioProject: PRJNA1283115

    Genome Assembly: GCA_051989935.1

    Interactive Hi-C Maps: Available via [Juicebox/Figshare Link]

✍️ Citation

If you use these scripts or the assembly in your research, please cite:

    Jehangir, M., et al. (2026). Genome Assembly of Astatotilapia latifasciata Uncovers B Chromosome Linked Chromatin Reorganization. [Journal Name/Preprint]. DOI: 10.1101/2026.XXXX

✉️ Contact

Maryam Jehangir Postdoctoral Researcher

Email: maryam.bioinfo.unesp@gmail.com
