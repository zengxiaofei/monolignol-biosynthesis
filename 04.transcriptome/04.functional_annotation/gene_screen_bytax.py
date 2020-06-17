#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Author: Xiaofei Zeng
# Email: xiaofei_zeng@whu.edu.cn
# Created Time: 2020-04-28 10:02

from __future__ import print_function
import sys

def read_anno_file(anno_file):
    gene_set = set()
    with open(anno_file) as f:
        for line in f:
            if not line.strip() or line.startswith('#'):
                continue
            ls = line.split('\t')
            isoform_id = ls[0]
            gene_id = isoform_id.rsplit('_', 1)[0]
            tax = ls[17]
            if tax == 'Viridiplantae':
                gene_set.add(gene_id)
    return gene_set

def screen_matrix(mat_file, gene_set):
    with open(mat_file) as f:
        print(f.readline(), end='')
        for line in f:
            ls = line.split()
            if ls[0] in gene_set:
                print(line, end='')

def main():
    gene_set = read_anno_file(sys.argv[1])
    screen_matrix(sys.argv[2], gene_set)

if __name__ == '__main__':
    main()
