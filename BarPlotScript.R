# This script creates different types of bar plots

TestBarPlotMatrix <- matrix(NA,5,6)
TestBarPlotMatrix[1,1:6] <-1
TestBarPlotMatrix[2,1:6] <- 2
TestBarPlotMatrix[3,1:6] <-3
TestBarPlotMatrix[4,1:6] <-4
TestBarPlotMatrix[5,1:6] <-5
colnames(TestBarPlotMatrix) <- c("CR1", "CR2", "CR3", "CR4", "CR5", "CR6")
rownames(TestBarPlotMatrix) <- c("OM1", "OM2", "OM3","OM4","OM5")
# data is for one performance metric
OperatingModelVector <- c("OM1", "OM2", "OM3","OM4","OM5")



# Code to make multi-panel plot 1 plot per CR, all OM, annual variation in yield data, BB
SinglePerfMetricPlots(Data=Data_OM_vs_CR_BB_Yvar,
                      ylab="Annual Variability in yield (%)",
                      main="Annual Variability in Yield",
                      PlotType= "Multipanel_1_ControlRule_MultipleOperatintModel",
                      ControlRuleVector = ControlRuleNames,
                      PlotColor = c("green", "yellow", "light blue", "red", "purple", "orange", "pink", "dark green"))



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
            # PlotType=="Multipanel_1_OperatingModel_MultipleControlRule"
                 # OperatingModelVector: A vector of operating model names
                 # PlotColor: Vector of colors for plot
            # PlotType=="1_ControlRule_MultipleOperatingModel"
                 # ControlRule: The name of the control rule associated with data
                 # PlotColor: Vector of colors for plot
            # PlotType=="Multipanel_1_ControlRule_MultipleOperatintModel"
                 # ControlRuleVector: A vector of control rule names
                 # PlotColor: Vector of colors for plot
            # PlotType=="Y_MultipleOperatingModel_X_MultipleControlRule"
                 # PlotColor: Vector of colors for plot, should be same length as nrow(Data)
            # PlotType=="X_MultipleOperatingModel_Y_MultipleControlRule"
                 # PlotColor: Vector of colors for plot, should be same length as ncol(Data)
  
  # Read in data
  Data <- read.table(Data)
  Data <- as.matrix(Data)
  
  # This turns data passed as extra arguments into a list for graphs to use
  ExtraArguments <- list(...) 
  
  if(PlotType=="1_OperatingModel_MultipleControlRule"){
    # 1 Operating Model, Multiple Control Rules
    barplot(height=Data[ExtraArguments$OperatingModel,], 
            width= rep(1,ncol(Data)), 
            space=1, 
            horiz=FALSE, 
            col=ExtraArguments$PlotColor, 
            xlab="Control Rule", 
            ylab=ylab,
            main=paste(main, "for", ExtraArguments$OperatingModel, sep=" "),
            axes=TRUE, 
            cex.axis=1, 
            cex.names=1, 
            offset=0)
  } else if(PlotType=="Multipanel_1_OperatingModel_MultipleConrolRule"){
    # Multipanel 1 Operating Model, Multiple Control Rules
    par(mfrow = c(4,3), mar=c(2,2,2,2))
        for(plot in 1:length(ExtraArguments$OperatingModelVector)){
          barplot(height=Data[plot,], 
                  width= rep(1,ncol(Data)), 
                  space=1, 
                  horiz=FALSE, 
                  col=ExtraArguments$PlotColor, 
                  xlab="Control Rule", 
                  ylab=ylab,
                  main=paste(main, "for", ExtraArguments$OperatingModel[plot], sep=" "),
                  axes=TRUE, 
                  cex.axis=1, 
                  cex.names=1, 
                  offset=0)  
        }
  } else if(PlotType=="1_ControlRule_MultipleOperatingModel"){
    # 1 Control Rule , Multiple Operating Models
    barplot(height=Data[,ExtraArguments$ControlRule], 
            width= rep(1,ncol(Data)), 
            space=1, 
            horiz=FALSE, 
            col=ExtraArguments$PlotColor, 
            xlab="Operating Model", 
            ylab=ylab,
            main=paste(main, "for", ExtraArguments$ControlRule, sep=" "), 
            axes=TRUE, 
            cex.axis=1, 
            cex.names=1, 
            offset=0)
  } else if(PlotType=="MultiPanel_1_ControlRule_MultipleOperatingModel"){
    # Multipanel 1 Control Rule, Multiple Operating Models
      par(mfrow=c(ncol(Data),3, mar=c(2,2,2,2)))
        
        for(plot in 1:length(ExtraArguments$ControlRuleVectors)){
          barplot(height=Data[plot,], 
                  width= rep(1,ncol(Data)), 
                  space=1, 
                  horiz=FALSE, 
                  col=ExtraArguments$PlotColor, 
                  xlab="Operating Model", 
                  ylab=ylab,
                  main=paste(main, "for", ExtraArguments$ControlRule[plot], sep=" "), 
                  axes=TRUE, 
                  cex.axis=1, 
                  cex.names=1, 
                  offset=0) 
         } 
  }  else if(PlotType=="Y_MultipleOperatingModel_X_MultipleControlRule"){
    # Grouped bar plot, bar for each operating model
    par(mar=c(5,4,4,7), xpd=TRUE)
    barplot(Data, col=ExtraArguments$PlotColor,
            width=1, 
            beside=TRUE,
            ylab=ylab,
            main=main)
    legend("topright", inset=c(-0.60,0), fill=ExtraArguments$PlotColor, legend=rownames(Data))
  } else if(PlotType=="X_MultipleOperatingModel_Y_MultipleControlRule"){
    # Grouped bar plot, bar for each control rule
    par(mar=c(5,4,4,7), xpd=TRUE)
    barplot(Data, col=ExtraArguments$PlotColor,
            width=1, 
            beside=TRUE,
            ylab=ylab,
            main=main)
    legend("topright", inset=c(-0.60,0), fill=ExtraArguments$PlotColor, legend=colnames(Data))
  }
}



