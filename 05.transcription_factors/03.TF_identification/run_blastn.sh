#!/bin/bash

subject=Trinity.longest.fasta
query1=ZmMYB.fa
query2=MsMYB.fa
query3=ZmNAC.fa
query4=ZmERF.fa
query5=ZmWRKY.fa
query6=PvERF.fa
out1=ZmMYBblastn.out
out2=MsMYBblastn.out
out3=ZmNACblastn.out
out4=ZmERFblastn.out
out5=ZmWRKYblastn.out
out6=PvERFblastn.out

makeblastdb -dbtype nucl -in ${subject}
blastn \
    -query ${query1} -db ${subject} -out ${out1} \
    -evalue 1e-5 -num_threads 8 \
    -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle'
blastn \
    -query ${query2} -db ${subject} -out ${out2} \
    -evalue 1e-5 -num_threads 8 \
    -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle'
blastn \
    -query ${query3} -db ${subject} -out ${out3} \
    -evalue 1e-5 -num_threads 8 \
    -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle'
blastn \
    -query ${query4} -db ${subject} -out ${out4} \
    -evalue 1e-5 -num_threads 8 \
    -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle'
blastn \
    -query ${query5} -db ${subject} -out ${out5} \
    -evalue 1e-5 -num_threads 8 \
    -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle'
blastn \
    -query ${query6} -db ${subject} -out ${out6} \
    -evalue 1e-5 -num_threads 8 \
    -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle'
