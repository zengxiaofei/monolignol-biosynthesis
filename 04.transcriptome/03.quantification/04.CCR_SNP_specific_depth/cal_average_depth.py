#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Author: Xiaofei Zeng
# Email: xiaofei_zeng@whu.edu.cn
# Created Time: 2020-05-27 11:05

from __future__ import print_function
import argparse

def read_out(out_files):
    # 1 means reverse, 0 means as the same order
    allele_dict = {'262':1, '357':1, '388':1, '405':1, 
                   '407':1, '576':0, '663':0, '1128':0, 
                   '1248':0, '1272':0, '1309':0, '1335':0, 
                   '1479':1, '1561':0, '1607':0}
    sample_dict = {'SRR1734721':'Leaf_WHU', 'SRR871063':'Vegetative_Shoot_Sub_Apex',
            'SRR871064':'Preflowering_Apex', 'SRR871065':'Spring_Rhizome', 
            'SRR871066':'Rhizome_Bud', 'SRR871067':'Root', 
            'SRR871068':'Emerging_Shoot_sample_1', 'SRR871069':'Emerging_Shoot_sample_2',
            'SRR871070':'Vegetative_Shoot_Apex', 'SRR871071':'Immature_Inflorescence',
            'SRR871072':'Mature_Inflorescence', 'SRR871073':'Mature_Leaf', 
            'SRR934029':'Spring_Rhizome_May_1', 'SRR934030':'Spring_Rhizome_May_2',
            'SRR934031':'Spring_Rhizome_May_3', 'SRR934032':'Fall_Rhizome_Oct_1',
            'SRR934033':'Fall_Rhizome_Oct_2', 'SRR934034':'Fall_Rhizome_Oct_3'}

    for out_file in out_files:
        exp_dict = {'CCR1':0, 'CCR2':0}
        with open(out_file) as f:
            f.next()
            for line in f:
                ls = line.split()
                if allele_dict[ls[1]]:
                    exp_dict['CCR1'] += int(ls[6])
                    exp_dict['CCR2'] += int(ls[5])
                else:
                    exp_dict['CCR1'] += int(ls[5])
                    exp_dict['CCR2'] += int(ls[6])
        sra = out_file.split('.')[1]
        print('{0}\t{1}\t{2}\t{3}'.format(sra, sample_dict[sra],exp_dict['CCR1'], exp_dict['CCR2']))

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('out_files', nargs='+')
    args = parser.parse_args()

    read_out(args.out_files)

if __name__ == '__main__':
    main()
