#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Author: Xiaofei Zeng
# Email: xiaofei_zeng@whu.edu.cn
# Created Time: 2020-04-15 15:41

from __future__ import print_function
import argparse
import gzip

def read_gene_list(gene_list):
    gene_dict = {}
    with open(gene_list) as f:
        for line in f:
            if not line.strip():
                continue
            gene_symbol, gene_id = line.split()
            gene_dict[gene_id] = gene_symbol
    return gene_dict

def read_bed_file(bed_file, gene_dict, promoter_len=500):
    promoter_range = {}
    with open(bed_file) as f:
        for line in f:
            if not line.strip():
                continue
            chrm, gstart, gend, gene_id, score, strand = line.split()
            if gene_id in gene_dict:
                gstart = int(gstart)
                gend = int(gend)
                if strand == '+':
                    # 1-based coords
                    promoter_range[gene_id] = [chrm, gstart-promoter_len+1, gstart, strand]
                else:
                    assert strand == '-'
                    promoter_range[gene_id] = [chrm, gend+1, gend+promoter_len, strand]
    return promoter_range

def extract_seqs(genome_file, promoter_range, gene_dict, out_file):
    seq_dict = {}
    comrev_dict = {'A':'T', 'T':'A', 'C':'G', 'G':'C', 'N':'N'}
    with gzip.open(genome_file) as fin, open(out_file, 'w') as fout:
        chrID = ''
        for line in fin:
            if not line.strip():
                continue
            if line.startswith('>'):
                if chrID:
                    seq_dict[chrID] = ''.join(seq_dict[chrID])
                chrID = line.strip()[1:]
                print('handling {}'.format(chrID))
                seq_dict[chrID] = []
            else:
                seq_dict[chrID].append(line.strip())
        seq_dict[chrID] = ''.join(seq_dict[chrID])
    
        for gene_id, p_range in promoter_range.iteritems():
            chrm, pstart, pend, strand = p_range
            if strand == '+':
                promoter_seq = seq_dict[chrm][pstart-1:pend].upper()
            else:
                promoter_seq = ''.join([comrev_dict[base] for base in seq_dict[chrm][pstart-1:pend].upper()[::-1]])
            fout.write('>{1}_{0} {2} {3}-{4}\n{5}\n'.format(gene_id, gene_dict[gene_id], chrm, pstart-1, pend, promoter_seq))

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('gene_list')
    parser.add_argument('bed_file')
    parser.add_argument('genome_file')
    parser.add_argument('out_file')
    args = parser.parse_args()

    gene_dict = read_gene_list(args.gene_list)
    promoter_range = read_bed_file(args.bed_file, gene_dict)
    extract_seqs(args.genome_file, promoter_range, gene_dict, args.out_file)

if __name__ == '__main__':
    main()
