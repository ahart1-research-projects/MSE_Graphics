# This script makes visually appealing tables (in reality it is a multi-panel plot not a table)

MakeGraphicDecisionTable <- function(Title=NULL, IconList=NULL, RowCategoryName=NULL, RowNames=NULL, 
                                     ColumnCategoryName=NULL, ColumnNames=NULL,
                                     GraphicLayout=GraphicLayoutDefault, GraphicNRow=8, GraphicNCol=4, 
                                     GraphicHeights=GraphicHeightsDefault, GraphicWidths=GraphicWidthsDefault, PlotOrder=NULL, ...){
  # Args:
       # Title: A string containing the title for the decision table graphic
       # IconList: A vector of icons names to be printed right of the Title, number can not exceed (GraphicNCol - 4), default is empty
       # RowCategoryName: A string containing the descriptive title for row names
       # ColumnCategoryName: A string containing the descriptive title for column names
       # RowNames: A vector of row names, each name should be a string in ""
       # ColumnNames: A vector of column names, each name should be a string in ""
       # GraphicLayout: A vector containing information that lays out graphic structure, the matrix must have at least 4 columns and 8 rows, default=GraphicLayoutDefault
       # GraphicNRow: Number of rows in GraphicFormat Matrix, must be at least 4
       # GraphicNCol: Number of columns in GraphicFormat Matrix, must be at least 8
       # GraphicHeights: A vector containing row heights, must be same length as GraphicNRow
       # GraphicWidths: A vector containing column widths, must be same length as GraphicNCol
       # PlotOrder: A vector of strings containing names of the plots to produce options are listed below with associated arguments, PlotOrder must be equal in length of GraphicNCol-1
            # "VerticalBarplot"
                 # VerticalBarData: List of vectors or matricies containing data to plot in vertical barplot, number of items in list must be equal to length of RowNames
                 # VerticalBarWidths vector of bar widths
                 # VerticalBarColors: 1 or more colors for plot
                 # VerticalBarXLabel: labels x axis
                 # VerticalBarYLabel: labels y axis
                 # VerticalBarAxes determines if axes plotted, must be TRUE/FALSE
            # "VerticalStackedBar"
                 # VerticalStackedBarData: List of objects, each with two or more $ categories (eg Data$category1, Data$category2...), number of objects in list must be equal to length of RowNames
                 # VerticalStackedBarWidths vector of bar widths
                 # VerticalStackedBarColors: 2 or more colors
                 # VerticalStackedBarXLabel: labels x axis
                 # VerticalStackedBarYLabel: labels y axis
                 # VerticalStackedBarAxes determines if axes plotted, must be TRUE/FALSE
            # "HorizontalBarplot"
                 # HorizontalBarData: List of vectors or matricies containing data to plot in vertical barplot, number of items in list must be equal to length of RowNames
                 # HorizontalBarWidths vector of bar widths
                 # HorizontalBarColors: 1 or more colors for plot
                 # HorizontalBarXLabel: labels x axis
                 # HorizontalBarYLabel: labels y axis
                 # VerticalBarAxes determines if axes plotted, must be TRUE/FALSE
            # "HorizontalStackedBar"
                 # HorizontalStackedBarData: List of objects, each with two or more $ categories (eg Data$category1, Data$category2...), number of objects in list must be equal to length of RowNames
                 # HorizontalStackedBarWidths vector of bar widths
                 # HorizontalStackedBarColors: 2 or more colors
                 # HorizontallStackedBarXLabel: labels x axis
                 # HorizontalStackedBarYLabel: labels y axis
                 # HorizontalStackedBarAxes determines if axes plotted, must be TRUE/FALSE
            # "Pictogram"
                 # PictogramImage: Name of image for pictogram, "ImageName.png" format
                 # PictogramData: Vector of counts, must be same length as RowNames
                 # PictogramDataScale: Single number determines count scale
                 # PictogramColumns: Single number determines number of columns in pictogram
  # Returns:
       # A ploted decision table with customized graphics
  
  # These set up the default format
  GraphicLayoutDefault <- c( 1, 1, 1, 1, # First four grid spaces must be assigned 1 as this is where the title will be plotted
                             2, 2, 2, 2,
                             3, 4, 4, 4,
                             3, 5, 5, 5,
                             3, 6, 7, 8,
                             9, 9, 9, 9,
                             10,11,12,13,
                             14,14,14,14)
  GraphicWidthsDefault <- rep(1, GraphicNCol)
  GraphicHeightsDefault <- rep(c(1,0.25), GraphicNRow/2)
  
  # Produce and display GraphicFormat
  GraphicFormat <- layout(matrix(GraphicLayout, nrow = GraphicNRow, ncol = GraphicNCol, byrow = TRUE), widths = GraphicWidths, heights = GraphicHeights)
  layout.show(GraphicFormat)
  
  ##### Set up title and headers for table #####
  # Title
  par(mar=c(0,0,0,0))
  plot(1,1,type="n", axes=FALSE, ann=FALSE)
  text(1,1,labels=c(Title), cex=2)
  
  # Optional printed icons to right of title, may not exceed (GraphicNCol - 4)
  # need a way to say if not all empty spaces used print empty, if more than empty in icon list stop printing ??????
  library(raster)
  library(png)
  for(icon in 1:length(IconList)){ 
    IconImage <- readPNG(paste(IconList[icon], ".png", sep=""))
    plot(1,1, axes=FALSE, ann=FALSE) # Sets up empty plot
    lim <- par() # Gets boundaries of plot space
    rasterImage(IconImage, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4]) # Plots raster image in plot space bounded by lim
  }
  if(length(IconList) < (GraphicNCol-4)){ # This fills remaining slots in first row with empty plots if fewer icons than slots
    for(empty in GraphicNCol-4-length(IconList)){
      par(mar=c(0,0,0,0))
      plot(1,1,type="n", axes=FALSE, ann=FALSE)
    }
  }
  
  # Plot first horizontal division
  par(mar=c(0,0,0,0))
  plot(1,1,type="n", axes=FALSE, ann=FALSE)
  abline(h=1, col="black", lwd=2)
  
  # RowCategoryName
  par(mar=c(0,0,0,0))
  plot(1,1,type="n", axes=FALSE, ann=FALSE)
  text(1,1,labels=c(RowCategoryName), cex=1.5) 
  
  # ColumnCategoryName
  par(mar=c(0,0,0,0))
  plot(1,1,type="n", axes=FALSE, ann=FALSE)
  text(1,1,labels=c(ColumnCategoryName), cex=1.5) 
  
  # Plot horizontal division line
  par(mar=c(0,0,0,0))
  plot(1,1,type="n", axes=FALSE, ann=FALSE)
  abline(h=1, col="black", lwd=1)
  
  # Plot ColumnNames
  for(Name in ColumnNames){
    plot(1,1,type = "n", axes = FALSE, ann = FALSE)
    text(1,1, labels = ColumnNames[Name], cex=1)
  }
  
  ##### Repeating information in the table #####
  for(row in 1:length(RowNames)){
    # Plot horizontal division line
    plot(1,1,type="n", axes=FALSE, ann=FALSE)
    abline(h=1, col="black", lwd=1)
    
    # Plot RowName
    plot(1,1,type="n", axes=FALSE, ann=FALSE)
    text(1,1,labels=RowNames[row], cex=1)
    
    # Plot graphs specified by PlotOrder
    ExtraArguments <- list(...) # This turns data passed as extra arguments into a list for graphs to use
    
    for(graphic in PlotOrder){
      if(graphic=="VerticalBarplot"){
        barplot(height=ExtraArguments$VerticalBarData[[row]], width=ExtraArguments$VerticalBarWidths, space=0, horiz=FALSE, col=ExtraArguments$VerticalBarColors, 
                xlab=ExtraArguments$VerticalBarXLabel, ylab=ExtraArguments$VerticalBarYLabel, axes=ExtraArguments$VerticalBarAxes, cex.axis=1, cex.names=1, offset=0)
      } else if(graphic=="VerticalStackedBar"){
        barplot(table(ExtraArguments$VerticalStackedBarData[[row]]), width=ExtraArguments$VerticalStackedBarWidths, space=0, horiz=FALSE, col=ExtraArguments$VerticalStackedBarColors, 
                xlab=ExtraArguments$VerticalStackedBarXLabel, ylab=ExtraArguments$VerticalStackedBarYLabel, axes=ExtraArguments$VerticalStackedBarAxes,  cex.axis=1, cex.names=1, offset=0)
      } else if(graphic=="HorizontalBarplot"){
        barplot(height=ExtraArguments$HorizontalBarData[[row]], width=ExtraArguments$HorizontalBarWidths, space=0, horiz=TRUE, col=ExtraArguments$HorizontalBarColors, 
                xlab=ExtraArguments$HorizontalBarXLabel, ylab=ExtraArguments$HorizontalBarYLabel, axes=ExtraArguments$HorizontalBarAxes, cex.axis=1, cex.names=1, offset=0)
      } else if(graphic=="HorizontalStackedBar"){
        barplot(table(ExtraArguments$HorizontalStackedBarData[[row]]), width=ExtraArguments$HorizontalStackedBarWidths, space=0, beside=FALSE, horiz=TRUE, col=ExtraArguments$HorizontalStackedBarColors, 
                xlab=ExtraArguments$HorizontalStackedBarXLabel, ylab=ExtraArguments$HorizontalStackedBarYLabel, axes=ExtraArguments$HorizontalStackedBarAxes,  cex.axis=1, cex.names=1, offset=0)
      } else if(graphic=="Pictogram"){
        MakePictogram(PickIcon=ExtraArguments$PictogramImage, CountData=ExtraArguments$PictogramData[[row]], CountDataScale=ExtraArguments$PictogramDataScale, NCols=ExtraArguments$PictogramColumns) 
        # This will have the pictogram code when I can get it to work, see function at the end of this script
      } else {
        plot(1,1,type = "n", axes = FALSE, ann = FALSE) # Plot empty space
      }
      # Stacked bar plots still don't work, but no error returned
    }
  }
  
  # Plot last horizontal division
  par(mar=c(0,0,0,0))
  plot(1,1,type="n", axes=FALSE, ann=FALSE)
  abline(h=1, col="black", lwd=2)
}




