#!/usr/bin/env Rscript
args <- commandArgs(T)
library(ggplot2)
args <- commandArgs(T)
gene1 <- args[1]
gene2 <- args[2]

md <- read.table("RSEM.gene.TMM.EXPR.annotated.CCR1_2.matrix", header=T)
tmd <- as.data.frame(t(md))


sp <- cor.test(tmd[[gene1]], tmd[[gene2]], method="spearman")
pval <- sp$p.value
rho <- sp$estimate
# print to screen
anno <- paste("Spearman's rho = ", rho, ", p-value = ", pval, sep="")
anno

pval <- signif(pval, 2)
rho <- signif(rho, 2)
anno <- paste("Spearman's rho = ", rho, ", p-value = ", pval, sep="")

pdf(paste(paste(gene1, gene2, sep="_"), ".pdf", sep=""), width=5, height=5)
    ggplot(tmd, aes_string(x=gene1, y=gene2)) + 
        geom_point() + geom_smooth() + 
        annotate("text", -Inf, Inf, label=anno, hjust=-0.5, vjust=2) + 
        theme_bw()
dev.off()
