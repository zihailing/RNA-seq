pdf("common_GO_results/up_go_filter.pdf")
GS=read.table("common_GO_results/up.filter.go",header=T,sep="\t",quote="")
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
