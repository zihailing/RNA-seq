#!/bin/sh
for FILE in *-*/*MAP/*.name.sam
do
	cat $FILE|awk '{ if ($9 > 0&& $9<500) { N+=1; S+=$9; S2+=$9*$9 }} END { M=S/N; print "n="N, "mean="M, "stdev="sqrt ((S2-M*M*N)/(N-1))}' >>insert_size_sd.txt
done
