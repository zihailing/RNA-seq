#!/bin/bash
####################################################################
#
#A (quite) simple submit script for a one or tow processor job
#
####################################################################
#
# SGE options
#
#Change to the current working directory upon starting of the job
#$ -cwd
#
source ~/.profile
# Specify the kind of shell script you use, for example, bash
#$ -S /bin/bash
#
# join the error and standard output streams
#$ -j y
#
#
# don't flood myself with e-mail
#$ -m e
#
# this is my e-mail address
##$ -M zihailing@live.cn
#
#where the format error go
#$ -e /psc/home/zihailing
#where the format output go
#$ -o /psc/home/zihailing
# notify me about pending SIG_STOP and SIG_KILL
#$ -notify
#
# Specify the array start ,end , step
#$ -t 1-8:1 
# end of SGE stuff
#########################################################
# now execute my job:
ARRAY=( head Fruit5-2-1 Fruit5-2-2 FruitWT-1 FruitWT-2 Vein5-2-1 Vein5-2-2 VeinWT-1 VeinWT-2 )
# end of job script
DIR=/psc/home/zihailing/zihailing/zhangxiaolan_20151204/
REF=/psc/home/zihailing/zihailing/Cucumber/Cucumber
GTF=/psc/home/zihailing/zihailing/Cucumber/Cucumber.gtf
mkdir -p $DIR/${ARRAY[$SGE_TASK_ID]}/${ARRAY[$SGE_TASK_ID]}MAP
/psc/program/install/tophat-2.0.10/bin/tophat -p 28 -G $GTF -o $DIR/${ARRAY[$SGE_TASK_ID]}/${ARRAY[$SGE_TASK_ID]}MAP $REF $DIR/${ARRAY[$SGE_TASK_ID]}/Len_sort_step_4/${ARRAY[$SGE_TASK_ID]}_1.fq.gz.fq.trimmed.cut.paired1 $DIR/${ARRAY[$SGE_TASK_ID]}/Len_sort_step_4/${ARRAY[$SGE_TASK_ID]}_1.fq.gz.fq.trimmed.cut.paired2
/psc/program/install/samtools-0.1.19/samtools sort -n $DIR/${ARRAY[$SGE_TASK_ID]}/${ARRAY[$SGE_TASK_ID]}MAP/accepted_hits.bam $DIR/${ARRAY[$SGE_TASK_ID]}/${ARRAY[$SGE_TASK_ID]}MAP/accepted_hits.name
/psc/program/install/samtools-0.1.19/samtools view -h $DIR/${ARRAY[$SGE_TASK_ID]}/${ARRAY[$SGE_TASK_ID]}MAP/accepted_hits.name.bam > $DIR/${ARRAY[$SGE_TASK_ID]}/${ARRAY[$SGE_TASK_ID]}MAP/accepted_hits.name.sam
/psc/program/install/python-2.7.6/bin/htseq-count -f sam -r name  -s no -q $DIR/${ARRAY[$SGE_TASK_ID]}/${ARRAY[$SGE_TASK_ID]}MAP/accepted_hits.name.sam $GTF > $DIR/${ARRAY[$SGE_TASK_ID]}/${ARRAY[$SGE_TASK_ID]}MAP/htseq_out.txt
#  /psc/program/install/samtools-0.1.19/samtools index $DIR/${ARRAY[$SGE_TASK_ID]}MAP/accepted_hits.bam
#  /psc/program/install/samtools-0.1.19/samtools depth $DIR/${ARRAY[$SGE_TASK_ID]}MAP/accepted_hits.bam -Q 10 > $TMP/depth
