#!/bin/bash

~/work/software/trinityrnaseq-2.8.6/util/abundance_estimates_to_matrix.pl \
    --est_method RSEM \
    Spring_Rhizome_1/RSEM.isoforms.results \
    Immature_Inflorescence_1/RSEM.isoforms.results \
    Mature_Leaf_1/RSEM.isoforms.results \
    Vegetative_Shoot_Apex_1/RSEM.isoforms.results \
    Vegetative_Shoot_Sub_Apex_1/RSEM.isoforms.results \
    Emerging_Shoot_sample_1/RSEM.isoforms.results \
    Emerging_Shoot_sample_2/RSEM.isoforms.results \
    Rhizome_Bud_1/RSEM.isoforms.results \
    Preflowering_Apex_1/RSEM.isoforms.results \
    Mature_Inflorescence_1/RSEM.isoforms.results \
    Root_1/RSEM.isoforms.results \
    Spring_Rhizome_May_1/RSEM.isoforms.results \
    Fall_Rhizome_Oct_3/RSEM.isoforms.results \
    Spring_Rhizome_May_2/RSEM.isoforms.results \
    Fall_Rhizome_Oct_2/RSEM.isoforms.results \
    Fall_Rhizome_Oct_1/RSEM.isoforms.results \
    Spring_Rhizome_May_3/RSEM.isoforms.results \
    --gene_trans_map Trinity.fasta.gene_trans_map \
    --name_sample_by_basedir
