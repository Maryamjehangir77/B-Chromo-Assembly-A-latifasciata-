#!/bin/bash
# Step: Gene-level quantification for B-linked scaffolds

BAM_DIR="../../results/05_expression"
ANNOTATION="../../results/02_annotation/braker/augustus.hints.gtf"
OUT_DIR="../../results/05_expression/counts"

mkdir -p $OUT_DIR

# 1. Count reads across all samples using Bedtools multicov
# This targets the B-linked regions specifically
bedtools multicov -bams $BAM_DIR/*.bam -bed $ANNOTATION > $OUT_DIR/b_gene_counts_matrix.txt

# 2. Indexing for visualization (Samtools)
for bam in $BAM_DIR/*.bam; do
    samtools index $bam
done
