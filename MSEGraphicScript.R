# MSE graphic code

######################## Functions which produces plots ###################################
ProducePlots <- function(OriginalDataFile=NULL, FilePath=NULL, ControlRuleNames=NULL, TranslatedControlRuleVector=NULL, ControlRuleColors=NULL, 
                         CRNumbers=NULL, PerformanceMetricVector=NULL, PerformanceMetricColors=PerformanceMetricColorsDefault,
                         TranslatedPerfMetVector=NULL, OperatingModelList=NULL, 
                         OperatingModelColors=OperatingModelColorsDefault, TranslatedOperatingModel=NULL){
  # Args:
       # OriginalDataFile: Matrix with a column for every performance metric, contains all data
       # FilePath: File path to MSE_Graphics project
       # ControlRuleNames: Vector of control rule names corresponding to data
       # TranslatedControlRuleVector: Vector of full control rule names, must be same order and length as ControlRuleNames
       # ControlRuleColors: Vector of colors equal in length to ControlRuleNames
            # default = ControlRuleColorsDefault, contains 9 colors
       # CRNumbers: Vector of control rule numbers, must be same order and length as CRNumbers
       # PerformanceMetricVector: Vector of performance metric names corresponding to data
       # PerformanceMetricColors: Vector of colors equal in length to PerformanceMetricVector
            # default = PerformanceMetricColorsDefault, contains 10 colors
       # TranslatedPerfMetVector: Vector of full performance metric names, must be same order and length of PerformanceMetrics
       # OperatingModelList: Vector of operating model names corresponding to data
       # OperatingModelColors: Vector of colors equal in length to OperatingModelList
            # default = OperatingModelColorsDefault, contains 8 colors
       # TranslatedOperatingModel: Vector of full operating model names, must be same order and length as OperatingModelList
  # Returns:
       # Formatted data matrices used for producing graphics
       # PNG files of different graphics for both BB and BB3yr implementation of control rule
            # Graphs multi-performance metrics, 1 operating model, grouped by control rule
            # Graphs multi-performance metrics, 1 control rule, grouped by operating model
            # Web/radar diagram, 1 operating model, web = multiple control rules, data = 1 performance metric
            # Web/radar diagram, 1 control rule, web = multiple operating models, data = 1 performance metric
  
  # Defaults
  ControlRuleColorsDefault <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#a8ddb5", "#084081", "#238443" , "#2b8cbe", "#7bccc4")
  OperatingModelColorsDefault <- c("#084081", "#0868ac", "#800026", "#bd0026", "#4eb3d3", "#a8ddb5", "#fc4e2a", "#feb24c")
  PerformanceMetricColorsDefault <- c("#084081", "#0868ac", "#800026", "#bd0026", "#4eb3d3", "#a8ddb5", "#fc4e2a", "#feb24c", "#238443", "#f768a1")
  # ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#a8ddb5", "#084081", "#0868ac" , "#2b8cbe", "#7bccc4")
  
  # Source files containing files containing functions
  source(paste(FilePath, "FormatHerringData.R", sep="/"))
  source(paste(FilePath, "BarPlotScript.R", sep="/"))
  
  ################################################ Subset Data For Graphics ######################################################
  ##### Full Subset Data #####
  CR_BB_Data <- ExtractCRInformation(OriginalDataFile=OriginalDataFile, ChooseYrs = "BB", CRNumbers = CRNumbers, 
                                     CRNames = ControlRuleNames, TranslatedCRName = TranslatedControlRuleVector)
  CR_BB3yr_Data <- ExtractCRInformation(OriginalDataFile=OriginalDataFile, ChooseYrs = "BB3yr", CRNumbers = CRNumbers, 
                                        CRNames = ControlRuleNames, TranslatedCRName = TranslatedControlRuleVector)
  AllSubsettedHerringData <- rbind(CR_BB_Data, CR_BB3yr_Data)
  
  ################################################ Produce Bargraphs ######################################################
  
  ########## Format Subsetted data for barplots ##########
  ##### Produce OM vs CR data files #####
  # Loop over performance metrics for BB data
  for(perfmet in PerformanceMetricVector){
    Make_OM_vs_CR_Matrix(OperatingModels=OperatingModelList, ControlRules = ControlRuleNames, 
                         Data = CR_BB_Data, PerformanceMetric=perfmet, ChooseYrs="BB", 
                         TranslatedOperatingModel=TranslatedOperatingModel,
                         TranslatedCRName = TranslatedControlRuleVector)
  }
  # Loop over performance metrics for BB3yr data
  for(perfmet in PerformanceMetricVector){
    Make_OM_vs_CR_Matrix(OperatingModels=OperatingModelList, ControlRules = ControlRuleNames, 
                         Data = CR_BB3yr_Data, PerformanceMetric=perfmet, ChooseYrs="BB3yr", 
                         TranslatedOperatingModel=TranslatedOperatingModel,
                         TranslatedCRName = TranslatedControlRuleVector)
  }
  
  ##### Make Operating Models vs Performance metric files #####
  # Loop over control rules for BB data
  for(i in 1:length(ControlRuleNames)){
    Make_OM_vs_PerfMet_Matrix(OperatingModels=OperatingModelList, ControlRule=ControlRuleNames[i], 
                              Data=CR_BB_Data, PerformanceMetrics=PerformanceMetricVector, ChooseYrs = "BB", 
                              TranslatedOperatingModel=TranslatedOperatingModel, TranslatedPerfMetVector=TranslatedPerfMetVector)
  }
  # Loop over control rules for BB3yr data
  for(i in 1:length(ControlRuleNames)){
    Make_OM_vs_PerfMet_Matrix(OperatingModels=OperatingModelList, ControlRule=ControlRuleNames[i], 
                              Data=CR_BB3yr_Data, PerformanceMetrics=PerformanceMetricVector, ChooseYrs = "BB3yr", 
                              TranslatedOperatingModel=TranslatedOperatingModel, TranslatedPerfMetVector=TranslatedPerfMetVector)
  }
  
  ###### Make Control Rule vs Performance metric files #####
  # Loop over control rules for BB data
  for(i in 1:length(OperatingModelList)){
    Make_CR_vs_PerfMet_Matrix(OperatingModel=OperatingModelList[i], ControlRules=ControlRuleNames, 
                              Data=CR_BB_Data, PerformanceMetrics = PerformanceMetricVector, ChooseYrs = "BB",
                              TranslatedPerfMetVector=TranslatedPerfMetVector, TranslatedCRName=TranslatedControlRuleVector)
  }
  # Loop over control rules for BB3yr data
  for(i in 1:length(OperatingModelList)){
    Make_CR_vs_PerfMet_Matrix(OperatingModel = OperatingModelList[i], ControlRules = ControlRuleNames, 
                              Data=CR_BB3yr_Data, PerformanceMetrics = PerformanceMetricVector, ChooseYrs = "BB3yr",
                              TranslatedPerfMetVector=TranslatedPerfMetVector, TranslatedCRName=TranslatedControlRuleVector)
  }
  
  ##### Make Web diagram Performance metric vs. CR for 1 OM files
  # Loop over operating models for BB data
  for(i in 1:length(OperatingModelList)){
    Make_WebDiagram_Matrix_1_OM(OperatingModel=OperatingModelList[i], ControlRule=ControlRuleNames, 
                                Data=CR_BB_Data, PerformanceMetrics=PerformanceMetricVector, ChooseYrs = "BB",
                                TranslatedPerfMetVector=TranslatedPerfMetVector, TranslatedCRName=TranslatedControlRuleVector)
  }
  # Loop over operating models for BB3yr data
  for(i in 1:length(OperatingModelList)){
    Make_WebDiagram_Matrix_1_OM(OperatingModel=OperatingModelList[i], ControlRule=ControlRuleNames, 
                                Data=CR_BB3yr_Data, PerformanceMetrics=PerformanceMetricVector, ChooseYrs = "BB3yr",
                                TranslatedPerfMetVector=TranslatedPerfMetVector, TranslatedCRName=TranslatedControlRuleVector)
  }
  
  ##### Make Web diagram Performance metric vs. OM for 1 CR files
  # Loop over control rules for BB data
  for(i in 1: length(ControlRuleNames)){
    Make_WebDiagram_Matrix_1_CR(OperatingModels=OperatingModelList, ControlRule=ControlRuleNames[i], 
                                Data=CR_BB_Data, PerformanceMetrics=PerformanceMetricVector, ChooseYrs = "BB",
                                TranslatedOperatingModel=TranslatedOperatingModel, TranslatedPerfMetVector=TranslatedPerfMetVector)
  }
  # Loop over control rules for BB3yr data
  for(i in 1: length(ControlRuleNames)){
    Make_WebDiagram_Matrix_1_CR(OperatingModels=OperatingModelList, ControlRule=ControlRuleNames[i], 
                                Data=CR_BB_Data, PerformanceMetrics=PerformanceMetricVector, ChooseYrs = "BB3yr",
                                TranslatedOperatingModel=TranslatedOperatingModel, TranslatedPerfMetVector=TranslatedPerfMetVector)
  }
  
  ########## Make Bargraphs ##########
  ##### Make plot with multiple performance metrics vs. multiple control rules for one operating model #####              THESE 2 WORK
  # Loop over operating models for BB data
  for(om in 1:length(OperatingModelList)){ # ????????? fix legend in png file
    OutputFileName <- paste("Graph_PerfMet_vs_CR_BB", OperatingModelList[om], ".png", sep="_")
    MultiplePerfMetricPlots(Data=paste(paste(FilePath, "Data_PerfMet_vs_CR_BB", sep="/"), OperatingModelList[om], sep="_"), 
                            xlab= "Control Rules", 
                            main= paste("Performance Metric Values for \n Operating Model", TranslatedOperatingModel[om], "BB", sep=" "),
                            PlotColor = PerformanceMetricColors,
                            PlotType="PerformanceMetric_ControlRule",
                            OutputFile = OutputFileName)
  }
  # Loop over operating models for BB3yr data
  for(om in 1: length(OperatingModelList)){
    OutputFileName <-  paste("Graph_PerfMet_vs_CR_BB3yr", OperatingModelList[om], ".png", sep="_")
    MultiplePerfMetricPlots(Data=paste(paste(FilePath, "Data_PerfMet_vs_CR_BB3yr", sep="/"), OperatingModelList[om], sep="_"), 
                            xlab= "Control Rules", 
                            main= paste("Performance Metric Values for \n Operating Model", TranslatedOperatingModel[om], "BB3yr", sep=" "),
                            PlotColor = PerformanceMetricColors,
                            PlotType="PerformanceMetric_ControlRule", 
                            OutputFile = OutputFileName)
  }
  
  ##### Make plot with multiple performance metrics vs. multiple operating models for one control rule #####               THESE 2 WORK
  # Loop over control rules for BB data
  for(cr in 1: length(ControlRuleNames)){
    OutputFileName <- paste("Graph_PerfMet_vs_OM_BB", ControlRuleNames[cr], ".png", sep="_")
    MultiplePerfMetricPlots(Data=paste(paste(FilePath, "Data_PerfMet_vs_OM_BB", sep="/"), ControlRuleNames[cr], sep="_"),
                            xlab="Operating Models",
                            main=paste("Performance Metric Values for \n Control Rule", TranslatedControlRuleVector[cr], "BB", sep=" "),
                            PlotColor = PerformanceMetricColors,
                            PlotType = "PerformanceMetric_OperatingModel",
                            OutputFile = OutputFileName)
  }
  # Loop over control rules for BB3yr data
  for(cr in 1: length(ControlRuleNames)){
    OutputFileName <- paste("Graph_PerfMet_vs_OM_BB3yr", ControlRuleNames[cr], ".png", sep="_")
    MultiplePerfMetricPlots(Data=paste(paste(FilePath, "Data_PerfMet_vs_OM_BB3yr", sep="/"), ControlRuleNames[cr], sep="_"),
                            xlab="Operating Models",
                            main=paste("Performance Metric Values for \n Control Rule", TranslatedControlRuleVector[cr], "BB3yr", sep=" "),
                            PlotColor = PerformanceMetricColors,
                            PlotType = "PerformanceMetric_OperatingModel",
                            OutputFile = OutputFileName)
  }

  ##### Make multipanel plot with one performance metric vs. multiple control rules for one operating model #####             THESE 2 WORK
  # Loop over performance metrics for BB data
  for(pm in 1: length(PerformanceMetricVector)){
    OutputFileName <- paste("Graph_Multipanel_One_OM_vs_CR_BB", PerformanceMetricVector[pm], ".png", sep="_")
    SinglePerfMetricPlots(Data = paste(paste(FilePath, "Data_OM_vs_CR_BB", sep="/"), PerformanceMetricVector[pm], sep="_"), 
                          # ylab = TranslatedPerfMetVector[pm], 
                          main = TranslatedPerfMetVector[pm],
                          PlotType = "MultiPanel_1_OperatingModel_MultipleControlRule", 
                          OperatingModelVector = OperatingModelList, 
                          PlotColor = OperatingModelColors,
                          OutputFile = OutputFileName)
  }
  # Loop over performance metrics for BB3yr data
  for(pm in 1: length(PerformanceMetricVector)){
    OutputFileName <- paste("Graph_Multipanel_One_OM_vs_CR_BB3yr", PerformanceMetricVector[pm], ".png", sep="_")
    SinglePerfMetricPlots(Data = paste(paste(FilePath, "Data_OM_vs_CR_BB3yr", sep="/"), PerformanceMetricVector[pm], sep="_"), 
                          # ylab = TranslatedPerfMetVector[pm], 
                          main = TranslatedPerfMetVector[pm],
                          PlotType = "MultiPanel_1_OperatingModel_MultipleControlRule", 
                          OperatingModelVector = OperatingModelList, 
                          PlotColor = OperatingModelColors, 
                          OutputFile = OutputFileName)
  }
  
  ##### Make plots with multiple control rules and multiple operating models for one performance metric #####               # STILL TESTING
  # Loop over performance metrics for BB data
  for(pm in 1: length(PerformanceMetricVector)){
    OutputFileName <- paste("Graph_MultipleOM_MultipleCR_BB", PerformanceMetricVector[pm], ".png", sep="_")
    SinglePerfMetricPlots(Data = paste(paste(FilePath, "Data_OM_vs_CR_BB", sep="/"), PerformanceMetricVector[pm], sep="_"),
                          # ylab = TranslatedPerfMetVector[pm],
                          main = paste(TranslatedPerfMetVector[pm], "for BB", sep=" "),
                          PlotType = "Y_MultipleOperatingModel_X_MultipleControlRule",
                          PlotColor = ControlRuleColors,
                          OutputFile = OutputFileName)
  }
  # Loop over performance metrics for BB3yr data
  for(pm in 1: length(PerformanceMetricVector)){
    OutputFileName <- paste("Graph_MultipleOM_MultipleCR_BB3yr", PerformanceMetricVector[pm], sep="_")
    SinglePerfMetricPlots(Data = paste(paste(FilePath, "Data_OM_vs_CR_BB3yr", sep="/"), PerformanceMetricVector[pm], sep="_"),
                          # ylab = TranslatedPerfMetVector[pm],
                          main = paste(TranslatedPerfMetVector[pm], "for BB3yr", sep=" "),
                          PlotType = "Y_MultipleOperatingModel_X_MultipleControlRule",
                          PlotColor = ControlRuleColors,
                          OutputFile = OutputFileName)
  }

  ########## Make Web/Radar Diagrams ##########
  source(paste(FilePath, "WebDiagramScript.R", sep="/"))

  ##### Make Web diagrams, each web = performance metrics for one operating model under same control rule #####             THESE 2 WORK
  # Loop over control rules for BB data
  for(cr in 1:length(ControlRuleNames)){
    WebDiagramPlots(Data = paste(paste(FilePath, "Data_Web_PerfMet_vs_OM_BB", sep="/"), ControlRuleNames[cr], sep="_" ),
                    PlotColor=OperatingModelColors,
                    LegendLabels = paste("Operating Model", TranslatedOperatingModel),
                    AxisLabels = TranslatedPerfMetVector,
                    OutputFileName = paste("Graph_Web_PerfMet_vs_OM_BB", ControlRuleNames[cr], ".png", sep="_"),
                    MainTitle = paste("Control Rule", TranslatedControlRuleVector[cr], sep=" "))
  }
  # Loop over control rules for BB3yr data
  for(cr in 1:length(ControlRuleNames)){
    WebDiagramPlots(Data = paste(paste(FilePath, "Data_Web_PerfMet_vs_OM_BB3yr", sep="/"), ControlRuleNames[cr], sep="_" ),
                    PlotColor=OperatingModelColors,
                    LegendLabels = paste("Operating Model", TranslatedOperatingModel),
                    AxisLabels = TranslatedPerfMetVector,
                    OutputFileName = paste("Graph_Web_PerfMet_vs_OM_BB3yr", ControlRuleNames[cr], ".png", sep="_"),
                    MainTitle = paste("Control Rule", TranslatedControlRuleVector[cr], sep=" "))
  }

  ##### Make web diagrams, each web= performance metrics for one control rule under the same operating model #####          THESE 2 WORK
  # Loop over operating models for BB data
  for(om in 1:length(OperatingModelList)){
    WebDiagramPlots(Data = paste(paste(FilePath, "Data_Web_PerfMet_vs_CR_BB", sep="/"), OperatingModelList[om], sep="_" ),
                    PlotColor=ControlRuleColors,
                    LegendLabels = paste("Control Rule", TranslatedControlRuleVector),
                    AxisLabels = TranslatedPerfMetVector,
                    OutputFileName = paste("Graph_Web_PerfMet_vs_CR_BB", OperatingModelList[om], ".png", sep="_"),
                    MainTitle = paste("Operating Model", TranslatedOperatingModel[om], sep=" "))
  }
  # Loop over operating models for BB3yr data
  for(om in 1:length(OperatingModelList)){
    WebDiagramPlots(Data = paste(paste(FilePath, "Data_Web_PerfMet_vs_CR_BB3yr", sep="/"), OperatingModelList[om], sep="_" ),
                    PlotColor=ControlRuleColors,
                    LegendLabels = paste("Control Rule", TranslatedControlRuleVector),
                    AxisLabels = TranslatedPerfMetVector,
                    OutputFileName = paste("Graph_Web_PerfMet_vs_CR_BB3yr", OperatingModelList[om], ".png", sep="_"),
                    MainTitle = paste("Operating Model", TranslatedOperatingModel[om], sep=" "))
  }
  
  # This doesnt work currently ??????????????????
  # ##### Make multipanel plot with one performance metric vs. multiple operating model for one control rule #####            # THESE 2 DONT WORK
  # # Loop over performance metrics for BB data
  # for(pm in 1: length(PerformanceMetricVector)){
  #   png(filename = paste("Graph_Multipanel_One_CR_vs_OM_BB", PerformanceMetricVector[pm], ".png", sep="_"))
  #   SinglePerfMetricPlots(Data=paste(paste(FilePath, "Data_OM_vs_CR_BB", sep="/"), PerformanceMetricVector[pm], sep="_"),
  #                         ylab= TranslatedPerfMetVector[pm],
  #                         main= TranslatedPerfMetVector[pm],
  #                         PlotType= "MultiPanel_1_ControlRule_MultipleOperatingModel",
  #                         ControlRuleVector = ControlRuleNames,
  #                         PlotColor = OperatingModelColors)
  #   dev.off()
  # }
  # # Loop over performance metrics for BB3yr
  # for(pm in 1:length(PerformanceMetricVector)){
  #   png(filename = paste("Graph_Multipanel_One_CR_vs_OM_BB3yr", sep="/"), PerformanceMetricVector[pm], ".png", sep="_")
  #   SinglePerfMetricPlots(Data=paste(paste(FilePath, "Data_OM_vs_CR_BB3yr", sep="/"), PerformanceMetricVector[pm], sep="_"),
  #                         ylab= TranslatedPerfMetVector[pm],
  #                         main= TranslatedPerfMetVector[pm],
  #                         PlotType= "MultiPanel_1_ControlRule_MultipleOperatingModel",
  #                         ControlRuleVector = ControlRuleNames,
  #                         PlotColor = OperatingModelColors)
  #   dev.off()
  # }
  

}






