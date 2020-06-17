#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Author: Xiaofei Zeng
# Email: xiaofei_zeng@whu.edu.cn
# Created Time: 2020-05-11 15:17

from __future__ import print_function
import sys

def read_corr_file(corr_file):
    m = 0
    with open(corr_file) as f:
        f.readline()
        for n, line in enumerate(f, 1):
            ls = line.split()
            if 'NA' in (ls[2], ls[3]):
                continue
            if float(ls[2]) > 0.3 and float(ls[3]) < 0.05:
                m += 1
    return n, m

def main():
    n, m = read_corr_file(sys.argv[1])
    print('for file: {}'.format(sys.argv[1]))
    print('all: {}; corr: {}; ratio: {}%'.format(n, m, float(m)/n*100))

if __name__ == '__main__':
    main()