# Code to make Multiple performance metrics plots
MultiplePerfMetricPlots <- function(Data=NULL, xlab=NULL, main=NULL, PlotType=NULL, PlotColor=NULL){
  # This function gives options for plotting values for a multiple performance metric across different operating models and/or control rules
  # It produces a grouped bar plot
  # Args:
       # Data: A matrix (PerfMet_vs_OM or PerfMet_vs_CR files produced by Make_OM_vs_PerfMet_Matrix() and Make_CR_vs_PerfMet_Matrix() functions)
            # Each row is a performance metric 
            # Columns are control rule or operating model
       # xlab: X-axis label, should be control rule or operating model depending on data
       # main: Main title for plot
       # PlotColor: Vector of colors for plot, should be equal to nrow(Data)
       # PlotType: name of plot type, options below with associated additional arguments
            # PlotType=="PerformanceMetric_OperatingModel", grouped by operating model
            # PlotType=="PerformanceMetric_ControlRule", grouped by control rule
  
 Data <- read.table(Data)
 Data <- as.matrix(Data)
  
 if(PlotType=="PerformanceMetric_OperatingModel"){
   # Grouped bar plot, bar for each performance metric, grouped by operating model
   par(mar=c(5,4,4,7), xpd=TRUE)
   barplot(Data, col=PlotColor,
           width=1, 
           beside=TRUE,
           xlab=xlab,
           ylab="Performance Metric Value",
           main=main)
   legend("topright", inset=c(-0.20,0), fill=PlotColor, legend=rownames(Data))
 } else if(PlotType=="PerformanceMetric_ControlRule"){
   # Grouped bar plot, bar for each performance metric, grouped by control rule
   par(mar=c(5,4,4,7), xpd=TRUE)
   barplot(Data, col=PlotColor,
           width=1, 
           beside=TRUE,
           xlab=xlab,
           ylab="Performance Metric Value",
           main=main)
   legend("topright", inset=c(-0.20,0), fill=PlotColor, legend=rownames(Data))
 } else {
   print(paste("Error", PlotType, sep=" "))
 }
}  
  
