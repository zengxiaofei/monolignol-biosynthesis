#!/bin/bash

python -m jcvi.compara.synteny screen --simple Atr.Sbi.anchors Atr.Sbi.anchors.new
python -m jcvi.compara.synteny screen --simple Ath.Atr.anchors Ath.Atr.anchors.new
python -m jcvi.graphics.karyotype seqids layout --figsize=12x8
