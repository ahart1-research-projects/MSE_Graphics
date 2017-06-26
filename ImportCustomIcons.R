# This script reads in icons from jpeg files

library(ggplot2)
library(RCurl)
library(jpeg)
library(grid)

# Load Icon jpeg 
# NOOOO HerringResource <- readJPEG("/Users/ahart2/Downloads/HerringResource.jpeg")
# NOOOOO HerringResource <- readJPEG("HerringResource.jpeg")




library(png)
library(grid)
# NOOOO HerringResource2 <- readPNG(system.file("img", "HerringResourcePNG.png", package="png"))

# This reads in the .png file
HerringResource2 <- readPNG( "HerringResourcePNG.png")

# Crop
HerringResource2 <- HerringResource2[100:200, 50,]

# Turn image into a raster grob
HerringResource2 <- rasterGrob(HerringResource2)

# Make the  white background transparent
HerringResource2$raster[HerringResource2=="#FFFFFF"] <- "#FFFFFF00"

# Make white layout space
layout(matrix(2,2))

# Plot image as point marker using annotation_custom
annotation_custom()


Test <- readPNG(system.file("img", "Rlogo.png", package="png"))
FixTest <- rasterGrob(Test, interpolate=FALSE)
qplot(1:10, 1:10, geom="blank") + 
  annotation_custom(FixTest, xmin=1, xmax=3, ymin=1, ymax=3) +  
  geom_point()






