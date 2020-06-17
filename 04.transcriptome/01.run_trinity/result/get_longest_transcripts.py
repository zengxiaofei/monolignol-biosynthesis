#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Author: Xiaofei Zeng
# Email: xiaofei_zeng@whu.edu.cn
# Created Time: 2020-04-21 15:58

from __future__ import print_function
import argparse
import gzip

def read_trinity_assembly(assembly_file):
    longest_transcripts_dict = {}
    with gzip.open(assembly_file) as f:
        for line in f:
            if not line.strip():
                continue
            if line.startswith('>'):
                ls = line.split()
                isoform_id = ls[0][1:]
                gene_id = isoform_id.rsplit('_', 1)[0]
                length = int(ls[1].split('=')[1])
                if gene_id in longest_transcripts_dict:
                    if length > longest_transcripts_dict[gene_id][1]:
                        longest_transcripts_dict[gene_id] = [isoform_id, length]
                else:
                    longest_transcripts_dict[gene_id] = [isoform_id, length]
    return longest_transcripts_dict

def output_longest_transcripts(assembly_file, longest_transcripts_dict, out_file):
    with gzip.open(assembly_file) as fin, gzip.open(out_file, 'w') as fout:
        for line in fin:
            if not line.strip():
                continue
            if line.startswith('>'):
                ls = line.split()
                isoform_id = ls[0][1:]
                gene_id = isoform_id.rsplit('_', 1)[0]
                if isoform_id == longest_transcripts_dict[gene_id][0]:
                    output = True
                    fout.write(line)
                else:
                    output = False
            elif output:
                fout.write(line)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('assembly_file')
    parser.add_argument('out_file')
    args = parser.parse_args()

    longest_transcripts_dict = read_trinity_assembly(args.assembly_file)
    output_longest_transcripts(args.assembly_file, longest_transcripts_dict, args.out_file)

if __name__ == '__main__':
    main()
