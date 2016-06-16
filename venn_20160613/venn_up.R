setwd("/psc/home/zihailing/zihailing/zhangxiaolan_20151204/venn")
as.vector(rownames(read.table(file="fruit.up",row.names=1,header=T)))->fruitup
as.vector(rownames(read.table(file="vein.up",row.names=1,header=T)))->veinup

library(VennDiagram)
ddm_num <- venn.diagram(
  x = list(
    fruitup=fruitup, veinup=veinup
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
  cat.col = c("black", "black"),
#  cat.col = "transparent",
#  cat.cex = 2.5,
#  cat.fontfamily = "serif"
  cat.default.pos = "text"
);
pdf(file="up.venn.pdf");
grid.draw(ddm_num);
dev.off();
