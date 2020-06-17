#!/bin/bash

transcripts=Trinity.fasta
samples_file=samples.txt.h
threads=40

/work/med-zengxf/work/software/trinityrnaseq-2.8.6/util/align_and_estimate_abundance.pl \
        --transcripts ${transcripts} \
        --seqType fq \
        --samples_file ${samples_file} \
        --est_method RSEM \
        --aln_method bowtie2 \
        --trinity_mode \
        --thread_count ${threads}
