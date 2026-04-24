#!/bin/bash
# Manuscript Ref: Lines 597-599
# Step: RNA-seq alignment to Asta_v3 genome

# --- Variables ---
STAR_EXEC="/storage/maryam/softwares/STAR-2.7.3a/bin/Linux_x86_64_static/STAR"
GENOME_DIR="../../metadata/star_index"
GENOME_FASTA="../../results/01_assembly/Asta_v3_polished.fasta"
THREADS=12

mkdir -p $GENOME_DIR

# 1. Genome Indexing
# Using --genomeSAindexNbases 10 as per your optimized command
$STAR_EXEC --runThreadN 24 --runMode genomeGenerate \
           --genomeDir $GENOME_DIR \
           --genomeFastaFiles $GENOME_FASTA \
           --genomeSAindexNbases 10

# 2. Alignment Function
# Processes paired-end reads and outputs sorted BAM files
run_star() {
    local prefix=$1
    local r1=$2
    local r2=$3
    echo "Processing $prefix..."
    $STAR_EXEC --runMode alignReads --runThreadN $THREADS \
               --genomeDir $GENOME_DIR \
               --readFilesIn $r1 $r2 \
               --outFileNamePrefix "../../results/05_expression/${prefix}_" \
               --outSAMtype BAM SortedByCoordinate
}

# 3. Sample Execution (Example calls)
# Logic: You can list all your tissue/sex combinations here
run_star "0B_Brain_Female" "AL44BrTr_1.fq" "AL44BrTr_2.fq"
run_star "B+_Brain_Female" "AL23BrTr_1.fq" "AL23BrTr_2.fq"