################################################ Produce Decision Tables ######################################################

##### Set up info for Decision Table Function #####
# RowNames
CRList <- c("CR1", "CR2", "CR3", "CR4", "CR5", "CR6", "CR7", "CR8", "CR9")

#GraphicLayout information for all 9 control rules and 8 operating models
GraphicLayoutAllOMs <- c(  1,  1,  1,  1,  2,  3,  4,  5,  6,  7,  8,
                           9,  9,  9,  9,  9,  9,  9,  9,  9,  9,  9,
                          10, 11, 11, 11, 11, 11, 11, 11, 11, 11,  8,
                          10, 12, 12, 12, 12, 12, 12, 12, 12, 12,  12,
                          10, 13, 14, 15, 16, 17, 18, 19, 20, 21,  8,
                          22, 22, 22, 22, 22, 22, 22, 22, 22, 22,  22,
                          23, 24, 25, 26, 27, 28, 29, 30, 31, 32,  8,
                          33, 33, 33, 33, 33, 33, 33, 33, 33, 33,  33,
                          34, 35, 36, 37, 38, 39, 40, 41, 42, 43,  8,
                          44, 44, 44, 44, 44, 44, 44, 44, 44, 44,  44,
                          45, 46, 47, 48, 49, 50, 51, 52, 53, 54,  8,
                          55, 55, 55, 55, 55, 55, 55, 55, 55, 55,  55,
                          56, 57, 58, 59, 60, 61, 62, 63, 64, 65,  8,
                          66, 66, 66, 66, 66, 66, 66, 66, 66, 66,  66,
                          67, 68, 69, 70, 71, 72, 73, 74, 75, 76,  8,
                          77, 77, 77, 77, 77, 77, 77, 77, 77, 77,  77,
                          78, 79, 80, 81, 82, 83, 84, 85, 86, 87,  8,
                          88, 88, 88, 88, 88, 88, 88, 88, 88, 88,  88,
                          89, 90, 91, 92, 93, 94, 95, 96, 97, 98,  8,
                          99, 99, 99, 99, 99, 99, 99, 99, 99, 99,  99,
                         100,101,102,103,104,105,106,107,108,109,  8,
                         110,110,110,110,110,110,110,110,110,110,  110)

