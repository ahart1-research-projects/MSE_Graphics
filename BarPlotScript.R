# This script creates different types of bar plots

# TestBarPlotMatrix <- matrix(NA,5,6)
# TestBarPlotMatrix[1,1:6] <-1
# TestBarPlotMatrix[2,1:6] <- 2
# TestBarPlotMatrix[3,1:6] <-3
# TestBarPlotMatrix[4,1:6] <-4
# TestBarPlotMatrix[5,1:6] <-5
# colnames(TestBarPlotMatrix) <- c("CR1", "CR2", "CR3", "CR4", "CR5", "CR6")
# rownames(TestBarPlotMatrix) <- c("OM1", "OM2", "OM3","OM4","OM5")
# # data is for one performance metric
# OperatingModelVector <- c("OM1", "OM2", "OM3","OM4","OM5")
# 
# 
# 



SinglePerfMetricPlots <- function(Data=NULL, ylab=NULL, main=NULL, PlotType=NULL, ...){
  # This function gives options for plotting values for a single performance metric across different operating models and/or control rules

  # Args:
       # Data: A matrix containing data for a single performance metric (OM_vs_CR files produced by Make_OM_vs_CR_Matrix() function)
            # matrix rows are operating models
            # matrix columns are control rules
       # ylab: Name of y-axis label, should reflect name and units of perfomance metric
       # main: Main title for plot, ungrouped plots will be pasted together with "for operating model ___" or "for control rule___"
       # PlotType: name of plot type, options below with associated additional arguments
            # PlotType=="1_OperatingModel_MultipleControlRule"
                 # OperatingModel: The name of the operating model associated with data
                 # PlotColor: Vector of colors for plot                 
            # PlotType=="MultiPanel_1_OperatingModel_MultipleControlRule"
                 # OperatingModelList: A vector of operating model names
                 # PlotColor: Vector of colors for plot
                 # TranslatedControlRuleVector: Vector of translated control rules, must be same order and length as ControlRuleVector
                 # TranslatedOperatingModel: Vector of translated operating model names, must be same order and length as OperatingModelList
            # PlotType=="1_ControlRule_MultipleOperatingModel"
                 # ControlRule: The name of the control rule associated with data
                 # PlotColor: Vector of colors for plot
            # PlotType=="MultiPanel_1_ControlRule_MultipleOperatingModel"
                 # ControlRuleVector: A vector of control rule names
                 # PlotColor: Vector of colors for plot
                 # TranslatedOperatingModel: Vector of translated operating model names, must be same order and length as OperatingModelList
            # PlotType=="Y_MultipleOperatingModel_X_MultipleControlRule"
                 # PlotColor: Vector of colors for plot, should be same length as nrow(Data)
                 # TranslatedControlRuleVector: Vector of translated control rules, must be same order and length as ControlRuleVector
                 
            # PlotType=="X_MultipleOperatingModel_Y_MultipleControlRule"
                 # PlotColor: Vector of colors for plot, should be same length as ncol(Data)
       # OutputFile: String containing name of output file where graph is stored
  
  # Read in data
  Data <- read.table(Data)
  Data <- as.matrix(Data)
  
  # for(name in 1:length(colnames(Data))){
  #   if("X." %in% colnames(Data)[name]){ # if X. is in the column name
  #     RevisedName <- strsplit(colnames(Data)[name], "X.")
  #     colnames(Data)[name] <- as.character(RevisedName[[1]][2]) # Replace with column name minus the X.
  #   }
  # }
  # print(colnames(Data))
  
  # This turns data passed as extra arguments into a list for graphs to use
  ExtraArguments <- list(...) 
  
  if(PlotType=="1_OperatingModel_MultipleControlRule"){                         # NOT TESTED
    # 1 Operating Model, Multiple Control Rules
    barplot(height=Data[ExtraArguments$OperatingModel,], 
            width= rep(1,ncol(Data)), 
            space=1, 
            horiz=FALSE, 
            col=ExtraArguments$PlotColor, 
            xlab="Control Rule", 
            ylab=ylab,
            ylim=c(0, round(1.1*max(Data),digits=1)),
            main=main,
            axes=TRUE, 
            cex.axis=1, 
            cex.names=1, 
            offset=0)
  } else if(PlotType=="MultiPanel_1_OperatingModel_MultipleControlRule"){                 # THIS WORKS
    # Multipanel 1 Operating Model, Multiple Control Rules
    png(filename = ExtraArguments$OutputFile, width=940, height=700)
    par(mfrow = c(4,3), mar=c(5,3,5,1), xpd=TRUE)
    # For each operating model make barplot of values under different control rules
        for(plot in 1:length(ExtraArguments$OperatingModelList)){ 
          barplot(height=Data[plot,], 
                  width= rep(1, ncol(Data)), 
                  space=1, 
                  horiz=FALSE, 
                  col=ExtraArguments$PlotColor, 
                  xlab="Control Rule", 
                  names.arg = ExtraArguments$TranslatedControlRuleVector,
                  ylab=ylab,
                  ylim=c(0, round(1.1*max(Data),digits=1)),
                  main= paste(main, ExtraArguments$TranslatedOperatingModel[plot], sep=" "),
                  axes=TRUE, 
                  cex.axis=1.5,
                  cex.lab=1.5,
                  cex.main=1.7,
                  cex.names=1.5, 
                  offset=0)  
        }
    plot(1,1,type = "n", axes = FALSE, ann = FALSE)
    legend("center", inset=c(-0.2,-0.4), cex=1.5, fill=ExtraArguments$PlotColor, legend=ExtraArguments$TranslatedControlRuleVector)
    dev.off()
  } else if(PlotType=="1_ControlRule_MultipleOperatingModel"){                        # NOT TESTED
    # 1 Control Rule , Multiple Operating Models
    barplot(height=Data[,ExtraArguments$ControlRule], 
            width= rep(1,ncol(Data)), 
            space=1, 
            horiz=FALSE, 
            col=ExtraArguments$PlotColor, 
            xlab="Operating Model", 
            names.arg = ExtraArguments$TranslatedOperatingModel,
            ylab=ylab,
            ylim=c(0, round(1.1*max(Data),digits=1)),
            main=main, 
            axes=TRUE, 
            cex.axis=1, 
            cex.names=1, 
            offset=0)
  } else if(PlotType=="MultiPanel_1_ControlRule_MultipleOperatingModel"){                   # DOESNT WORK
    # Multipanel 1 Control Rule, Multiple Operating Models
      par(mfrow = c(4,3), mar=c(2,4,2,2))
    # For each control rule make barplot of values under different operating models
        for(plot in 1:length(ExtraArguments$ControlRuleVector)){
          barplot(height=Data[ ,plot], 
                  width= rep(1,nrow(Data)), 
                  space=1, 
                  horiz=FALSE, 
                  col=ExtraArguments$PlotColor, 
                  xlab="Operating Model", 
                  names.arg = ExtraArguments$TranslatedOperatingModel,
                  ylab=ylab,
                  ylim=c(0, round(1.1*max(Data), digits=1)),
                  main=main, 
                  axes=TRUE, 
                  cex.axis=1, 
                  cex.names=1, 
                  offset=0) 
        }
    plot(1,1,type = "n", axes = FALSE, ann = FALSE)
    legend("center", inset=c(-0.2,-0.4), cex=1.5, fill=ExtraArguments$PlotColor, legend=ExtraArguments$TranslatedControlRuleVector)
  }  else if(PlotType=="Y_MultipleOperatingModel_X_MultipleControlRule"){
    # Grouped bar plot, grouped by control rule, bar for each operating model
    png(filename = ExtraArguments$OutputFile, width=800, height=500)
    # plot color = OM
    par(mar=c(5,4,4,7), xpd=TRUE)
    barplot(Data, 
            col=ExtraArguments$PlotColor,
            width=1, 
            beside=TRUE,
            names.arg = ExtraArguments$TranslatedControlRuleVector,
            ylab=ylab,
            ylim=c(0, round(1.1*max(Data),digits=1)),
            main=main)
    legend("topright", inset=c(0,0), cex=1, fill=ExtraArguments$PlotColor, legend=ExtraArguments$TranslatedControlRuleVector)
    dev.off()
  } else if(PlotType=="X_MultipleOperatingModel_Y_MultipleControlRule"){
    # Grouped bar plot, bar for each control rule
    png(filename = ExtraArguments$OutputFile, width=800, height=500)
    par(mar=c(5,4,4,7), xpd=TRUE)
    barplot(Data, col=ExtraArguments$PlotColor,
            width=1, 
            beside=TRUE,
            ylab=ylab,
            ylim=c(0, round(1.1*max(Data),digits=1)),
            main=main)
    legend("topright", inset=c(-0.60,0), fill=ExtraArguments$PlotColor, legend=colnames(Data))
    dev.off()
  }
}







