# This script makes visually appealing tables (in reality it is a multi-panel plot not a table)



# # Create array to hold plots in desiblack order
# ToFillLayout <- NULL
# 
# #TestThis <- list(rep(NA,109))
# # These are the things that won't change between graphics (standard formatting components)
# 
# # 8 and 109 should be thick lines (code below)
# pdf(NULL)
# dev.control(displaylist = "enable")
# plot(c(1,2),c(1,2),type="n", axes=FALSE, ann=FALSE)
# abline(h=1, col="black", lwd=2)
# ThickLines <- recordPlot() # Record plot by name
# invisible(dev.off())
# 
# ToFillLayout[[8]] <- ThickLines # assign thick lines to these array positions (correspond with layout)
# ToFillLayout[[109]] <- ThickLines
# 
# # 11,21,32,43,54,65,76,87,98,109 should be thin lines (code below)
# pdf(NULL)
# dev.control(displaylist = "enable")
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# abline(h=1, col="black", lwd=1)
# ThinLines <- recordPlot() # Record plot by name
# invisible(dev.off())
# ToFillLayout[[11]] <- ThinLines
# ToFillLayout[[21]] <- ThinLines
# ToFillLayout[[32]] <- ThinLines
# ToFillLayout[[43]] <- ThinLines
# ToFillLayout[[54]] <- ThinLines
# ToFillLayout[[65]] <- ThinLines
# ToFillLayout[[76]] <- ThinLines
# ToFillLayout[[87]] <- ThinLines
# ToFillLayout[[98]] <- ThinLines
# 
# 
# # Add text
# pdf(NULL)
# dev.control(displaylist = "enable")
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# text(1,1,labels=c("Test Text"), cex=2) 
# PerformanceMetric <- recordPlot() # Record plot by name
# invisible(dev.off())
# 
# ToFillLayout[[1]] <- PerformanceMetric

# Test<-layout(matrix(c(1,1,2,2,3,3),3,2,byrow = TRUE))
# layout.show(Test)
# 
# abline(h=0.75, col="black", lwd=2)
# 
# Variable <- rep(NA,109)
# Variable[3] <- "Three"
# 
# Variable[3]
# 
# plot(x=c(1,2,3), y=c(1,2,3))
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# abline(h=0.75, col="black", lwd=2)
# plot(x=c(3,2,1), y=c(3,2,1))






CRList <- c("CR1", "CR2", "CR3", "CR4", "CR5", "CR6", "CR7", "CR8", "CR9")


GraphicLayout <- c(  1,  1,  1,  1,  2,  3,  4,  5,  6,  7,
                     8,  8,  8,  8,  8,  8,  8,  8,  8,  8,
                     9, 10, 10, 10, 10, 10, 10, 10, 10, 10,
                     9, 11, 11, 11, 11, 11, 11, 11, 11, 11,
                     9, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                     21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
                     22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
                     32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
                     33, 34, 35, 36, 37, 38, 39, 40, 41, 42,
                     43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
                     44, 45, 46, 47, 48, 49, 50, 51, 52, 53,
                     54, 54, 54, 54, 54, 54, 54, 54, 54, 54,
                     55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
                     65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
                     66, 67, 68, 69, 70, 71, 72, 73, 74, 75,
                     76, 76, 76, 76, 76, 76, 76, 76, 76, 76,
                     77, 78, 79, 80, 81, 82, 83, 84, 85, 86,
                     87, 87, 87, 87, 87, 87, 87, 87, 87, 87,
                     88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
                     98, 98, 98, 98, 98, 98, 98, 98, 98, 98,
                     99,100,101,102,103,104,105,106,107,108,
                     109,109,109,109,109,109,109,109,109,109)
GraphicWidths <- c(1,1,1,1,1,1,1,1,1,1)
GraphicHeights <- c(1,0.25,1,0.25,1,0.25,1,0.25,1,0.25,1,0.25,1,0.25,1,0.25,1,0.25,1,0.25,1,0.25)
GraphicFormat <- layout(matrix(GraphicLayout, nrow = 22, ncol = 10, byrow = TRUE), widths = GraphicWidths, heights = GraphicHeights)
#GraphicFormat <- layout(matrix(GraphicLayout, nrow = 22, ncol = 10, byrow = TRUE))
layout.show(GraphicFormat)

CRList <- c("CR1", "CR2", "CR3", "CR4", "CR5", "CR6", "CR7", "CR8", "CR9")

# 1
par(mar=c(0,0,0,0))
plot(1,1,type="n", axes=FALSE, ann=FALSE)
text(1,1,labels=c("Performance Metric Name"), cex=2) 

# 2:7
# for(icon in UseIcons){
# par(mar=c(0,0,0,0))
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# plot icon somehow
# } else{
# par(mar=c(0,0,0,0))
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# }

