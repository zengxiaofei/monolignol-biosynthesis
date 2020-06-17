#!/bin/bash

fq1=Mg_all_1.fastq.gz
fq2=Mg_all_2.fastq.gz

total_assembly=Trinity.fasta

total_out=total.bam

bowtie2-build ${total_assembly} ${total_assembly}
# transcript level mapping rate
bowtie2 -p 40 -q --no-unal -k 20 -x ${total_assembly} -1 ${fq1} -2 ${fq2}  \
                 2>total_align_stats.txt | samtools view -@ 10 -Sb -o ${total_out}