# # 1
# # 2:7
# # 8
# # 9
# # 10
# # 11
# # 12:20
# for(numCR in 1:length(CRList)){
# }
# # 21
# # 22
# # 23:31
# 
# 
# # 32
# 
# 
# # 33
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# text(1,1,labels=c("Model2"), cex=1)
# 
# # 34:42
# for(numcR in 1:length(CRList)){
#   plot(1,1,type = "n", axes = FALSE, ann = FALSE)
# }
# 
# # 43
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# abline(h=1, col="black", lwd=1)
# 
# # 44
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# text(1,1,labels=c("Model3"), cex=1)
# 
# # 45:53
# for(numcR in 1:length(CRList)){
#   plot(1,1,type = "n", axes = FALSE, ann = FALSE)
# }
# 
# # 54
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# abline(h=1, col="black", lwd=1)
# 
# # 55
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# text(1,1,labels=c("Model4"), cex=1)
# 
# # 56:64
# for(numcR in 1:length(CRList)){
#   plot(1,1,type = "n", axes = FALSE, ann = FALSE)
# }
# 
# # 65
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# abline(h=1, col="black", lwd=1)
# 
# # 66
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# text(1,1,labels=c("Model5"), cex=1)
# 
# # 67:75
# for(numcR in 1:length(CRList)){
#   plot(1,1,type = "n", axes = FALSE, ann = FALSE)
# }
# 
# # 76
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# abline(h=1, col="black", lwd=1)
# 
# # 77
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# text(1,1,labels=c("Model6"), cex=1)
# 
# # 78:86
# for(numcR in 1:length(CRList)){
#   plot(1,1,type = "n", axes = FALSE, ann = FALSE)
# }
# 
# # 87
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# abline(h=1, col="black", lwd=1)
# 
# # 88
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# text(1,1,labels=c("Model7"), cex=1)
# 
# # 89:97
# for(numcR in 1:length(CRList)){
#   plot(1,1,type = "n", axes = FALSE, ann = FALSE)
# }
# 
# # 98
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# abline(h=1, col="black", lwd=1)
# 
# # 99
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# text(1,1,labels=c("Model8"), cex=1)
# 
# # 100:108
# for(numcR in 1:length(CRList)){
#   plot(1,1,type = "n", axes = FALSE, ann = FALSE)
# }
# 
# # 109
# par(mar=c(0,0,0,0))
# plot(1,1,type="n", axes=FALSE, ann=FALSE)
# abline(h=1, col="black", lwd=2)


