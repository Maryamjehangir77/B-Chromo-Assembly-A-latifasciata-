#!/bin/bash
# Step: Ab-initio and Evidence-based Gene Prediction

MASKED_GENOME="../../results/02_annotation/Asta_softmasked.fa"
BAM_FILES="../../results/05_expression/*.bam" # Use BAMs from your STAR output
THREADS=24

# 1. Merge BAM files for comprehensive transcript evidence
samtools merge -@ $THREADS merged_evidence.bam $BAM_FILES

# 2. Run BRAKER
# This uses both RNA-seq evidence and ab-initio models
braker.pl --genome=$MASKED_GENOME \
          --bam=merged_evidence.bam \
          --species=Astatotilapia_latifasciata \
          --threads=$THREADS \
          --gff3 \
          --softmasking

# 3. Functional Annotation (BLAST2GO Logic)
# Once BRAKER finishes, you will take the proteins.faa and run BLASTp
# against Metriaclima zebra (Line 549)
blastp -query braker/proteins.fa -db metriaclima_zebra_db \
       -outfmt 6 -evalue 1e-5 -num_threads $THREADS > ortholog_hits.txt
