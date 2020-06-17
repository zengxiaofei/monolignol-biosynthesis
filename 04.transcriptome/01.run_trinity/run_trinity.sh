#!/bin/bash

fq1=../00.data/Mg_all_1.fastq.gz
fq2=../00.data/Mg_all_2.fastq.gz
threads=80

Trinity --seqType fq --max_memory 1000G --left ${fq1} --right ${fq2} --CPU 80
