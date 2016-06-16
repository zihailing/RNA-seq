rm (list=ls())

setwd("~/zihailing/zhangxiaolan_20151204/")

raw=read.table("edgeR_prepare_counts.data")

all=data.frame(Fruit5_2_1=raw$V2, Fruit5_2_2=raw$V3, FruitWT_1=raw$V4, FruitWT_2=raw$V5, Vein5_2_1=raw$V6, Vein5_2_2=raw$V7, VeinWT_1=raw$V8, VeinWT_2=raw$V9)
rownames(all)=raw$V1

group= c(rep("Fruit5_2",2),rep("FruitWT",2),rep("Vein5_2",2),rep("VeinWT",2))
library(edgeR)
cds = DGEList(all,group =group)
cds = calcNormFactors(cds)
keep = rowSums(cpm(cds)>1)>=3
cds =cds[keep,]
log2counts = log2(cds$counts+1)
cds=estimateCommonDisp(cds,verbose=TRUE)
cds = estimateTagwiseDisp(cds)
cpmcounts = cpm(cds$counts+1)
tcounts = t(cpmcounts)
pca.total = prcomp(log2(tcounts), retx=TRUE)
############################################################################################################
de.out=exactTest(cds,pair=c("FruitWT","Fruit5_2"))
rawcount = as.matrix(all)[(rownames(topTags(de.out,n=100000))),]
rawcount=rawcount[order(rownames(rawcount)),]
table=topTags(de.out,n=100000)$table
table=table[order(rownames(table)),]
sam_cpm=cpm(cds$count)[row.names(rawcount),]
all=cbind(rawcount,sam_cpm,table)

all=all[order(all$PValue),]
write.table(all,"results12/Fruit.edgeR.out",sep="\t",row.names=T,col.names=F,quote=F)

de.up=subset(all,((all$FDR<0.05) & (all$logFC) >=1))
de.down=subset(all,((all$FDR<0.05) & (all$logFC) <= -1))
write.table(de.up,"results12/Fruit.up",sep="\t",row.names=T,col.names=F,quote=F)
write.table(de.down,"results12/Fruit.down",sep="\t",row.names=T,col.names=F,quote=F)


c1up=nrow(subset(all,((all$FDR<0.05) & (all$logFC) >=1)))
c1down=nrow(subset(all,((all$FDR<0.05) & (all$logFC) <= -1)))
c0.58up=nrow(subset(all,((all$FDR<0.05) & (all$logFC) >=0.58)))
c0.58down=nrow(subset(all,((all$FDR<0.05) & (all$logFC) <= -0.58)))
de.log=matrix(c(c1up,c1down,c0.58up,c0.58down),nrow=2)
write.table(de.log,"results12/Fruit_Cutoff.log",sep="\t",row.names=F,col.names=F,quote=F)