MakePictogram <- function(FileName=NULL, PickIcon=NULL, CountData=NULL, CountDataScale=NULL, NCols=NULL){
  # Args:
       # FileName: Vector of plot file names
       # PickIcon: A string containing the name of an icon .png file for use in the pictogram, must be cropped to the edge
       # CountData: A single value of count data, could be counts/monetary value...
       # CountDataScale: This scales data so a reasonable number of icons are printed, should be 1000, 10000, 100000 scale
       # NCols: Number of columns in pictogram
  # Return:
       # Pictogram file
  png(filename="NewFile.png")
  
  library(magick)
  library(grid)
  library(gridExtra)
  
  Icon <- image_read(PickIcon)
  IconDimensions <- image_info(Icon)
  IconWidth <- IconDimensions["width"]
  IconHeight <- IconDimensions["height"]
  
  png(paste(FileName, ".png", sep=""))
  
  if(CountData %% CountDataScale == 0){ # if CountData/CountDataScale has a remainder of zero then
    # Plot full icon (CountData %/% CountDataScale) number of times 
    NumFullIconsPlotted <- CountData %/% CountDataScale 
    # Format icon for plotting
    PlotIcon <- rasterGrob(Icon)
    # Set up plot space and storage file
    NRows <- ceiling((NumFullIconsPlotted)/NCols)
    par(mfrow=c(NRows,NCols), mar=c(0,0,0,0))
    # Fill plot space
    for(plotnum in 1:NumFullIconsPlotted){
      par(mar=c(0,0,0,0))
      plot(Icon)
    }
    dev.off()
  } else if(CountData %% CountDataScale !=0){ # if CountData/10000 has a remainder other than zero
    # Plot full icon (CountData %/% CountDataScale) number of times
    NumFullIconsPlotted <- CountData %/% CountDataScale
    # Plot one cropped icon with IconWidth = full icon width *(CountData %% CountDataScale/CountDataScale) and IconHeight = full icon height
    CroppedIconWidth <- IconWidth * CountData %% CountDataScale /CountDataScale # Widty*(CountData remainder/scale)
    CroppedIconHeight <- IconHeight 
    CroppedIcon <- image_crop(Icon, geometry= paste(CroppedIconWidth, "x", CroppedIconHeight, sep="")) # to see image, type CroppedIcon below
    
    # Set up plot space and storage file
    NRows <- ceiling((NumFullIconsPlotted+1)/NCols)
    par(mfrow=c(NRows,NCols), mar=c(0,0,0,0))
    # Fill plot space
    for(plotnum in 1:NumFullIconsPlotted){
      par(mar=c(0,0,0,0))
      plot(Icon)
    }
    plot(CroppedIcon)
  }
  #FinalPlot <- recordPlot()

  #replayPlot(FinalPlot)
  dev.off()
}
    
MakePictogram(FileName="TestFileName.png", PickIcon = "HerringResource.png", CountData=45000, CountDataScale = 10000, NCols=4)   
# multiplot(), requires each plot be saved
# https://stackoverflow.com/questions/11721401/r-save-multiplot-to-file



