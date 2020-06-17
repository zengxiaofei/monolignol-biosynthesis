#!/bin/bash

./parse_expression_data.py Lignin_expression_raw.txt > Lignin_relative_expression.txt
./draw_barplot.R Lignin_relative_expression.txt
