# This script makes visually appealing tables (in reality it is a multi-panel plot not a table)

MakeGraphicDecisionTable <- function(OutputDirectory=NULL, Title=NULL, IconList=NULL, RowCategoryName=NULL, RowNames=NULL, 
                                     ColumnCategoryName=NULL, ColumnNames=NULL,
                                     GraphicLayout=GraphicLayoutDefault, GraphicNRow=8, GraphicNCol=4, 
                                     GraphicHeights=GraphicHeightsDefault, GraphicWidths=GraphicWidthsDefault, PlotOrder=NULL, OutputFileName=NULL, ...){
  # Args:
       # OutputDirectory: String containing the full path name of folder to store output
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
       # OutputFileName: A string contining the output file name
       # PlotOrder: A vector of strings containing names of the plots to produce options are listed below with associated arguments, PlotOrder must be equal in length of GraphicNCol-1
            # "SingleColumn_VerticalBarplot"
                 # VerticalBarData: List of vectors or matricies containing data to plot in vertical barplot, number of items in list must be equal to length of RowNames
                      # Each item in the list will be plotted in an individual graph
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
  
  png(filename = paste(OutputDirectory, paste(OutputFileName, ".png", sep=""), sep="/"), width=500, height=800)
  
  # These set up the default format
  GraphicLayoutDefault <- c( 1, 1, 1, 1, 2, # First four grid spaces must be assigned 1 as this is where the title will be plotted
                             3, 3, 3, 3, 3, # 2 is empty grid to balance table appearance
                             4, 5, 5, 5, 2,
                             4, 6, 6, 6, 6,
                             4, 7, 8, 9, 2,
                            10,10,10,10,10,
                            11,12,13,14, 2,
                            15,15,15,15,15)
  GraphicWidthsDefault <- c(rep(1, GraphicNCol-1), 0.5)
  GraphicHeightsDefault <- rep(c(1,0.25), GraphicNRow/2)
  
  # Produce and display GraphicFormat
  GraphicFormat <- layout(matrix(GraphicLayout, nrow = GraphicNRow, ncol = GraphicNCol, byrow = TRUE), widths = GraphicWidths, heights = GraphicHeights)
  layout.show(GraphicFormat)
  lcm(10)
  
  ##### Set up title and headers for table #####
  # Title
  par(mar=c(0,0,0,0))
  plot(1,1,type="n", axes=FALSE, ann=FALSE)
  text(1,1,labels=c(Title), cex=2.5)
  
  # Optional printed icons to right of title, may not exceed (GraphicNCol - 4)
  # need a way to say if not all empty spaces used print empty, if more than empty in icon list stop printing ??????
  # library(raster)
  # library(png)
  # for(icon in 1:length(IconList)){
  #   IconImage <- readPNG(paste(IconList[icon], ".png", sep=""))
  #   plot(1,1, axes=FALSE, ann=FALSE) # Sets up empty plot
  #   lim <- par() # Gets boundaries of plot space
  #   rasterImage(IconImage, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4]) # Plots raster image in plot space bounded by lim
  # }
  # Need the line below for standard graphic 
  # if(length(IconList) < (GraphicNCol-5)){ # This fills remaining slots in first row with empty plots if fewer icons than slots
  #   for(empty in 1:(GraphicNCol-5-length(IconList))){
  #     par(mar=c(0,0,0,0))
  #     plot(1,1,type="n", axes=FALSE, ann=FALSE)
  #     print("Empty Plot Icon" )
  #   }
  # }
  
  # Plot empty space on right side of graph
  plot(1,1,type="n", axes=FALSE, ann=FALSE)
  
  # Plot first horizontal division
  par(mar=c(0,0.5,0,0.5))
  plot(1,1,type="n", axes=FALSE, ann=FALSE)
  abline(h=1, col="black", lwd=2)
  
  # RowCategoryName
  par(mar=c(0,0,0,0))
  plot(1,1,type="n", axes=FALSE, ann=FALSE)
  text(1,1,labels=c(RowCategoryName), cex=2) 
  
  # ColumnCategoryName
  par(mar=c(0,0,0,0))
  plot(1,1,type="n", axes=FALSE, ann=FALSE)
  text(1,1,labels=c(ColumnCategoryName), cex=2) 
  
  # Plot horizontal division line
  par(mar=c(0,0.5,0,0.5))
  plot(1,1,type="n", axes=FALSE, ann=FALSE)
  abline(h=1, col="black", lwd=1)
  
  # Plot ColumnNames
  for(Name in 1:length(ColumnNames)){
    plot(1,1,type = "n", axes = FALSE, ann = FALSE)
    text(1,1, labels = ColumnNames[Name], cex=2)
  }
  
  ##### Repeating information in the table #####
  for(row in 1:length(RowNames)){
    # Plot horizontal division line
    par(mar=c(0,0.5,0,0.5))
    plot(1,1,type="n", axes=FALSE, ann=FALSE)
    abline(h=1, col="black", lwd=1)
    
    # Plot RowName
    plot(1,1,type="n", axes=FALSE, ann=FALSE)
    text(1,1,labels=RowNames[row], cex=2)
    
    # Plot graphs specified by PlotOrder
    ExtraArguments <- list(...) # This turns data passed as extra arguments into a list for graphs to use
    

      for(i in 1:ncol(ExtraArguments$VerticalBarData)){
        print(rownames(ExtraArguments$VerticalBarData))
        if((rownames(ExtraArguments$VerticalBarData)[row]=="Tuna Weight Status") |
          (rownames(ExtraArguments$VerticalBarData)[row]=="Prop Year Good Dogfish Biomass") |
           (rownames(ExtraArguments$VerticalBarData)[row]=="Yield") |
           (rownames(ExtraArguments$VerticalBarData)[row]=="Yield Relative to MSY") |
           (rownames(ExtraArguments$VerticalBarData)[row]=="Net Revenue for Herring") |
           (rownames(ExtraArguments$VerticalBarData)[row]=="Prop Year Tern Production > 1") |
           (rownames(ExtraArguments$VerticalBarData)[row]=="SSB Relative to Unfished Biomass")){


        # Rank from high to low
        Rank <- rank(ExtraArguments$VerticalBarData[row, ]) # will not be produced if a rowname does not match something in the if statement (returns Rank not found error)


        } else if((rownames(ExtraArguments$VerticalBarData)[row]=="Prop Year Biomass < Bmsy") |
                  (rownames(ExtraArguments$VerticalBarData)[row]=="Probability of Overfished B < 0.5Bmsy") |
                  (rownames(ExtraArguments$VerticalBarData)[row]=="Prop Year Overfishing Occurs F > Fmsy") |
                  (rownames(ExtraArguments$VerticalBarData)[row]=="Prop Year Closure Occurs") |
                  (rownames(ExtraArguments$VerticalBarData)[row]=="Interannual Variation in Yield")){

        # Rank from low to high
        Rank <- rank(-ExtraArguments$VerticalBarData[row,])
        }

        Colors <- ExtraArguments$VerticalBarColors

        #print(Rank)
        #print(ExtraArguments$VerticalBarData[row,])
        par(mar=c(2,3,0,0), xpd=TRUE) # /?????????? probably need to adjust
        barplot(height=ExtraArguments$VerticalBarData[row,i], 
                width=ExtraArguments$VerticalBarWidths, 
                space=0, 
                horiz=FALSE, 
                col=Colors[Rank[i]],
                #col=ExtraArguments$VerticalBarColors[i], 
                # xlab=Labels,
                # ylab=ExtraArguments$VerticalBarYLabel,
                ylim=c(0,1.1*max(ExtraArguments$VerticalBarData[row,])),
                # axes=ExtraArguments$VerticalBarAxes, 
                cex.axis=1, 
                cex.names=1, 
                offset=0)

        Labels <- round(ExtraArguments$VerticalBarData[row,i], digits=2)
        # text(0.23,-0.13,labels=paste(Labels), cex=1.5)
        # text (0.23,-0.5, labels = Labels, cex=1.5)
        mtext(Labels, side=1, cex=1.2, line=1)
      }


    # The commented section below works, but each option can only be called once in the decision table
    # Additionally, the same plot will be plotted across the entire row, although plots will vary between rows
    
    # for(graphic in PlotOrder){
    #   if(graphic=="SingleColumn_VerticalBarplot"){
    #     par(mar=c(0.5,2,0,0))
    #     barplot(height=ExtraArguments$VerticalBarData[[row]], width=ExtraArguments$VerticalBarWidths, space=0, horiz=FALSE, col=ExtraArguments$VerticalBarColors, 
    #             xlab=paste(ExtraArguments$VerticalBarXLabel, sep=""), ylab=ExtraArguments$VerticalBarYLabel, axes=ExtraArguments$VerticalBarAxes, cex.axis=1, cex.names=1, offset=0)
    #   } else if(graphic=="VerticalStackedBar"){
    #     barplot(table(ExtraArguments$VerticalStackedBarData[[row]]), width=ExtraArguments$VerticalStackedBarWidths, space=0, horiz=FALSE, col=ExtraArguments$VerticalStackedBarColors, 
    #             xlab=ExtraArguments$VerticalStackedBarXLabel, ylab=ExtraArguments$VerticalStackedBarYLabel, axes=ExtraArguments$VerticalStackedBarAxes,  cex.axis=1, cex.names=1, offset=0)
    #   } else if(graphic=="HorizontalBarplot"){
    #     barplot(height=ExtraArguments$HorizontalBarData[[row]], width=ExtraArguments$HorizontalBarWidths, space=0, horiz=TRUE, col=ExtraArguments$HorizontalBarColors, 
    #             xlab=ExtraArguments$HorizontalBarXLabel, ylab=ExtraArguments$HorizontalBarYLabel, axes=ExtraArguments$HorizontalBarAxes, cex.axis=1, cex.names=1, offset=0)
    #   } else if(graphic=="HorizontalStackedBar"){
    #     barplot(table(ExtraArguments$HorizontalStackedBarData[[row]]), width=ExtraArguments$HorizontalStackedBarWidths, space=0, beside=FALSE, horiz=TRUE, col=ExtraArguments$HorizontalStackedBarColors, 
    #             xlab=ExtraArguments$HorizontalStackedBarXLabel, ylab=ExtraArguments$HorizontalStackedBarYLabel, axes=ExtraArguments$HorizontalStackedBarAxes,  cex.axis=1, cex.names=1, offset=0)
    #   } else if(graphic=="Pictogram"){
    #     MakePictogram(PickIcon=ExtraArguments$PictogramImage, CountData=ExtraArguments$PictogramData[[row]], CountDataScale=ExtraArguments$PictogramDataScale, NCols=ExtraArguments$PictogramColumns) 
    #     # This will have the pictogram code when I can get it to work, see function at the end of this script
    #   } else {
    #     plot(1,1,type = "n", axes = FALSE, ann = FALSE) # Plot empty space
    #   }
    #   # Stacked bar plots still don't work, but no error returned
    # }
    
  }
  
  # Plot last horizontal division
  par(mar=c(0,0.5,0,0.5))
  plot(1,1,type="n", axes=FALSE, ann=FALSE)
  abline(h=1, col="black", lwd=2)
  
  dev.off()
}

# This code tests the FullMatrix_VerticalBoxplot
# par(mfrow=c(8,9))
# for(j in 1:nrow(Data)){
#   for(i in 1:ncol(Data)){
#     barplot(height=Data[j,i], width=1, space=0, horiz=FALSE, col=MSE_ControlRuleColors[i], 
#             xlab=paste(Data[j,i], sep=""), ylab="Test", axes=TRUE, cex.axis=1, cex.names=1, offset=0, 
#             ylim=c(0,1.1*max(Data)))
#     
#   }
# }

##################################################################################################################




##################################################################################################################

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



