# Step: Differential Expression with edgeR

library(edgeR)

# 1. Load Data
counts <- read.table("../../results/05_expression/counts/b_gene_counts_matrix.txt", header=TRUE, row.names=1)
group <- factor(c(rep("0B", 3), rep("1B", 3))) # Update based on your sample sheet

# 2. Filtering and Normalization
dge <- DGEList(counts=counts, group=group)
keep <- filterByExpr(dge) # CPM > 1 logic
dge <- dge[keep, , keep.lib.sizes=FALSE]
dge <- calcNormFactors(dge)

# 3. Statistical Testing
dge <- estimateDisp(dge)
et <- exactTest(dge)

# 4. Filter by Manuscript Thresholds (logFC 1.5, FDR 0.05)
results <- topTags(et, n=Inf)$table
de_genes <- results[abs(results$logFC) >= 1.5 & results$FDR <= 0.05, ]

write.csv(de_genes, "../../results/05_expression/DE_B_linked_genes.csv")
