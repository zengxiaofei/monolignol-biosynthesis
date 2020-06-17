#!/bin/bash

./extract_bam.py longest.bam

for f in *.TRINITY_DN2899_c0_g1_i5.sam;do ./add_RG.py $f;done

for f in addrg*;do samtools view -b $f | samtools sort > ${f%.*}.sorted.bam;done

for f in *.sorted.bam;do ~/work/software/gatk-4.1.7.0/gatk ASEReadCounter --input $f --variant output.filtered_snp_modified.vcf.gz -R Trinity.longest.fasta > ${f}.out;done

./cal_average_depth.py *.sorted.bam.out > CCR1_CCR2.exp.txt
