#!/usr/bin/env Rscript

library(ggplot2)
library(reshape2)
md <- read.table("qPCR_reference_gene_exp.txt", header=T)
md2 <- melt(md)

pdf("qPCR_reference_gene_exp.pdf", width=5, height=5)
ggplot(md2, aes(x=variable, y=value)) + 
    geom_bar(aes(fill=Ref_gene), stat="identity", position="stack") + 
    scale_fill_brewer(palette="Set1") + ylim(0, 25000) +
    theme_bw() + theme(axis.text.x = element_text(angle = 45, vjust=1, hjust=1)) +
    xlab("Samples") + ylab("TMM normalized TPMs")
dev.off()

