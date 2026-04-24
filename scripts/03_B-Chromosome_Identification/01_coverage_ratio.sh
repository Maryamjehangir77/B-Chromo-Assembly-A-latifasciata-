#!/bin/bash
# Manuscript Ref: Lines 554-562
# Step: B-chromosome identification via coverage ratios (1B vs 0B)

# --- Variables ---
THREADS=16
REF="../../results/01_assembly/Asta_v3_polished.fasta"
B0_R1="../../data/illumina/0B_R1.fq"
B0_R2="../../data/illumina/0B_R2.fq"
B1_R1="../../data/illumina/1B_R1.fq"
B1_R2="../../data/illumina/1B_R2.fq"
OUT_DIR="../../results/03_b_id"

mkdir -p $OUT_DIR

# 1. Alignment with Bowtie2 (Manuscript: --very-sensitive --end-to-end)
echo "Aligning 0B and 1B reads to reference..."
bowtie2 --very-sensitive --end-to-end -p $THREADS -x $REF -1 $B0_R1 -2 $B0_R2 | \
    samtools view -bS - | samtools sort -o $OUT_DIR/0B_mapped.bam
bowtie2 --very-sensitive --end-to-end -p $THREADS -x $REF -1 $B1_R1 -2 $B1_R2 | \
    samtools view -bS - | samtools sort -o $OUT_DIR/1B_mapped.bam

# 2. Calculate Per-Base Coverage (Bedtools)
echo "Calculating genome coverage..."
bedtools genomecov -ibam $OUT_DIR/0B_mapped.bam -d > $OUT_DIR/0B_cov.txt
bedtools genomecov -ibam $OUT_DIR/1B_mapped.bam -d > $OUT_DIR/1B_cov.txt

# 3. Detect B-enriched Scaffolds (Log2 Ratio)
# Based on Valente et al. (2014) strategy
echo "Computing Log2 coverage ratios..."
awk 'BEGIN{OFS="\t"} NR==FNR{a[$1,$2]=$3;next} {if (a[$1,$2]>0) print $1, $2, log($3/a[$1,$2])/log(2); else print $1, $2, "NA"}' \
    $OUT_DIR/0B_cov.txt $OUT_DIR/1B_cov.txt > $OUT_DIR/B_enrichment_ratios.txt
