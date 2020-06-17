#!/usr/bin/env Rscript
library(ggplot2)
library(reshape2)
md1 <- read.table("verification_exp.txt", header=T)
md2 <- melt(md1)
md2$Genes <- factor(md2$Genes, levels=c(
             "TRINITY_DN4578_c0_g1(MgPAL1)",
             "TRINITY_DN11387_c1_g1(MgPAL5)",
             "TRINITY_DN2860_c0_g1(Mg4CL1)",
             "TRINITY_DN17315_c0_g1(Mg4CL3)",
             "TRINITY_DN5957_c0_g1(MgHCT1)",
             "TRINITY_DN6480_c0_g1(MgHCT2)",
             "TRINITY_DN1868_c0_g1(MgCCoAOMT1)",
             "TRINITY_DN93_c0_g1(MgCCoAOMT3)",
             "TRINITY_DN2899_c0_g1_allele1(MgCCR1)", 
             "TRINITY_DN2899_c0_g1_allele2(MgCCR2)"))
md2$Groups <- factor(md2$Groups, levels=c("PAL", "4CL", "HCT", "CCoAOMT", "CCR"))
md2$variable <- factor(md2$variable, levels=c(
                "Mature_Leaf", "Emerging_Shoot_sample_1", 
                "Emerging_Shoot_sample_2", "Vegetative_Shoot_Apex", 
                "Vegetative_Shoot_Sub_Apex", "Preflowering_Apex", 
                "Immature_Inflorescence", "Mature_Inflorescence"))
pdf("verification_exp.pdf", width=8, height=7)
ggplot(md2, aes(x=variable, y=value)) + 
    geom_bar(aes(fill=Genes), stat="identity", color="black", position="dodge") +
    xlab("Samples") + ylab("TMM-normalized TPMs") +
    scale_fill_brewer(palette="Paired", direction=-1) + theme_bw() + 
    theme(axis.text.x = element_text(
        angle = 30, vjust=1, hjust=1), strip.text=element_text(face = "italic")) +
    facet_grid(Groups~., scales="free") 
dev.off()
