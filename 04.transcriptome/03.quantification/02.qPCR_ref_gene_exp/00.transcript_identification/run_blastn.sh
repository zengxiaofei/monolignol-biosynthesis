#!/bin/bash

subject=Trinity.fasta
query=ref_primer.fa
out=blastn.out

makeblastdb -dbtype nucl -in ${subject}
blastn \
    -task blastn  -query ${query} -db ${subject} -out ${out} \
    -word_size 4 -num_threads 8 \
    -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle'
