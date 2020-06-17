#!/bin/bash

./cal_correlation.R

./enrichment_analysis_prepare.py Mgi_trinity.emapper.CCR1_2.annotations kegg_pathway.txt \
    TRINITY_DN4578_c0_g1_corr.xls TRINITY_DN11387_c1_g1_corr.xls \
    TRINITY_DN2860_c0_g1_corr.xls TRINITY_DN17315_c0_g1_corr.xls \
    TRINITY_DN5957_c0_g1_corr.xls TRINITY_DN6480_c0_g1_corr.xls \
    TRINITY_DN1868_c0_g1_corr.xls TRINITY_DN93_c0_g1_corr.xls \
    TRINITY_DN2899_c0_g1_1_corr.xls TRINITY_DN2899_c0_g1_2_corr.xls \
    TRINITY_DN3932_c0_g1_corr.xls TRINITY_DN4085_c0_g1_corr.xls \
    TRINITY_DN308_c0_g1_corr.xls TRINITY_DN4962_c0_g1_corr.xls

./enrichment.R TRINITY_DN4578_c0_g1
