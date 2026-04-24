#!/bin/bash
# Step: 0B Anchoring and Structural Variant Detection

REF_1B="../../results/01_assembly/Asta_v3_polished.fasta"
DRAFT_0B="../../data/assembly/0B_draft_2019.fasta"
THREADS=16

# 1. Anchor 0B Draft to 1B Reference (RagTag)
# Enables misassembly correction and homology-based scaffolding (Line 625)
ragtag.py scaffold $REF_1B $DRAFT_0B -o ../../results/04_3d_genome/0B_anchored

# 2. Whole-Genome Alignment (NUCmer)
nucmer --maxmatch -l 100 -c 500 $REF_1B \
       ../../results/04_3d_genome/0B_anchored/ragtag.scaffold.fasta \
       -p ../../results/04_3d_genome/asta_comparison

# 3. Structural Variant Detection (SyRI)
# Manuscript Ref: Lines 619-621
syri -c ../../results/04_3d_genome/asta_comparison.delta \
     -r $REF_1B \
     -q ../../results/04_3d_genome/0B_anchored/ragtag.scaffold.fasta \
     --dir ../../results/04_3d_genome/syri_out \
     -k -F B # B for BAM/SAM format handling
