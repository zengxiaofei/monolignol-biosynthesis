#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Author: Xiaofei Zeng
# Email: xiaofei_zeng@whu.edu.cn
# Created Time: 2020-05-03 11:04

from __future__ import print_function
import argparse
import collections

def parse_anno_file(anno_file):
    go_dict = collections.defaultdict(list)
    kegg_dict = collections.defaultdict(list)
    gene_name_dict_GO, gene_name_dict_KEGG = {}, {}
    gene_name_order_GO, gene_name_order_KEGG = 0, 0
    with open(anno_file) as f:
        for line in f:
            if not line.strip() or line.startswith('#'):
                continue
            ls = line.split('\t')
            gene_name, GO, KEGG, tax = ls[0].rsplit('_', 1)[0], ls[6], ls[9], ls[17]
            if tax == 'Viridiplantae':
                if GO:
                    gene_name_order_GO += 1
                    gene_name_dict_GO[gene_name] = gene_name_order_GO
                    for GO_num in GO.split(','):
                        go_dict[gene_name].append(GO_num)
                if KEGG:
                    gene_name_order_KEGG += 1
                    gene_name_dict_KEGG[gene_name] = gene_name_order_KEGG
                    for KEGG_num in KEGG.split(','):
                        if KEGG_num.startswith('ko'):
                            kegg_dict[gene_name].append(KEGG_num)
    return go_dict, kegg_dict, gene_name_dict_GO, gene_name_dict_KEGG

def parse_kegg_file(kegg_file):
    kegg_pathway_dict = {}
    with open(kegg_file) as f:
        for line in f:
            if not line.strip():
                continue
            ls = line.strip().split('\t')
            ko = 'ko' + ls[0].replace('path:ath', '')
            pathway = ls[1].replace(' - Arabidopsis thaliana (thale cress)', '')
            kegg_pathway_dict[ko] = pathway
    return kegg_pathway_dict

def output_annotations(go_dict, kegg_dict, gene_name_dict_GO, gene_name_dict_KEGG, kegg_pathway_dict):
    with open('GO.txt', 'w') as f1, open('KEGG.txt', 'w') as f2:
        f1.write('Gene_ID\tGene_ID_new\tGO\n')
        f2.write('Gene_ID\tGene_ID_new\tko\tpathway\n')
        for gene_name, GO_nums in go_dict.iteritems():
            for GO_num in GO_nums:
                f1.write('{}\t{}\t{}\n'.format(gene_name, gene_name_dict_GO[gene_name], GO_num))
        for gene_name, KEGG_nums in kegg_dict.iteritems():
            for KEGG_num in KEGG_nums:
                if KEGG_num in kegg_pathway_dict:
                    f2.write('{}\t{}\t{}\t{}\n'.format(gene_name, gene_name_dict_KEGG[gene_name], KEGG_num, kegg_pathway_dict[KEGG_num]))

def parse_corr_file(corr_file):
    gene_set = set()
    with open(corr_file) as f:
        f.readline()
        for line in f:
            ls = line.split()
            if ls[2] != 'NA' and ls[3] !='NA' and float(ls[2]) >= 0.4 and float(ls[3]) < 0.05:
                gene_set.add(ls[1])
    return gene_set

def output_genelist(corr_file, gene_set, gene_name_dict_GO, gene_name_dict_KEGG):
    prefix = corr_file.replace('_corr.xls', '')
    outfile1 = prefix + '.gene_list_GO.txt'
    outfile2 = prefix + '.gene_list_KEGG.txt'
    with open(outfile1, 'w') as f1, open(outfile2, 'w') as f2:
        for gene_name in gene_set:
            if gene_name in gene_name_dict_GO:
                f1.write('{}\t{}\n'.format(gene_name, gene_name_dict_GO[gene_name]))
            if gene_name in gene_name_dict_KEGG:
                f2.write('{}\t{}\n'.format(gene_name, gene_name_dict_KEGG[gene_name]))

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('anno_file')
    parser.add_argument('kegg_file')
    parser.add_argument('corr_files', nargs='+')
    args = parser.parse_args()

    go_dict, kegg_dict, gene_name_dict_GO, gene_name_dict_KEGG = parse_anno_file(args.anno_file)
    kegg_pathway_dict = parse_kegg_file(args.kegg_file)
    output_annotations(go_dict, kegg_dict, gene_name_dict_GO, gene_name_dict_KEGG, kegg_pathway_dict)
    for corr_file in args.corr_files:
        gene_set = parse_corr_file(corr_file)
        output_genelist(corr_file, gene_set, gene_name_dict_GO, gene_name_dict_KEGG)

if __name__ == '__main__':
    main()