# # This didn't fix the problem with the horizontal lines touching the edge
# GraphicLayoutAllOMs <- c(  1,  1,  1,  1,  2,  3,  4,  5,  6,  7,  8,
#                            9,  9,  9,  9,  9,  9,  9,  9,  9,  9,  9,
#                           10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
#                           10, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
#                           10, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22,
#                           23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23,
#                           24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
#                           35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35,
#                           36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46,
#                           47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
#                           48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 
#                           59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59,
#                           60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
#                           71, 71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
#                           72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82,
#                           83, 83, 83, 83, 83, 83, 83, 83, 83, 83, 83,
#                           84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94,
#                           95, 95, 95, 95, 95, 95, 95, 95, 95, 95, 95, 
#                           96, 97, 98, 99,100,101,102,103,104,105,106,
#                          107,107,107,107,107,107,107,107,107,107,107,
#                          108,109,110,111,112,113,114,115,116,117,118,
#                          119,119,119,119,119,119,119,119,119,119,119)

GraphicRowsAllOMs <- 22
GraphicColumnsAllOMs <- 11
GraphicHeightsAllOMs <- c(1,0.25,1,0.25,1,0.25,rep(c(2,0.25), GraphicRowsAllOMs/2-3))
GraphicWidthsALLOMs <- c(2,rep(1, GraphicColumnsAllOMs-1),0.5)

