#!/bin/bash
# Manuscript Ref: Lines 543-545
# Step: De-novo TE annotation and masking

GENOME="../../results/01_assembly/Asta_v3_polished.fasta"
THREADS=32

# 1. Run EDTA
# EDTA is a comprehensive pipeline that integrates RepeatModeler, LTR_Finder, etc.
# --species: Others (Cichlid)
# --anno 1: Perform annotation
EDTA.pl --genome $GENOME --species others --step all --anno 1 --threads $THREADS

# 2. Soft-masking for BRAKER
# BRAKER prefers soft-masked genomes (repeats in lowercase)
# EDTA generates a .masked file automatically.
cp ${GENOME}.mod.EDTA.anno/${GENOME}.mod.masked ../../results/02_annotation/Asta_softmasked.fa
