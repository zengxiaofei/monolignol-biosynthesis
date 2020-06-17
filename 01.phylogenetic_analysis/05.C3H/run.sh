#!/bin/bash

pep=All_C3H.fa
mafft --maxiterate 1000 --localpair --clustalout ${pep} > ${pep}.aln
iqtree -s ${pep}.aln -B 1000 --bnni -T 8