MSE_TranslatedOperatingModel <- c("A", "B", "C", "D", "E", "F", "G", "H")
MSE_TranslatedControlRuleVector <- c("1","2","3","4A","4B","4C","4D","4E","4F")
MSE_ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#a8ddb5", "#084081", "#238443" , "#2b8cbe", "#7bccc4")


# setwd to file with graphics
setwd("/Users/arhart/Research/MSE_Graphics/Icons")
IconList=c("HerringFishery", "HerringResource", "LobsterFishery", "TunaFishery", "WhaleSeabirdWatching")



# Extract data for barplots from Data_OM_vs_CR_BB3yr file
Data <- read.table("/Users/arhart/Research/MSE_Graphics/Data_OM_vs_CR_BB3yr_Yvar")
Data <- as.matrix(Data)

MakeGraphicDecisionTable(Title="Interannual Variation in Yield", 
                         IconList=c("HerringFishery", "HerringResource", "LobsterFishery", "TunaFishery", "WhaleSeabirdWatching"),
                         RowCategoryName = "Operating \n Models", 
                         ColumnCategoryName = "Control Rule Options", 
                         RowNames = MSE_TranslatedOperatingModel,
                         ColumnNames = MSE_TranslatedControlRuleVector,
                         GraphicLayout = GraphicLayoutAllOMs, 
                         GraphicNRow = GraphicRowsAllOMs, 
                         GraphicNCol = GraphicColumnsAllOMs, 
                         GraphicHeights = GraphicHeightsAllOMs,
                         GraphicWidths = GraphicWidthsALLOMs,
                         
                         VerticalBarData = Data, VerticalBarWidths = 0.5,
                         VerticalBarColors=MSE_ControlRuleColors, VerticalBarXLabel="Test", VerticalBarYLabel="YVar",
                         VerticalBarAxes = TRUE,
                         OutputFileName = "TestDecisionTable3"
                         
                         # VerticalBarData = TestList, VerticalBarWidths = rep(1,ncol(Data)),
                         # VerticalBarColors=MSE_ControlRuleColors, VerticalBarXLabel=paste(TestList[[1]][1], sep=""), VerticalBarYLabel="YVar",
                         # VerticalBarAxes = TRUE,
                         
                         #VerticalBarData = TestList[1], VerticalBarWidths = rep(1,ncol(Data)),
                         #VerticalBarColors=MSE_ControlRuleColors, VerticalBarXLabel=paste(TestList[[2]][1], sep=""), VerticalBarYLabel="YVar",
                         #VerticalBarAxes = TRUE
                         )


