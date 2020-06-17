#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Author: Xiaofei Zeng
# Email: xiaofei_zeng@whu.edu.cn
# Created Time: 2020-05-26 14:43

from __future__ import print_function
import sys

def read_sam(sam_file):
    header_str = ''
    line_str = ''
    rg_list = []
    with open(sam_file) as f:
        for line in f:
            if line.startswith('@'):
                header_str += line
            else:
                col1_list = line.split('\t')[0].split(':')
                sra_id = col1_list[0].split('.')[0]
                the_rest = ':'.join(col1_list[1:])
                lane_id = col1_list[2]
                barcode = col1_list[1]
                if [sra_id, lane_id, barcode] not in rg_list:
                    rg_list.append([sra_id, lane_id, barcode])
                new_id = sra_id + the_rest
                line_str += '{0}\t{1}\tRG:Z:{2}.{3}\n'.format(new_id, '\t'.join(line.split('\t')[1:]).strip(), sra_id, lane_id)
    return header_str, line_str, rg_list

def output_sam(sam_file, header_str, line_str, rg_list):
    with open('addrg.'+sam_file, 'w') as f:
        f.write(header_str)
        for [sra_id, lane_id, barcode] in rg_list:
            f.write('@RG\tID:{0}.{1}\tPL:ILLUMINA\tPU:{2}.{1}\tLB:LIB-{3}-1\tSM:SAMPLE_{3}\n'.format(sra_id, lane_id, sra_id+barcode, sra_id))
        f.write(line_str)

def main():
    header_str, line_str, rg_list = read_sam(sys.argv[1])
    output_sam(sys.argv[1], header_str, line_str, rg_list)

if __name__ == '__main__':
    main()
