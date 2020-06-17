#!/usr/bin/env Rscript
library(pheatmap)
mydata <- read.table("Lignin_expression.txt",header=T,sep="\t")
rownames(mydata) = c(
    "MgPAL1", "MgPAL2", "MgPAL3", "MgPAL4",
    "MgPAL5", "MgC4H1", "MgC4H2", "Mg4CL1",
    "Mg4CL2", "Mg4CL3", "Mg4CL4",
    "MgHCT1", "MgHCT2", "MgC3H1", "MgC3H2",
    "MgCCoAOMT1", "MgCCoAOMT2", "MgCCoAOMT3",
    "MgCCoAOMT4", "MgCCoAOMT5", "MgCCR1",
    "MgCCR2", "MgCCR3", "MgCCR4", "MgF5H", "MgCOMT",
    "MgCAD")

annotation_row = data.frame(Groups=factor(rep(c("Other_genes", "Genes_relatively_highly_expressed_in_internodes"), c(13,14))))
rownames(annotation_row) = c(
    "MgPAL4", "MgC4H2", "Mg4CL4", "MgC3H2",
    "MgC4H1", "MgCCoAOMT4", "MgCCoAOMT2",
    "MgCCR4", "MgCCoAOMT5", "MgPAL2", "Mg4CL2",
    "MgPAL3", "MgCCR3", "MgHCT1", "MgPAL1",
    "MgPAL5", "MgCCR2", "MgCAD", "Mg4CL1",
    "MgC3H1", "Mg4CL3", "MgCOMT", "MgHCT2",
    "MgCCR1", "MgCCoAOMT3", "MgCCoAOMT1",
    "MgF5H")
annotation_colors=list(Groups=c(
   Other_genes="#a0dcae", 
   Genes_relatively_highly_expressed_in_internodes="#ae91c8"))

color_range <- seq(-4, 4, by=0.1)
library(RColorBrewer)
pheatmap(
    color = colorRampPalette(rev(brewer.pal(n=7, name="RdYlBu")))(length(color_range)),
    log2(mydata), cluster_cols = F, legend_breaks=seq(-4,4,2), breaks=color_range,
    #display_numbers=T, number_format="%.2f", 
    border_color=NA, cellwidth=30, cellheight=15,
    annotation_row=annotation_row, 
    annotation_colors=annotation_colors, 
    filename="heatmap.pdf")
