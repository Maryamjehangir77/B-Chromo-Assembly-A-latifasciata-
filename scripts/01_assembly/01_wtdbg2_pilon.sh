#!/bin/bash
# Manuscript Ref: Lines 530-538
# Step: wtdbg2 assembly followed by Pilon polishing

# Variables
THREADS=32
GENOME_SIZE="1g"
PACBIO_READS="./data/pacbio/raw_reads.fastq.gz"
ILLUMINA_R1="./data/illumina/R1.fq"
ILLUMINA_R2="./data/illumina/R2.fq"
OUTPUT_DIR="./results/01_assembly"

mkdir -p $OUTPUT_DIR

# 1. wtdbg2 Assembly
wtdbg2 -x rs -g $GENOME_SIZE -t $THREADS -i $PACBIO_READS -fo $OUTPUT_DIR/Asta_wtdbg2
wtpoa-cns -t $THREADS -i $OUTPUT_DIR/Asta_wtdbg2.ctg.lay.gz -fo $OUTPUT_DIR/Asta_draft.fa

# 2. Pilon Polishing
# Alignment of short reads to draft
bwa index $OUTPUT_DIR/Asta_draft.fa
bwa mem -t $THREADS $OUTPUT_DIR/Asta_draft.fa $ILLUMINA_R1 $ILLUMINA_R2 | samtools sort -o $OUTPUT_DIR/pilon_aln.bam
samtools index $OUTPUT_DIR/pilon_aln.bam

# Run Pilon 1.22
java -Xmx300g -jar pilon-1.22.jar --genome $OUTPUT_DIR/Asta_draft.fa \
    --frags $OUTPUT_DIR/pilon_aln.bam \
    --output $OUTPUT_DIR/Asta_v3_polished --fix all
