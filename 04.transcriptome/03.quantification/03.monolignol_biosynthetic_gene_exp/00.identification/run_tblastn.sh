#!/bin/bash

subject=Trinity.fasta
query=Lignin_genes.fa
out=tblastn.out

makeblastdb -dbtype nucl -in ${subject}
tblastn \
    -query ${query} -db ${subject} -out ${out} \
    -evalue 1e-5 -num_threads 8 \
    -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle'
