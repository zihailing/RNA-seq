rm (list=ls())

setwd("/psc/home/zihailing/zihailing/zhangxiaolan_20151204")
library(topGO)
TG = function (ID) {
	geneID2GO<-readMappings(file = "/psc/home/zihailing/zihailing/Cucumber/cuc.new.map")
	ALL_gene=rownames(read.table("/psc/home/zihailing/zihailing/zhangxiaolan_20151204/cuc.ID",row.names=1))
	geneList <- factor(as.integer(ALL_gene %in% ID))
	names(geneList)=ALL_gene
	GOdata=new("topGOdata",ontology="MF",allGenes=geneList,annot=annFUN.gene2GO,gene2GO=geneID2GO)
	Term1<-genesInTerm(GOdata)

	GOdata=new("topGOdata",ontology="BP",allGenes=geneList,annot=annFUN.gene2GO,gene2GO=geneID2GO)
	Term2<-genesInTerm(GOdata)

	GOdata=new("topGOdata",ontology="CC",allGenes=geneList,annot=annFUN.gene2GO,gene2GO=geneID2GO)
	Term3<-genesInTerm(GOdata)

	Term=c(Term1,Term2)
	Term=c(Term,Term3)
	Term
}
########################################################################################
up=read.table(file="/psc/home/zihailing/zihailing/zhangxiaolan_20151204/venn/fruit.up")
rownames(up) <-up$V1
up=rownames(up)
down=read.table(file="/psc/home/zihailing/zihailing/zhangxiaolan_20151204/venn/fruit.down")
rownames(down) <-down$V1
down=rownames(down)
GO_up=TG(up)
GO_down=TG(down)

for(i in names(GO_up)){
	write.table(i,file="fruit_GO_up_term_list",append=TRUE,col.names=FALSE,row.names=FALSE,quote=FALSE,eol="\n")
	for(j in GO_up[[i]]){
		write.table(j,file="fruit_GO_up_term_list",append=TRUE,col.names=FALSE,row.names=FALSE,eol="\t",quote=FALSE)
		}
	write.table("\n",file="fruit_GO_up_term_list",append=TRUE,col.names=FALSE,row.names=FALSE,quote=FALSE)
}

for(i in names(GO_down)){
	write.table(i,file="fruit_GO_down_term_list",append=TRUE,col.names=FALSE,row.names=FALSE,quote=FALSE,eol="\n")
	for(j in GO_down[[i]]){
		write.table(j,file="fruit_GO_down_term_list",append=TRUE,col.names=FALSE,row.names=FALSE,eol="\t",quote=FALSE)
		}
	write.table("\n",file="fruit_GO_down_term_list",append=TRUE,col.names=FALSE,row.names=FALSE,quote=FALSE)
}
#######################################################################################

vein_up=read.table(file="/psc/home/zihailing/zihailing/zhangxiaolan_20151204/venn/vein.up")
rownames(vein_up) <-vein_up$V1
vein_up=rownames(vein_up)
vein_down=read.table(file="/psc/home/zihailing/zihailing/zhangxiaolan_20151204/venn/vein.down")
rownames(vein_down) <-vein_down$V1
vein_down=rownames(vein_down)
GO_up_vein=TG(vein_up)
GO_down_vein=TG(vein_down)

for(i in names(GO_up_vein)){
	write.table(i,file="vein_GO_up_term_list",append=TRUE,col.names=FALSE,row.names=FALSE,quote=FALSE,eol="\n")
	for(j in GO_up[[i]]){
		write.table(j,file="vein_GO_up_term_list",append=TRUE,col.names=FALSE,row.names=FALSE,eol="\t",quote=FALSE)
		}
	write.table("\n",file="vein_GO_up_term_list",append=TRUE,col.names=FALSE,row.names=FALSE,quote=FALSE)
}

for(i in names(GO_down_vein)){
	write.table(i,file="vein_GO_down_term_list",append=TRUE,col.names=FALSE,row.names=FALSE,quote=FALSE,eol="\n")
	for(j in GO_down[[i]]){
		write.table(j,file="vein_GO_down_term_list",append=TRUE,col.names=FALSE,row.names=FALSE,eol="\t",quote=FALSE)
		}
	write.table("\n",file="vein_GO_down_term_list",append=TRUE,col.names=FALSE,row.names=FALSE,quote=FALSE)
}
