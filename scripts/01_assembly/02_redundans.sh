#!/bin/bash
# Manuscript Ref: Lines 537-538
# Step: Redundancy removal and haplotype reduction using Redundans

# --- Variables ---
THREADS=16
DRAFT_ASSEMBLY="./results/01_assembly/Asta_draft.fa"
ILLUMINA_PE1="./data/illumina/R1.fq"
ILLUMINA_PE2="./data/illumina/R2.fq"
PACBIO_READS="./data/pacbio/raw_reads.fastq.gz"
OUTPUT_DIR="./results/01_assembly/redundans_out"

# --- Execution ---
# Note: Redundans typically requires a Python 2.7 environment
# and depends on tools like BWA, Samtools, and Lastz.

python2 /storage/maryam/softwares/redundans/redundans.py \
    -v \
    -i $ILLUMINA_PE1 $ILLUMINA_PE2 \
    -l $PACBIO_READS \
    -f $DRAFT_ASSEMBLY \
    -o $OUTPUT_DIR \
    -t $THREADS \
    --identity 0.51 \
    --overlap 0.66

# --- Post-Processing ---
# The primary output is usually named 'red.final.fa'
# We rename/link it for the next step (Pilon polishing)
cp $OUTPUT_DIR/red.final.fa ./results/01_assembly/Asta_v2_curated.fasta
