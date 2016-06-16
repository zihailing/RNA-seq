setwd("/psc/home/zihailing/zihailing/zhangxiaolan_20151204/")
as.vector(rownames(read.table(file="results12/Fruit.down",row.names=1,header=T)))->Fruitdown
as.vector(rownames(read.table(file="results34/Vein.down",row.names=1,header=T)))->Veindown

library(VennDiagram)
ddm_num <- venn.diagram(
  x = list(
    Fruitdown=Fruitdown, Veinup=Veindown
  #  ddm1Col=Col,ddm1C24= C24,ddm1F1=ddm1CXL,ddmrF1=ddm1LXC
  ) , filename = NULL, height = 500, width = 500,
  euler.d = FALSE, scaled = FALSE,
  col = "transparent",
  #lty = "line",
  lwd = 1,
  fill = c("green", "red"),
  alpha = 0.50,
  margin = 0.1,
#  label.col = "transparent",
  label.col = c("black", "black", "black"),
#  cex = 2,
#  fontfamily = "serif",
#  cat.col = c("black", "black"),
  cat.col = "transparent",
#  cat.cex = 2.5,
#  cat.fontfamily = "serif"
);
pdf(file="down.venn.pdf");
grid.draw(ddm_num);
dev.off();
