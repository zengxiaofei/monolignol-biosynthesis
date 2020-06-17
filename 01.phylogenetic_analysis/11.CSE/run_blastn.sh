#!/bin/bash

makeblastdb -dbtype nucl -in Msinensis_497_v7.0.softmasked.fa -out Msi
blastn -task blastn -db Msi -query CSE.fa -evalue 1e-5 -outfmt 6 -out Msi_CSE.out
makeblastdb -dbtype nucl -in GCA_002993905.1_Msac_v3_genomic.fna -out Msa
blastn -task blastn -db Msa -query CSE.fa -evalue 1e-5 -outfmt 6 -out Msa_CSE.out
