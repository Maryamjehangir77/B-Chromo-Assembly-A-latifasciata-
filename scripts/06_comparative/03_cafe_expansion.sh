#!/bin/bash
# Step: Gene family expansion/contraction analysis

# --- Variables ---
GENE_COUNTS="./OrthoFinder/Results_*/Orthogroups/Orthogroups.GeneCount.tsv"
SPECIES_TREE="./OrthoFinder/Results_*/Species_Tree/SpeciesTree_rooted_node_labels.txt"

# 1. Run CAFE
# Parameters: p-value 0.05 
cafe -t $SPECIES_TREE -f $GENE_COUNTS -p 0.05 -o cafe_results

# 2. Enrichment Analysis (Fisher’s Exact Test)
# This logic identifies if expanded families are enriched for specific GO terms
# Manuscript Ref: BLAST2GO (Line 616)
python3 scripts/06_comparative/filter_significant_families.py \
    --input cafe_results/summary.txt \
    --pvalue 0.05 > expanded_families_sig.txt