par(mar=c(0,0,0,0))
plot(1,1,type="n", axes=FALSE, ann=FALSE)
par(mar=c(0,0,0,0))
plot(1,1,type="n", axes=FALSE, ann=FALSE)
par(mar=c(0,0,0,0))
plot(1,1,type="n", axes=FALSE, ann=FALSE)
par(mar=c(0,0,0,0))
plot(1,1,type="n", axes=FALSE, ann=FALSE)
par(mar=c(0,0,0,0))
plot(1,1,type="n", axes=FALSE, ann=FALSE)
par(mar=c(0,0,0,0))
plot(1,1,type="n", axes=FALSE, ann=FALSE)

# 8
par(mar=c(0,0,0,0))
plot(1,1,type="n", axes=FALSE, ann=FALSE)
abline(h=1, col="black", lwd=2)

# 9
par(mar=c(0,0,0,0))
plot(1,1,type="n", axes=FALSE, ann=FALSE)
text(1,1,labels=c("Operating Model"), cex=1.5) 

# 10
par(mar=c(0,0,0,0))
plot(1,1,type="n", axes=FALSE, ann=FALSE)
text(1,1,labels=c("Control Rule"), cex=1.5) 

# 11
par(mar=c(0,0,0,0))
plot(1,1,type="n", axes=FALSE, ann=FALSE)
abline(h=1, col="black", lwd=1)

# 12:20
for(numCR in 1:length(CRList)){
  plot(1,1,type = "n", axes = FALSE, ann = FALSE)
  text(1,1, labels = CRList[numCR], cex=1)
}

# 21
par(mar=c(0,0,0,0))
plot(1,1,type="n", axes=FALSE, ann=FALSE)
abline(h=1, col="black", lwd=1)

# 22
plot(1,1,type="n", axes=FALSE, ann=FALSE)
text(1,1,labels=c("Model1"), cex=1)

# 23:31
for(numcR in 1:length(CRList)){
  plot(1,1,type = "n", axes = FALSE, ann = FALSE)
}

# 32
plot(1,1,type="n", axes=FALSE, ann=FALSE)
abline(h=1, col="black", lwd=1)

# 33
plot(1,1,type="n", axes=FALSE, ann=FALSE)
text(1,1,labels=c("Model2"), cex=1)

# 34:42
for(numcR in 1:length(CRList)){
  plot(1,1,type = "n", axes = FALSE, ann = FALSE)
}

# 43
plot(1,1,type="n", axes=FALSE, ann=FALSE)
abline(h=1, col="black", lwd=1)

# 44
plot(1,1,type="n", axes=FALSE, ann=FALSE)
text(1,1,labels=c("Model3"), cex=1)

# 45:53
for(numcR in 1:length(CRList)){
  plot(1,1,type = "n", axes = FALSE, ann = FALSE)
}

# 54
plot(1,1,type="n", axes=FALSE, ann=FALSE)
abline(h=1, col="black", lwd=1)

# 55
plot(1,1,type="n", axes=FALSE, ann=FALSE)
text(1,1,labels=c("Model4"), cex=1)

# 56:64
for(numcR in 1:length(CRList)){
  plot(1,1,type = "n", axes = FALSE, ann = FALSE)
}

# 65
plot(1,1,type="n", axes=FALSE, ann=FALSE)
abline(h=1, col="black", lwd=1)

# 66
plot(1,1,type="n", axes=FALSE, ann=FALSE)
text(1,1,labels=c("Model5"), cex=1)

# 67:75
for(numcR in 1:length(CRList)){
  plot(1,1,type = "n", axes = FALSE, ann = FALSE)
}

# 76
plot(1,1,type="n", axes=FALSE, ann=FALSE)
abline(h=1, col="black", lwd=1)

# 77
plot(1,1,type="n", axes=FALSE, ann=FALSE)
text(1,1,labels=c("Model6"), cex=1)

# 78:86
for(numcR in 1:length(CRList)){
  plot(1,1,type = "n", axes = FALSE, ann = FALSE)
}

# 87
plot(1,1,type="n", axes=FALSE, ann=FALSE)
abline(h=1, col="black", lwd=1)

# 88
plot(1,1,type="n", axes=FALSE, ann=FALSE)
text(1,1,labels=c("Model7"), cex=1)

# 89:97
for(numcR in 1:length(CRList)){
  plot(1,1,type = "n", axes = FALSE, ann = FALSE)
}

# 98
plot(1,1,type="n", axes=FALSE, ann=FALSE)
abline(h=1, col="black", lwd=1)

# 99
plot(1,1,type="n", axes=FALSE, ann=FALSE)
text(1,1,labels=c("Model8"), cex=1)

# 100:108
for(numcR in 1:length(CRList)){
  plot(1,1,type = "n", axes = FALSE, ann = FALSE)
}

# 109
par(mar=c(0,0,0,0))
plot(1,1,type="n", axes=FALSE, ann=FALSE)
abline(h=1, col="black", lwd=2)