################################################# Produce Graphs #######################################################
# Performance metrics to focus on
     # % MSY >= 100%, acceptable level as low as 85%
          # PropSSBrelSSBmsy = Proportion Years Herring SSB < SSBmsy(Median)
          # PropSSBrelhalfSSBmsy = Proportino years herring SSB < 0.5SSBmsy(Median)
          # PropSSBrel3SSBzero = Proportion years herring SSB <0.3SSBf=0 (Median)
          # PropSSBrel75SSBzero = Proportion years herring SSB<0.75SSBf=0 (Median)
     # Variation in annual yield, preferably <10%, as high as <25%
          # Yvar = Interannual Variation in Herring Yield (Median)
          # YieldrelMSY = Herring yield relative to MSY (Median)
          # p50_IAVNR = Interannual variation in net revenue (Median)
          # p50_IAVGR = Interannual variation in gross revenue (Median)
          # Probability of overfished =0%, acceptable up to <25%
          # PropFrelFmsy = Proportion years with overfishing (Median)
     # Probability of herring closure (ABC=0) between <0-10%
          # PropClosure = Proportion years with fishery closure (ABC=0; Median)

##### To Change Control Rules Plotted #####
# Remove corresponding items from both
     # ControlRuleNames and CRNumbers
##### To Change Performance Metrics Plotted #####
# Add or remove corresponding items from both 
     # PerformanceMetricVector and TranslatedPerfMetVector
