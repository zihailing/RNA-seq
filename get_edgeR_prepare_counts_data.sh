#!/bin/sh
paste *-*/*MAP/htseq_out.txt >edgeR_prepare_counts.data1
head -n 23248 edgeR_prepare_counts.data1 >edgeR_prepare_counts.data2
cut -f 1,2,4,6,8,10,12,14,16 edgeR_prepare_counts.data2 >edgeR_prepare_counts.data
rm edgeR_prepare_counts.data1 edgeR_prepare_counts.data2
