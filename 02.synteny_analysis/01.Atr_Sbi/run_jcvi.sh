#!/bin/bash

python -m jcvi.compara.catalog ortholog \
    --no_strip_names --dbtype=prot \
    --nochpf --nostdpf Atr Sbi
