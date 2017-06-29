# # This script reads in icons from jpeg files
# 
# library(ggplot2)
# # library(RCurl)
# # library(jpeg)
# # library(grid)
# 
# 
# 
 library(png)
# library(grid)
# library(graphics)
# 
# setwd("/Users/ahart2/Research/MSE_Graphics/Icons")
# 
# # This reads in the .png file
# HerringResource2 <- readPNG( "HerringResource.png")
# 
# # Turn image into a raster grob
# #HerringResource2 <- rasterGrob(HerringResource2)
# 
# 
# Try <- layout(matrix(c(1,2,3,4),2,2))
# layout.show(Try)
# 
# #par(mar=c(0,0,0,0))
# #plot(1,1,type="n", axes=FALSE, ann=FALSE)
# 
# plot(1,1, axes=FALSE, ann=FALSE)
# rasterImage(HerringResource2,2,0.10,0.1,1)
# rasterImage(HerringResource2,01,0,01,1)
# grid.points(HerringResource2)
# 
# 
# # Crop
# #HerringResource2 <- HerringResource2[100:200, 50,]
# 
# 
# 
# 
# # plot(HerringResource2)this breaks things
# 
# # Make the  white background transparent
# HerringResource2$raster[HerringResource2=="#FFFFFF"] <- "#FFFFFF00"
# 
# # Make white layout space
# 
# #rasterImage(HerringResource2,1,1,1,1)
# # annotation_custom(HerringResource2) # this doesn't work, it breaks
# 
# # Plot image as point marker using annotation_custom
# # annotation_custom()
# 
# 
# Test <- readPNG(system.file("img", "Rlogo.png", package="png"))
# FixTest <- rasterGrob(Test, interpolate=FALSE)



# Test this stuff
library(raster)
library(png)
TestFishImage <- readPNG("TestFish.png")

Try <- layout(matrix(c(1,2,3,4),2,2))
layout.show(Try)

plot(1,1, axes=FALSE, ann=FALSE)
lim <- par()
rasterImage(TestFishImage, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])


Try <- layout(matrix(c(1,1,2,2,3,3,4,4),2,4))
layout.show(Try)

# #RasterFishImage <- as.raster(TestFishImage)
# RasterFishImage <- rasterGrob(TestFishImage)
# 
# # These 2 things don't work if not passed a raster
# CroppedFishImage <- crop(RasterFishImage,0,100,0,0)
# plotRGB(RasterFishImage)
# 
# Test2FishImage <- readPNG("TestFish.png")
# class(Test2FishImage)
# 

library(raster)
for(icon in IconList){
  IconImage <- readPNG(paste(IconList, ".png", sep=""))
  plot(1,1, axes=FALSE, ann=FALSE)
  lim <- par()
  rasterImage(IconImage, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])
  
}
