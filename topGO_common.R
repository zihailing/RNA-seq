rm (list=ls())

setwd("/psc/home/zihailing/zihailing/zhangxiaolan_20151204")
library(topGO)
TG = function (ID) {
	geneID2GO<-readMappings(file = "/psc/home/zihailing/zihailing/Cucumber/cuc.new.map")
	ALL_gene=rownames(read.table("/psc/home/zihailing/zihailing/zhangxiaolan_20151204/cuc.ID",row.names=1))
	geneList <- factor(as.integer(ALL_gene %in% ID))
	names(geneList)=ALL_gene
	GOdata=new("topGOdata",ontology="MF",allGenes=geneList,annot=annFUN.gene2GO,gene2GO=geneID2GO)
	resultFisher <- runTest(GOdata, algorithm = "weight", statistic = "fisher")
	allRes=GenTable(GOdata,pvalue=resultFisher,topNodes=100)
	allRes$pvalue[grep('<',allRes$pvalue)] = "1e-30"
	allRes$pvalue=as.numeric(allRes$pvalue)
	allRes=allRes[order(as.numeric(allRes$pvalue),decreasing=T),]
	allRes$catagory="MF"
	SM=allRes


	GOdata=new("topGOdata",ontology="BP",allGenes=geneList,annot=annFUN.gene2GO,gene2GO=geneID2GO)
	resultFisher <- runTest(GOdata, algorithm = "weight", statistic = "fisher")
	allRes=GenTable(GOdata,pvalue=resultFisher,topNodes=100)
	allRes$pvalue[grep('<',allRes$pvalue)] = "1e-30"
	allRes$pvalue=as.numeric(allRes$pvalue)
	allRes=allRes[order(as.numeric(allRes$pvalue),decreasing=T),]
	allRes$catagory="BP"
	BP=allRes


	GOdata=new("topGOdata",ontology="CC",allGenes=geneList,annot=annFUN.gene2GO,gene2GO=geneID2GO)
	resultFisher <- runTest(GOdata, algorithm = "weight", statistic = "fisher")
	allRes=GenTable(GOdata,pvalue=resultFisher,topNodes=100)
	allRes$pvalue[grep('<',allRes$pvalue)] = "1e-30"
	allRes$pvalue=as.numeric(allRes$pvalue)
	allRes=allRes[order(as.numeric(allRes$pvalue),decreasing=T),]
	allRes$catagory="CC"
	CC=allRes

	OUT=rbind(SM,BP)
	OUT=rbind(OUT,CC)
	OUT
}
up=read.table(file="/psc/home/zihailing/zihailing/zhangxiaolan_20151204/venn/up_gene")
rownames(up) <-up$V1
up=rownames(up)
down=read.table(file="/psc/home/zihailing/zihailing/zhangxiaolan_20151204/venn/down_gene")
rownames(down) <-down$V1
down=rownames(down)
GO_up=TG(up)
GO_down=TG(down)
write.table(GO_up,"common_GO_results/up.go",sep="\t",col.names=T,row.names=F,quote=F)
write.table(GO_down,"common_GO_results/down.go",sep="\t",col.names=T,row.names=F,quote=F)
system("perl ~/zihailing/RNA_seq_script/Topgo_buqi.pl /psc/home/zihailing/zihailing/species_20151012/Ath/GO.terms_and_ids common_GO_results/up.go > common_GO_results/up.go.tmp ")
system("mv common_GO_results/up.go.tmp common_GO_results/up.go")
system("perl ~/zihailing/RNA_seq_script/Topgo_buqi.pl /psc/home/zihailing/zihailing/species_20151012/Ath/GO.terms_and_ids common_GO_results/down.go > common_GO_results/down.go.tmp ")
system("mv common_GO_results/down.go.tmp common_GO_results/down.go")

pdf("common_GO_results/up_go.pdf")
GR=read.table("common_GO_results/up.go",header=T,sep="\t",quote="")
GS=subset(GR,GR$pvalue<0.001)
write.table(GS,"common_GO_results/up.go.sig",sep="\t",col.names=T,row.names=F,quote=F)
PV=as.numeric(GS$pvalue)
names(PV)= GS$Term
func=GS$catagory
GS$catagory=as.vector(GS$catagory)
library(RColorBrewer)
col=brewer.pal(9,"Set1") 
GS$col[GS$catagory=="BP"] <- col[3]
GS$col[GS$catagory=="MF"] <- col[2]
GS$col[GS$catagory=="CC"] <- col[1]
par(mar=c(1,22,5,1))
barplot(-(log10(PV)),cex.names=0.3,width=0.5,space=0.8,las=1,horiz=T,col=GS$col,axes=F,bg="white",border=F,xlim=c(0,max(-(log10(PV)))+1.5),main=expression(paste("-Log10(",italic(P),"-value of GO ),Up")))
#mtext(expression(paste("-Log10(",italic(P),"-value of GO enrichment)")),at=0,side=3,line=1.5,cex=0.6,adj=0)

legend("right",legend=c("GOCC","GOBP","GOMF"),fill=col[c(1,3,2)],bty="n",cex=0.6,border=F)
axis(3,cex.axis=0.6,mgp=c(1,0.5,0),tck=-0.01)
dev.off()

pdf("common_GO_results/down_go.pdf")
GR=read.table("common_GO_results/down.go",header=T,sep="\t",quote="")
GS=subset(GR,GR$pvalue<0.001)
write.table(GS,"common_GO_results/down.go.sig",sep="\t",col.names=T,row.names=F,quote=F)
PV=as.numeric(GS$pvalue)
names(PV)= GS$Term
func=GS$catagory
GS$catagory=as.vector(GS$catagory)
library(RColorBrewer)
col=brewer.pal(9,"Set1") 
GS$col[GS$catagory=="BP"] <- col[3]
GS$col[GS$catagory=="MF"] <- col[2]
GS$col[GS$catagory=="CC"] <- col[1]
par(mar=c(1,22,5,1))
barplot(-(log10(PV)),cex.names=0.3,width=0.5,space=0.8,las=1,horiz=T,col=GS$col,axes=F,bg="white",border=F,xlim=c(0,max(-(log10(PV)))+1),main=expression(paste("-Log10(",italic(P),"-value of GO ),Down")))
#mtext(expression(paste("-Log10(",italic(P),"-value of GO enrichment)")),at=0,side=3,line=1.5,cex=0.6,adj=0)

legend("right",legend=c("GOCC","GOBP","GOMF"),fill=col[c(1,3,2)],bty="n",cex=0.6,border=F)
axis(3,cex.axis=0.6,mgp=c(1,0.5,0),tck=-0.01)
dev.off()
