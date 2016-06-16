setwd("/psc/home/zihailing/zihailing/zhangxiaolan_20151204/GO_20160427")
#par(mfrow=c(2,2))
go_bar <- function(x){
  # x <- "N3_vs_N1.fdr5"
  base <-x
  pdf(paste(base,"top5.Go.pdf",sep=""),width=15,height=10)
  library(RColorBrewer)
 #layout(matrix(1,2), widths=lcm(15), heights=lcm(8))
  # BASE GO TERMS PROPORTIONS
  par(mfrow=c(2,1),mar=c(1,40,6,3))
  #par(mar=c(1,35,6,6))
  t1<-read.table(file=paste(base,"_up.go",sep=""),header=T,sep="\t",quote="\"",row.names=1)
  tt <- head(t1[order(t1$pvalue,decreasing = F),],n=5)
  tt <- tt[order(tt$pvalue,decreasing=T),]
  write.table(file=paste(base,".top5.txt",sep=""), 
              tt,sep="\t",quote=F)
  #tt <- subset(t1,pvalue<0.0)
  go<-tt$Term
  pvalue<- as.numeric(tt$pvalue)
  names(pvalue) <-go
  func<-tt$term_type
  as.vector(tt$term_type) -> tt$term_type
  brewer.pal(9,"Set1") ->col
  #tt$col[tt$term_type=="BP"] <- col[3]
  #tt$col[tt$term_type=="MF"] <-col[2] 
  #tt$col[tt$term_type=="CC"] <- col[1]
  library(pheatmap)
  colorRampPalette(c("yellow","red"))(100) ->col1
  #pheatmap(-(log10(pvalue)),color=col1,cluster_rows= F, ,legend=F,cellwidth=20,cellheight=20,cluster_cols = F,show_colnames=F,show_rownames=T,fontsize = 20)

  barplot(-(log10(pvalue)),cex.names=2,width=0.5,space=1.55,las=1,horiz=T,col=col[2],axes=F,bg="white",border=F,xlim=c(0,max(-(log10(pvalue)))+1))
  #legend("right",legend=c("GOBP","GOMF","GOCC"),fill=col[c(3,2,1)],bty="n",cex=0.6,border=F)
  #legend(x=3,y=36,legend=c("GOBP","GOMF","GOCC"),fill=col[c(3,2,1)],bty="n",cex=0.6,border=F)
  axis(3,cex.axis=1.6,mgp=c(1,0.5,0),tck=-0.01)
  #mtext("-log10(pvalue)",side=1,line=2,cex=1.1,adj=0)
  mtext(expression(paste("-Log10(",italic(P),"-value, UP-regulated)")),at=0,side=3,line=2,cex=1.8,adj=0)
  #mtext(expression(paste("-Log10(",italic(P),",up regulated)")),side=3,line=1,cex=1)
 # legend("bottom",merge=F,"A,up-regulated")
  t1<-read.table(file=paste(base,"_down.go",sep=""),header=T,sep="\t",quote="\"",row.names=1)
  tt <- head(t1[order(t1$pvalue,decreasing = F),],n=5)
  tt <- tt[order(tt$pvalue,decreasing=T),]
  write.table(file=paste(base,".top5.txt",sep=""), 
              tt,sep="\t",quote=F,append=TRUE)
  #tt <- subset(t1,pvalue<0.0)
  go<-tt$Term
  pvalue<- as.numeric(tt$pvalue)
  names(pvalue) <-go
  func<-tt$term_type
  as.vector(tt$term_type) -> tt$term_type
  brewer.pal(9,"Set1") ->col
  #tt$col[tt$term_type=="BP"] <- col[3]
  #tt$col[tt$term_type=="MF"] <-col[2] 
  #tt$col[tt$term_type=="CC"] <- col[1]
  library(pheatmap)
  colorRampPalette(c("yellow","red"))(100) ->col1
  #pheatmap(-(log10(pvalue)),color=col1,cluster_rows= F, ,legend=F,cellwidth=20,cellheight=20,cluster_cols = F,show_colnames=F,show_rownames=T,fontsize = 20)
  
  barplot(-(log10(pvalue)),cex.names=2,width=0.5,space=1.55,las=1,horiz=T,col=col[2],axes=F,bg="white",border=F,xlim=c(0,max(-(log10(pvalue)))+1))
  #legend("right",legend=c("GOBP","GOMF","GOCC"),fill=col[c(3,2,1)],bty="n",cex=0.6,border=F)
  #legend(x=3,y=36,legend=c("GOBP","GOMF","GOCC"),fill=col[c(3,2,1)],bty="n",cex=0.6,border=F)
  axis(3,cex.axis=1.6,mgp=c(1,0.5,0),tck=-0.01)
  #mtext("-log10(pvalue)",side=1,line=2,cex=1.1,adj=0)
  mtext(expression(paste("-Log10(",italic(P),"-value, DOWN-regulated)")),at=0,side=3,line=2,cex=1.8,adj=0)
  #mtext(expression(paste("-Log10(",italic(P),",up regulated)")),side=3,line=1,cex=1)
  
  
  
  dev.off()
}


go_bar("fruit")
go_bar("vein")
go_bar("common")