# Code to make Multiple performance metrics plots
MultiplePerfMetricPlots <- function(Data=NULL, BarNames=NULL, xlab=NULL, main=NULL, PlotType=NULL, PlotColor=NULL, OutputFile = NULL){
  # This function gives options for plotting values for a multiple performance metric across different operating models and/or control rules
  # It produces a grouped bar plot
  # Args:
       # Data: A matrix (PerfMet_vs_OM or PerfMet_vs_CR files produced by Make_OM_vs_PerfMet_Matrix() and Make_CR_vs_PerfMet_Matrix() functions)
            # Each row is a performance metric 
            # Columns are control rule or operating model
       # BarNames: Vector of names for bars
       # xlab: X-axis label, should be control rule or operating model depending on data
       # main: Main title for plot
       # PlotColor: Vector of colors for plot, should be equal to nrow(Data)
       # PlotType: name of plot type, options below with associated additional arguments
            # PlotType=="PerformanceMetric_OperatingModel", grouped by operating model
            # PlotType=="PerformanceMetric_ControlRule", grouped by control rule
       # OutputFile: String containing name of output file where graph is stored
  
 Data <- read.table(Data)
 Data <- as.matrix(Data)

  
 if(PlotType=="PerformanceMetric_OperatingModel"){                                  # THIS WORKS
   # Grouped bar plot, bar for each performance metric, grouped by operating model
   png(filename = OutputFile, width=800, height=500)
   par(mar=c(5,6,4,12), xpd=TRUE)
   barplot(Data, col=PlotColor,
           width=1, 
           beside=TRUE,
           xlab=xlab,
           names.arg=BarNames,
           ylab="Performance Metric Value",
           ylim=c(0,round(1.1*max(Data),digits=1)),
           main=main,
           cex.names=1.5,
           cex.lab = 1.5,
           cex.main=1.5)
   legend("topright", inset=c(-0.30,0), cex=1, fill=PlotColor, legend=rownames(Data))
   dev.off()
 } else if(PlotType=="PerformanceMetric_ControlRule"){                               # THIS WORKS
   # Grouped bar plot, bar for each performance metric, grouped by control rule
   png(filename = OutputFile, width=800, height=500)
   par(mar=c(5,6,4,12), xpd=TRUE)
   barplot(Data, 
           col=PlotColor,
           width=1, 
           beside=TRUE,
           xlab=xlab,
           names.arg=BarNames,
           ylab="Performance Metric Value",
           ylim=c(0,round(1.1*max(Data), digits=1)),
           main=main,
           cex.names = 1.5,
           cex.lab=1.5,
           cex.main=1.5)
   legend("topright", inset=c(-0.30,0), cex=1, fill=PlotColor, legend=rownames(Data))
   dev.off()
 } else {
   print(paste("Error", PlotType, sep=" "))
 }
}  
  




# Try plotting

# "Y_MultipleOperatingModel_X_MultipleControlRule"
# Data <- "/Users/arhart/Research/MSE_Graphics/Data_OM_vs_CR_BB_Yvar"
# Data <- read.table(Data)
# Data <- as.matrix(Data)
# 
# # par(mar=c(5,6,4,11), xpd=TRUE)
# par(mar=c(5,6,4,11), xpd=TRUE)
# barplot(Data, 
#         col=MSE_OperatingModelColors,
#         width=1, 
#         beside=TRUE,
#         xlab="Control Rule",
#         ylab="Performance Metric Value",
#         main="Test",
#         cex.names=1.5,
#         cex.lab = 1.5,
#         cex.main=1.5)
# legend("topright", inset=c(-0.25,0), cex=1, fill=PlotColor, legend=rownames(Data))
