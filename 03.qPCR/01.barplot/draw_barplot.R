#!/usr/bin/env Rscript

library(ggplot2)
args <- commandArgs(T)
md <- read.table(args[1], sep="\t", header=F)
md$V1 <- factor(md$V1, levels=c(
    "MgPAL1", "MgPAL2", "MgPAL3", "MgPAL4", 
    "MgPAL5", "MgC4H1", "MgC4H2", "Mg4CL1", 
    "Mg4CL2", "Mg4CL3", "Mg4CL4",
    "MgHCT1", "MgHCT2", "MgC3H1", "MgC3H2",
    "MgCCoAOMT1", "MgCCoAOMT2", "MgCCoAOMT3",
    "MgCCoAOMT4", "MgCCoAOMT5", "MgCCR1", 
    "MgCCR2", "MgCCR3", "MgCCR4", "MgF5H", 
    "MgCOMT", "MgCAD"))
md$V2 <- factor(md$V2, levels=c(
    "L1", "L3", "L5", "S", "R", "B", "N", 
    "IN12", "IN34","IN56"))

pdf("barplot.pdf", width=8, height=12)
ggplot(
    md, aes(x=V2, y=V3)) + 
    geom_bar(aes(fill=V2),stat="identity", color="black") + 
    geom_errorbar(aes(ymax=V3+V4, ymin=V3-V4), width=0.5) + 
    scale_fill_brewer(palette="Set3") + 
    facet_wrap(~V1, scales="free", nrow=7) + 
    theme_bw() + 
    theme(
        axis.ticks.x=element_blank(), 
        axis.text.x=element_blank(), 
        strip.text=element_text(face = "italic")) + 
    labs(x="", y="Relative expression levels", fill = "Organs")
dev.off()
