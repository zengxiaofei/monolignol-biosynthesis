#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Author: Xiaofei Zeng
# Email: xiaofei_zeng@whu.edu.cn
# Created Time: 2020-04-15 10:57

from __future__ import print_function
import sys

def parse_raw_file(raw_file):
    sample_dict = {}
    with open(raw_file) as f:
        for line in f:
            if not line.strip():
                continue
            ls = line.split()
            if line.startswith('Relative_expression_level'):
                gene_list = ls[1:]
            else:
                sample = ls[0]
                if sample not in sample_dict:
                    sample_dict[sample] = [ls[1:]]
                else:
                    sample_dict[sample].append(ls[1:])
    return sample_dict, gene_list

def output(sample_dict, gene_list):
    for sample, value_list in sample_dict.iteritems():
        exp_list, se_list = value_list
        for n in xrange(len(exp_list)):
            print('{}\t{}\t{}\t{}'.format(gene_list[n], sample, exp_list[n], se_list[n]))

def main():
    sample_dict, gene_list = parse_raw_file(sys.argv[1])
    output(sample_dict, gene_list)

if __name__ == '__main__':
    main()
