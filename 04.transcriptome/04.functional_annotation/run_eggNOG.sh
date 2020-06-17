#!/bin/bash

emapper.py -i Trinity.longest.fasta --output Mgi_trinity -m diamond --translate --cpu 8
./gene_screen_bytax.py RSEM.gene.TMM.EXPR.matrix RSEM.gene.TMM.EXPR.annotated.matrix
