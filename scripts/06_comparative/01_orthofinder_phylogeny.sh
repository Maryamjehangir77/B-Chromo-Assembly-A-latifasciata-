#!/bin/bash
# Manuscript Ref: Lines 607-612
# Step: Orthogroup clustering and Phylogeny

# --- Variables ---
PROTEOME_DIR="../../data/comparative/proteomes" # 11 cichlids + 5 outgroups
THREADS=24

# 1. Run OrthoFinder2
# Uses DIAMOND for high-speed protein alignment (Line 609)
orthofinder -f $PROTEOME_DIR -t $THREADS -S diamond -M msa

# 2. Alignment Trimming (TrimAl)
# Ref: Line 611 - Preparing for RAxML/IQ-TREE
for aln in ./OrthoFinder/Results_*/MultipleSequenceAlignments/*.fa; do
    trimal -in $aln -out ${aln}.trimmed -automated1
done

# 3. Phylogenetic Inference (IQ-TREE)
# Ref: Line 612 - Using ModelFinder to find the best substitution model
iqtree -s ./OrthoFinder/Results_*/Species_Tree/SpeciesTree_rooted.txt \
       -m MFP -bb 1000 -nt AUTO
