~#!/bin/bash
# Manuscript Ref: Lines 572-578
# Step: Hi-C Alignment and Matrix Generation

# --- Variables ---
THREADS=24
REF="../../results/01_assembly/Asta_v3_polished.fasta"
HIC_R1="../../data/hic/1B_HiC_R1.fq"
HIC_R2="../../data/hic/1B_HiC_R2.fq"
RESTRICTION_SITE="AAGCTT" # HindIII example; update to Sau3AI if needed (Line 539)
OUT_DIR="../../results/04_3d_genome"

mkdir -p $OUT_DIR

# 1. Build Hi-C Matrix at 10kb resolution
# This handles the filtering and bias correction mentioned in line 578
hicBuildMatrix --samFiles $HIC_R1 $HIC_R2 \
               --binSize 10000 \
               --restrictionSequences $RESTRICTION_SITE \
               --outFileName $OUT_DIR/matrix_raw_10k.h5 \
               --threads $THREADS

# 2. Correct Matrix for bias (KR Normalization)
hicCorrectMatrix correct --matrix $OUT_DIR/matrix_raw_10k.h5 \
                 --correctionMethod KR \
                 --outFileName $OUT_DIR/matrix_corrected_10k.h5