##### To Change Operating Models Plotted ##### 
# Add or remove corresponding items from both
     # OperatingModelList and TranslatedOperatingModel


MSE_OriginalDataFile <- "/Users/arhart/Downloads/allres.rds"
MSE_ControlRuleNames <- c("StrawmanA", "StrawmanB", "Params upfront", "MeetCriteria1", "MeetCriteria2", "MeetCriteria3", "MeetCriteria4", "MeetCriteria5", "MeetCriteria6")
MSE_TranslatedControlRuleVector <- c("1","2","3","4A","4B","4C","4D","4E","4F") 
MSE_ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#a8ddb5", "#084081", "#238443" , "#2b8cbe", "#7bccc4")
MSE_CRNumbers <- c(4191, 12858, 5393, 4171, 4272, 4373, 5171, 5363, 7161)
MSE_PerformanceMetricVector <- c("YieldrelMSY", "Yvar", "PropSSBrelhalfSSBmsy", "PropClosure")
MSE_PerformanceMetricColors <- c("#084081", "#feb24c", "#4eb3d3", "#fc4e2a")
MSE_TranslatedPerfMetVector <- c("Yield Relative to MSY", "Interannual Variation in Yield", "Probability of Overfished", "Prop Year Closure Occurs")
MSE_FilePath <- "/Users/arhart/Research/MSE_Graphics"
MSE_OperatingModelList <- c("HiM_LowSteep_AssBias_OldWt", "HiM_LowSteep_AssBias_RecWt", "HiM_LowSteep_NoAssBias_OldWt", 
                            "HiM_LowSteep_NoAssBias_RecWt", "LoM_HiSteep_AssBias_OldWt", "LoM_HiSteep_AssBias_RecWt", 
                            "LoM_HiSteep_NoAssBias_OldWt", "LoM_HiSteep_NoAssBias_RecWt")
