#!/bin/bash
# Manuscript Ref: Lines 563-571
# Step: Hi-C interaction profiles and B-specific marker validation

# --- Variables ---
THREADS=12
REF="../../results/01_assembly/Asta_v3_polished.fasta"
B_MARKERS="../../metadata/B_markers_validated.fasta"
HIC_PRO_MATRIX="../../results/04_3d_genome/matrix_10k.h5"
OUT_DIR="../../results/03_b_id"

# 1. Hi-C Interaction Analysis
# Identifying unplaced scaffolds with high interaction to the B super-scaffold
# This logic prepares data for the Wilcoxon rank-sum test mentioned in line 565
echo "Extracting interaction frequencies from Hi-C matrix..."
hicInfo -m $HIC_PRO_MATRIX --outFileName $OUT_DIR/matrix_stats.txt

# 2. B-Marker Validation (BLASTn)
# Manuscript: Hit identity > 95% is considered evidence of correct assembly
echo "Validating B-scaffolds against FISH-mapped markers..."
makeblastdb -in $REF -dbtype nucl
blastn -query $B_MARKERS -db $REF -outfmt 6 \
       -perc_identity 95 -num_threads $THREADS > $OUT_DIR/B_marker_validation_results.txt

# 3. Filter significant hits
awk '$3 >= 95 {print $0}' $OUT_DIR/B_marker_validation_results.txt > $OUT_DIR/B_scaffolds_confirmed.txt
