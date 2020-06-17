#!/usr/bin/env Rscript

num <- as.numeric(commandArgs(T))

phyper(num[1], num[2], num[3], num[4], lower.tail=F)
