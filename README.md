# A. latifasciata B-Chromosome Genome Assembly 

[![bioRxiv](https://img.shields.io/badge/bioRxiv-10.1101/2025.08.05.668687-red)](https://doi.org/10.1101/2025.08.05.668687)

This repository contains the bioinformatics pipelines, custom scripts, and configuration files for the chromosome-level assembly, annotation, and 3D chromatin analysis of the *Astatotilapia latifasciata* B chromosome.

---

##  Repository Structure

```text
.
├── envs/                # Conda environment definitions (.yml)
├── metadata/            # B-markers, chrom.sizes, and sample sheets
├── results/             # Final alignment and assembly outputs (Git-ignored)
└── scripts/
    ├── 01_assembly/                      # wtdbg2, redundans, and Pilon polishing
    ├── 02_annotation/                    # EDTA (TEs) and BRAKER (Protein-coding)
    ├── 03_B-Chromosome_Identification/   # Coverage ratios and Hi-C validation
    ├── 04_3d_genome/                     # HiCExplorer (TADs/Loops) and SyRI (SVs)
    ├── 05_expression/                    # STAR alignment and edgeR (DE analysis)
    └── 06_comparative/                   # OrthoFinder2, IQ-TREE, and CAFE

 Analysis Workflow
1. Genome Assembly & Polishing

The genome was assembled using wtdbg2 (v2.5) and polished with Pilon (v1.22). Redundant sequences were removed using Redundans.

    Scripts: scripts/01_assembly/

2. Genome Annotation

Repeat annotation was performed using the Extensive de-novo TE Annotator (EDTA). Protein-coding genes were predicted using BRAKER, incorporating transcriptomic evidence.

    Scripts: scripts/02_annotation/

3. B-Chromosome Identification

Identification of B-linked sequences using male/female short-read data and Hi-C contact profiles. Validation was performed against previously published B-specific markers.

    Scripts: scripts/03_B-Chromosome_Identification/

4. 3D Genome Organization & TAD Analysis

Modeling of 3D chromatin structure using Juicer and identification of TADs and loops via HiCExplorer. Structural variants (SVs) were identified using SyRI.

    Scripts: scripts/04_3d_genome/

5. Transcriptome Analysis

RNA-seq alignment across Brain, Muscle, and Gonad tissues using STAR. Differential expression was assessed with edgeR (∣logFC∣≥1.5, FDR≤0.05).

    Scripts: scripts/05_expression/

 Prerequisites

Recreate the analysis environments using the provided Conda YAML files:
Bash

conda env create -f envs/genomics_env.yml
conda activate genomics_env

 Citation

If you use these scripts or the assembly in your research, please cite:

Jehangir, M., et al. (2026). Genome Assembly of Astatotilapia latifasciata Uncovers B Chromosome Linked Chromatin Reorganization. bioRxiv.
DOI: 10.1101/2025.08.05.668687

✉️ Contact

Maryam Jehangir - Postdoctoral Researcher

Email: maryam.bioinfo.unesp@gmail.com
