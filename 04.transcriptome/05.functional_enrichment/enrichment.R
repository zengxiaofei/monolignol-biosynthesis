#!/usr/bin/env Rscript


trinity_id <- commandArgs(T)

library(ggplot2)
library(clusterProfiler)
library(GO.db)
library(enrichplot)

go_anno_df <- read.table("GO.txt", header=T, sep="\t", stringsAsFactors=F)
kegg_anno_df <- read.table("KEGG.txt", header=T, sep="\t", stringsAsFactors=F)

GO_terms_df <- AnnotationDbi::select(GO.db, keys=as.vector(go_anno_df$GO), columns = c("TERM", "ONTOLOGY"), keytype="GOID")


go_df <- cbind(go_anno_df, GO_terms_df)


gene_list_file_go <- paste(trinity_id, "gene_list_GO.txt", sep=".")
gene_list_file_kegg <- paste(trinity_id, "gene_list_KEGG.txt", sep=".")

gene_list_go <- as.character(read.table(gene_list_file_go, header=F, sep="\t")$V2)
gene_list_kegg <- as.character(read.table(gene_list_file_kegg, header=F, sep="\t")$V2)

TERM2GENE_GO <- cbind(go_df$GOID, go_df$Gene_ID_new)
TERM2NAME_GO <- cbind(go_df$GOID, go_df$TERM)

head(kegg_anno_df$ko)
head(kegg_anno_df$pathway)

TERM2GENE_KEGG <- cbind(kegg_anno_df$ko, kegg_anno_df$Gene_ID_new)
TERM2NAME_KEGG <- cbind(kegg_anno_df$ko, kegg_anno_df$pathway)

go_enrich <- enricher(gene_list_go, TERM2GENE=TERM2GENE_GO, TERM2NAME=TERM2NAME_GO)
kegg_enrich <- enricher(gene_list_kegg, TERM2GENE=TERM2GENE_KEGG, TERM2NAME=TERM2NAME_KEGG)

write.table(go_enrich, sep="\t", quote=F, file=paste(trinity_id, "GO.stat", sep="."))
write.table(kegg_enrich, sep="\t", quote=F, file=paste(trinity_id, "KEGG.stat", sep="."))

pdf(file=paste(trinity_id, "mapplot_go.pdf", sep="."), width=8, height=7.1)
emapplot(go_enrich, showCategory=20)
dev.off()

pdf(file=paste(trinity_id, "dotplot_kegg.pdf", sep="."), width=8, height=7.1)
dotplot(kegg_enrich, showCategory=20) 
dev.off()
