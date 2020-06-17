#!/usr/bin/env Rscript

md <- read.table("RSEM.gene.TMM.EXPR.annotated.CCR1_2.matrix", header=T)
args <- commandArgs(T)
tmd <- as.data.frame(t(md))

cal_corr <- function(tmd, gene_id) {
    df <- data.frame()
    for ( g in colnames(tmd) ) {
        sp <- cor.test(tmd[[gene_id]], tmd[[g]], method="spearman")
        df <- rbind(df, as.data.frame(t(c(gene_id, g, sp$estimate, sp$p.value))))
    }
    qvalue <- as.data.frame(p.adjust(df$V4, method="fdr"))
    df <- cbind(df, qvalue)
    names(df) <- c("Gene1", "Gene2", "Spearman's_rho", "p_value", "FDR")
    write.table(df, file=paste(gene_id, "_corr.txt", sep=""), row.names=F, sep="\t", quote=F)
}

lignin_genes <- c("TRINITY_DN4578_c0_g1", "TRINITY_DN11387_c1_g1",
                  "TRINITY_DN2860_c0_g1", "TRINITY_DN17315_c0_g1",
                  "TRINITY_DN5957_c0_g1", "TRINITY_DN6480_c0_g1",
                  "TRINITY_DN1868_c0_g1", "TRINITY_DN93_c0_g1",
                  "TRINITY_DN2899_c0_g1_1", "TRINITY_DN2899_c0_g1_2",
                  "TRINITY_DN3932_c0_g1", "TRINITY_DN4085_c0_g1", 
                  "TRINITY_DN308_c0_g1", "TRINITY_DN4962_c0_g1")
for ( gene_id in lignin_genes ) {
    cal_corr(tmd, gene_id)
}
