#!/bin/bash
# Step: TAD and Loop Detection

MATRIX="../../results/04_3d_genome/matrix_corrected_10k.h5"
OUT_PREFIX="../../results/04_3d_genome/Asta"

# 1. Find TADs (20kb and 50kb as per manuscript)
# Using FDR correction as specified in line 580
hicFindTADs --matrix $MATRIX \
            --minDepth 40000 --maxDepth 100000 --step 20000 \
            --outPrefix ${OUT_PREFIX}_TADs_20k \
            --correctForMultipleTesting fdr

# 2. Detect Loops using Negative Binomial model
# Manuscript Ref: Lines 581-583
hicDetectLoops --matrix $MATRIX \
               --outFileName ${OUT_PREFIX}_loops.bedgraph \
               --maxLoopDistance 2000000 \
               --windowSize 10 \
               --pValue 0.05