MSE_OperatingModelColors <- c("#084081", "#0868ac", "#800026", "#bd0026", "#4eb3d3", "#a8ddb5", "#fc4e2a", "#feb24c")
MSE_TranslatedOperatingModel <- c("A", "B", "C", "D", "E", "F", "G", "H")


# Performance metrics of interest
# MSE_PerformanceMetricVector <- c("PropSSBrelSSBmsy", "PropSSBrelhalfSSBmsy", "PropSSBrel3SSBzero", "PropSSBrel75SSBzero", "Yvar", "YieldrelMSY",
#                             "p50_IAVNR", "p50_IAVGR", "PropFrelFmsy", "PropClosure")
# Easily interpreted names of performance metrics, must be same order/length as PerformanceMetricVector, but should be more descriptive
# MSE_TranslatedPerfMetVector <- c("Prop Years SSB < SSBmsy", "Prop Years SSB < 0.5 SSBmsy", "Prop Years SSB < 0.3 SSBf=0", "Prop Years SSB < 0.75 SSBf=0", "Interannual Variation in Yield",
#                              "Yield Relative to MSY", "Interannual Variation Net Revenue", "Interannual Variation Gross Revenue", "Prop Years Overfishing Occurs", "Prop Year Closure Occurs")


# This formats the data and makes all associated plots
ProducePlots(OriginalDataFile = MSE_OriginalDataFile, 
             ControlRuleNames = MSE_ControlRuleNames, 
             TranslatedControlRuleVector = MSE_TranslatedControlRuleVector,
             ControlRuleColors = MSE_ControlRuleColors, 
             CRNumbers = MSE_CRNumbers, 
             PerformanceMetricVector = MSE_PerformanceMetricVector, 
             TranslatedPerfMetVector = MSE_TranslatedPerfMetVector,
             PerformanceMetricColors = MSE_PerformanceMetricColors, 
             OperatingModelList = MSE_OperatingModelList,
             TranslatedOperatingModel = MSE_TranslatedOperatingModel, 
             OperatingModelColors = MSE_OperatingModelColors,
             FilePath = MSE_FilePath)
