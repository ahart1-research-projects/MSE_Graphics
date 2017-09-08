##### This script makes the final graphics for the 3-year CR implementation #######

############################ After 8/30/17 Revisions to Graphics stored in HerringMSE_Final_Graphics ###########################################

# Format data for Decision tables using barplot function
MSE_OriginalDataFile <- "/Users/ahart2/Downloads/allres.rds"
MSE_ControlRuleNames <- c("StrawmanA", "StrawmanB", "Params upfront", "MeetCriteria1", "MeetCriteria2", "MeetCriteria3", "MeetCriteria4", "MeetCriteria5", "MeetCriteria6")
MSE_TranslatedControlRuleVector <- c(" 1"," 2"," 3"," 4A", "4B", "4C", "4D", "4E", "4F") 
MSE_ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#a8ddb5", "#084081", "#238443" , "#2b8cbe", "#7bccc4")
MSE_CRNumbers <- c(4191, 12858, 5393, 4171, 4272, 4373, 5171, 5363, 7161)
MSE_PerformanceMetricColors <- c("#084081", "#feb24c", "#4eb3d3", "#fc4e2a", "#a8ddb5", "#238443", "#f768a1", "#bd0026", "#78c679", "#bcbddc", "#ffeda0")
MSE_PerformanceMetricVector <- c("PropSSBrelSSBmsy", "PropSSBrelhalfSSBmsy", "MedSSBrelSSBzero", "PropSSBrel30_75SSBzero", "SurpProd", "MedPredAvWt_status", "AvPropYrs_okBstatusgf", 
                                 "PropFrelFmsy", "YieldrelMSY", "Yield", "PropClosure", "p50_NR", "NetRevEquilibrium", "Yvar", "MedPropYrs_goodProd_Targplustern")
MSE_TranslatedPerfMetVector <- c("Prop Year Biomass < Bmsy", "Probability of Overfished B < 0.5 Bmsy", "SSB Relative to Unfished Biomass", "Prop Year SSB is 30-75% of SSB Zero", "Surplus Production", "Tuna Weight Status", "Prop Year Good Dogfish Biomass",
                                 "Prop Year Overfishing Occurs F > Fmsy", "Yield Relative to MSY", "Yield", "Prop Year Closure Occurs", "Net Revenue for Herring", "Prop Year Net Revenue at Equilibrium",
                                 "Interannual Variation in Yield", "Prop Year Tern Production > 1")

MSE_FilePath <- "/Users/ahart2/Research/MSE_Graphics"
MSE_OperatingModelList <- c("HiM_LowSteep_AssBias_OldWt", "HiM_LowSteep_AssBias_RecWt", "HiM_LowSteep_NoAssBias_OldWt", 
                            "HiM_LowSteep_NoAssBias_RecWt", "LoM_HiSteep_AssBias_OldWt", "LoM_HiSteep_AssBias_RecWt", 
                            "LoM_HiSteep_NoAssBias_OldWt", "LoM_HiSteep_NoAssBias_RecWt")
MSE_OperatingModelColors <- c("#084081", "#0868ac", "#800026", "#bd0026", "#4eb3d3", "#a8ddb5", "#fc4e2a", "#feb24c")
MSE_TranslatedOperatingModel <- c("A", "B", "C", "D", "E", "F", "G", "H")
MSE_OutputDirectory <- "HerringMSE_Final_Graphics"

ProduceBarPlots(OriginalDataFile = MSE_OriginalDataFile, 
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
                FilePath = MSE_FilePath,
                OutputDirectory = MSE_OutputDirectory)





##### Make Ranked decision tables for each performance metric ##### 

GraphicLayoutAllOMs <- c(  1,  1,  1,  1,  1,  1,  1,  2,  3,  4,   5,  
                           6,  6,  6,  6,  6,  6,  6,  6,  6,  6,   5,  
                           7,  8,  8,  8,  8,  8,  8,  8,  8,  8,   5,
                           7,  9,  9,  9,  9,  9,  9,  9,  9,  9,   5,
                           7, 10, 11, 12, 13, 14, 15, 16, 17, 18,   5,
                           19, 19, 19, 19, 19, 19, 19, 19, 19, 19,   5,
                           20, 21, 22, 23, 24, 25, 26, 27, 28, 29,   5,
                           30, 30, 30, 30, 30, 30, 30, 30, 30, 30,   5,
                           31, 32, 33, 34, 35, 36, 37, 38, 39, 40,   5,
                           41, 41, 41, 41, 41, 41, 41, 41, 41, 41,   5,
                           42, 43, 44, 45, 46, 47, 48, 49, 50, 51,   5,
                           52, 52, 52, 52, 52, 52, 52, 52, 52, 52,   5, 
                           53, 54, 55, 56, 57, 58, 59, 60, 61, 62,   5,
                           63, 63, 63, 63, 63, 63, 63, 63, 63, 63,   5, 
                           64, 65, 66, 67, 68, 69, 70, 71, 72, 73,   5,
                           74, 74, 74, 74, 74, 74, 74, 74, 74, 74,   5,
                           75, 76, 77, 78, 79, 80, 81, 82, 83, 84,   5,
                           85, 85, 85, 85, 85, 85, 85, 85, 85, 85,   5,
                           86, 87, 88, 89, 90, 91, 92, 93, 94, 95,   5,
                           96, 96, 96, 96, 96, 96, 96, 96, 96, 96,   5, 
                           97, 98, 99,100,101,102,103,104,105,106,   5,
                           107,107,107,107,107,107,107,107,107,107,   5, 
                           108,109,110,111,112,113,114,115,116,117,   5,
                           118,118,118,118,118,118,118,118,118,118,   5)



GraphicRowsAllOMs <- 24
GraphicColumnsAllOMs <- 11
GraphicHeightsAllOMs <- c(1,0.25,1,0.25,1,0.25,rep(c(2,0.25), GraphicRowsAllOMs/2-3))
GraphicWidthsALLOMs <- c(2,rep(1, GraphicColumnsAllOMs-1),0.25)

MSE_TranslatedOperatingModel <- c("A", "B", "C", "D", "E", "F", "G", "H", "Summary")
MSE_TranslatedControlRuleVector <- c("1","2","3","4A","4B","4C","4D","4E","4F")
MSE_PerfMetColors <- c("#ffffe5","#f7fcb9","#d9f0a3","#addd8e","#78c679","#41ab5d","#238443","#006837","#004529")
MSE_OutputDirectory <- "/Users/ahart2/Research/MSE_Graphics/HerringMSE_Final_Graphics"
MSE_PerformanceMetricVector <- c("PropSSBrelSSBmsy", "PropSSBrelhalfSSBmsy", "MedSSBrelSSBzero", "PropSSBrel30_75SSBzero", "SurpProd", "MedPredAvWt_status", "AvPropYrs_okBstatusgf", 
                                 "PropFrelFmsy", "YieldrelMSY", "Yield", "PropClosure", "p50_NR", "NetRevEquilibrium", "Yvar", "MedPropYrs_goodProd_Targplustern")
MSE_TranslatedPerfMetVector <- c("Prop Year Biomass < Bmsy", "Probability of Overfished B < 0.5 Bmsy", "SSB Relative to Unfished Biomass", "Prop Year SSB is 30-75% of SSB Zero", "Surplus Production", "Tuna Weight Status", "Prop Year Good Dogfish Biomass",
                                 "Prop Year Overfishing Occurs F > Fmsy", "Yield Relative to MSY", "Yield", "Prop Year Closure Occurs", "Net Revenue for Herring", "Prop Year Net Revenue at Equilibrium",
                                 "Interannual Variation in Yield", "Prop Year Tern Production > 1")

# Loop over performance metrics to produce tables
for(i in 1:length(MSE_PerformanceMetricVector)){
  MSE_OutputFile <- paste("RankedDecisionTable", MSE_PerformanceMetricVector[i], sep="_") 
  
  # setwd to file with graphics
  setwd("/Users/ahart2/Research/MSE_Graphics/Icons")
  if(MSE_TranslatedPerfMetVector[i]=="Prop Year Biomass < Bmsy"){
    IconList = c("HerringResource")
  } else if(MSE_TranslatedPerfMetVector[i]=="Probability of Overfished B < 0.5 Bmsy"){
    IconList = c("HerringResource", "HerringMackerelLobsterFisheries")
  } else if(MSE_TranslatedPerfMetVector[i]=="SSB Relative to Unfished Biomass"){
    IconList = c("HerringResource", "UnprotectedPredators", "Protected&Tourism")
  } else if(MSE_TranslatedPerfMetVector[i]=="Surplus Production"){
    IconList = c("HerringResource", "UnprotectedPredators", "Protected&Tourism")
  } else if(MSE_TranslatedPerfMetVector[i]=="Tuna Weight Status"){
    IconList = c("UnprotectedPredators", "TunaGroundfishFishery")
  } else if(MSE_TranslatedPerfMetVector[i]=="Prop Year Good Dogfish Biomass"){
    IconList = c("UnprotectedPredators", "TunaGroundfishFishery")
  } else if(MSE_TranslatedPerfMetVector[i]=="Prop Year Overfishing Occurs F > Fmsy"){
    IconList = c("HerringResource", "HerringMackerelLobsterFisheries")
  } else if(MSE_TranslatedPerfMetVector[i]=="Yield Relative to MSY"){
    IconList = c("HerringMackerelLobsterFisheries")
  } else if(MSE_TranslatedPerfMetVector[i]=="Yield"){
    IconList = c("HerringMackerelLobsterFisheries")
  } else if(MSE_TranslatedPerfMetVector[i]=="Prop Year Closure Occurs"){
    IconList = c("HerringMackerelLobsterFisheries")
  } else if(MSE_TranslatedPerfMetVector[i]=="Net Revenue for Herring"){
    IconList = c("HerringMackerelLobsterFisheries")
  } else if(MSE_TranslatedPerfMetVector[i]=="Interannual Variation in Yield"){
    IconList = c("HerringMackerelLobsterFisheries")
  } else if(MSE_TranslatedPerfMetVector[i]=="Prop Year Tern Production > 1"){
    IconList = c("Protected&Tourism")
  } else if(MSE_TranslatedPerfMetVector[i]=="Prop Year SSB is 30-75% of SSB Zero"){
    IconList = c("HerringResource", "UnprotectedPredators", "Protected&Tourism")
  } else if(MSE_TranslatedPerfMetVector[i]=="Prop Year Net Revenue at Equilibrium"){
    IconList = c("HerringMackerelLobsterFisheries")
  }
  
  # Extract data for barplots from Data_OM_vs_CR_BB3yr file
  Data <- read.table(paste("/Users/ahart2/Research/MSE_Graphics/HerringMSE_Final_Graphics/Data_OM_vs_CR_BB3yr", MSE_PerformanceMetricVector[i], sep="_"))
  Data <- as.matrix(Data)
  
  MakePerfMetGraphicDecisionTable(OutputDirectory= MSE_OutputDirectory,
                                  Title=MSE_TranslatedPerfMetVector[i], 
                                  IconList=IconList, 
                                  RowCategoryName = "Operating \n Models", 
                                  ColumnCategoryName = "Control Rule Options", 
                                  RowNames = MSE_TranslatedOperatingModel,
                                  ColumnNames = MSE_TranslatedControlRuleVector,
                                  GraphicLayout = GraphicLayoutAllOMs, 
                                  GraphicNRow = GraphicRowsAllOMs, 
                                  GraphicNCol = GraphicColumnsAllOMs, 
                                  GraphicHeights = GraphicHeightsAllOMs,
                                  GraphicWidths = GraphicWidthsALLOMs,
                                  
                                  VerticalBarData = Data, 
                                  VerticalBarWidths = 0.5,
                                  VerticalBarColors=MSE_PerfMetColors, 
                                  #VerticalBarXLabel="Test", 
                                  #VerticalBarYLabel="YVar",
                                  VerticalBarAxes = TRUE,
                                  OutputFileName = MSE_OutputFile)
}

################### Make ranked summary data by VEC ##########################################################################
##### Herring Resource VEC #####
GraphicLayoutAllOMs <- c(  1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  3,  
                           4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  3,  
                           5,  6,  6,  6,  6,  6,  6,  6,  6,  6,  3,
                           5,  7,  7,  7,  7,  7,  7,  7,  7,  7,  3,
                           5,  8,  9, 10, 11, 12, 13, 14, 15, 16,  3,
                          17, 17, 17, 17, 17, 17, 17, 17, 17, 17,  3,
                          18, 19, 20, 21, 22, 23, 24, 25, 26, 27,  3,
                          28, 28, 28, 28, 28, 28, 28, 28, 28, 28,  3,
                          29, 30, 31, 32, 33, 34, 35, 36, 37, 38,  3,
                          39, 39, 39, 39, 39, 39, 39, 39, 39, 39,  3,
                          40, 41, 42, 43, 44, 45, 46, 47, 48, 49,  3,
                          50, 50, 50, 50, 50, 50, 50, 50, 50, 50,  3,
                          51, 52, 53, 54, 55, 56, 57, 58, 59, 60,  3,
                          61, 61, 61, 61, 61, 61, 61, 61, 61, 61,  3, 
                          62, 63, 64, 65, 66, 67, 68, 69, 70, 71,  3,
                          72, 72, 72, 72, 72, 72, 72, 72, 72, 72,  3,
                          73, 74, 75, 76, 77, 78, 79, 80, 81, 82,  3,
                          83, 83, 83, 83, 83, 83, 83, 83, 83, 83,  3)#6



GraphicRowsAllOMs <- 18
GraphicColumnsAllOMs <- 11
GraphicHeightsAllOMs <- c(1,0.25,1,0.25,1,0.25,rep(c(2,0.25), GraphicRowsAllOMs/2-3))
GraphicWidthsALLOMs <- c(2,rep(1, GraphicColumnsAllOMs-1),0.25)
MSE_ImageWidth <- 700
MSE_ImageHeight <- 850

MSE_TranslatedControlRuleVector <- c("1","2","3","4A","4B","4C","4D","4E","4F")
MSE_OutputDirectory <- "/Users/ahart2/Research/MSE_Graphics/HerringMSE_Final_Graphics"
MSE_SummaryPerformanceMetricVector <- c("PropSSBrelSSBmsy", "PropSSBrelhalfSSBmsy", "MedSSBrelSSBzero", "PropSSBrel30_75SSBzero", "SurpProd", "PropFrelFmsy")
MSE_SummaryTranslatedPerfMetVector <- c("Prop Year Biomass < Bmsy","Probability of Overfished B < 0.5 Bmsy","SSB Relative to Unfished Biomass", 
                                        "Prop Year SSB is 30-75% of SSB Zero", "Surplus Production", "Prop Year Overfishing Occurs F > Fmsy")
MSE_OutputFile <- "VEC_HerringResource"
MSE_IconList <- "HerringResource"

Data <- matrix(NA, nrow=length(MSE_SummaryPerformanceMetricVector), ncol=length(MSE_TranslatedControlRuleVector))
colnames(Data) <- MSE_TranslatedControlRuleVector

for(i in 1:length(MSE_SummaryPerformanceMetricVector)){
  # Extract data for barplots from Rank file
  tempData <- read.csv(paste("/Users/ahart2/Research/MSE_Graphics/HerringMSE_Final_Graphics/Rank", MSE_SummaryTranslatedPerfMetVector[i], sep="_"))
  tempData <- data.matrix(tempData)
  tempData <- tempData[ ,-1]
  # print(tempData)
  tempData <- colSums(tempData)
  Data[i,] <- tempData
}
rownames(Data) <- MSE_SummaryTranslatedPerfMetVector

MakeVECSummaryGraphicDecisionTable(OutputDirectory= MSE_OutputDirectory,
                                   Title= "Valued Ecosystem Component: Herring Resource", 
                                   IconList=MSE_IconList, 
                                   RowCategoryName = "Performance \n Metrics", 
                                   ColumnCategoryName = "Control Rule Options", 
                                   RowNames = MSE_SummaryTranslatedPerfMetVector,
                                   ColumnNames = MSE_TranslatedControlRuleVector,
                                   GraphicLayout = GraphicLayoutAllOMs, 
                                   GraphicNRow = GraphicRowsAllOMs, 
                                   GraphicNCol = GraphicColumnsAllOMs, 
                                   GraphicHeights = GraphicHeightsAllOMs,
                                   GraphicWidths = GraphicWidthsALLOMs,
                                   ImageWidth = MSE_ImageWidth,
                                   ImageHeight = MSE_ImageHeight,
                                   
                                   VerticalBarData = Data, 
                                   VerticalBarWidths = 0.5,
                                   VerticalBarColors=MSE_PerfMetColors, 
                                   #VerticalBarXLabel="Test", 
                                   #VerticalBarYLabel="YVar",
                                   VerticalBarAxes = TRUE,
                                   OutputFileName = MSE_OutputFile)

##### Predator species VEC #####
GraphicLayoutAllOMs <- c(  1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  3,  
                           4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  3,  
                           5,  6,  6,  6,  6,  6,  6,  6,  6,  6,  3,
                           5,  7,  7,  7,  7,  7,  7,  7,  7,  7,  3,
                           5,  8,  9, 10, 11, 12, 13, 14, 15, 16,  3,
                          17, 17, 17, 17, 17, 17, 17, 17, 17, 17,  3,
                          18, 19, 20, 21, 22, 23, 24, 25, 26, 27,  3,
                          28, 28, 28, 28, 28, 28, 28, 28, 28, 28,  3,
                          29, 30, 31, 32, 33, 34, 35, 36, 37, 38,  3,
                          39, 39, 39, 39, 39, 39, 39, 39, 39, 39,  3,
                          40, 41, 42, 43, 44, 45, 46, 47, 48, 49,  3,
                          50, 50, 50, 50, 50, 50, 50, 50, 50, 50,  3,
                          51, 52, 53, 54, 55, 56, 57, 58, 59, 60,  3,
                          61, 61, 61, 61, 61, 61, 61, 61, 61, 61,  3,
                          62, 63, 64, 65, 66, 67, 68, 69, 70, 71,  3,
                          72, 72, 72, 72, 72, 72, 72, 72, 72, 72,  3)#5

GraphicRowsAllOMs <- 16
GraphicColumnsAllOMs <- 11
GraphicHeightsAllOMs <- c(1,0.25,1,0.25,1,0.25,rep(c(2,0.25), GraphicRowsAllOMs/2-3))
GraphicWidthsALLOMs <- c(2,rep(1, GraphicColumnsAllOMs-1),0.25)
MSE_ImageWidth <- 700
MSE_ImageHeight <- 750

MSE_TranslatedControlRuleVector <- c("1","2","3","4A","4B","4C","4D","4E","4F")
MSE_OutputDirectory <- "/Users/ahart2/Research/MSE_Graphics/HerringMSE_Final_Graphics"
MSE_SummaryPerformanceMetricVector <- c("MedSSBrelSSBzero", "PropSSBrel30_75SSBzero", "SurpProd", "MedPredAvWt_status", "AvPropYrs_okBstatusgf")
MSE_SummaryTranslatedPerfMetVector <- c("SSB Relative to Unfished Biomass", "Prop Year SSB is 30-75% of SSB Zero", "Surplus Production", "Tuna Weight Status", "Prop Year Good Dogfish Biomass")
MSE_IconList <- "UnprotectedPredators"
MSE_OutputFile <- "VEC_PredatorSpecies"

for(i in 1:length(MSE_SummaryPerformanceMetricVector)){
  # Extract data for barplots from Rank file
  tempData <- read.csv(paste("/Users/ahart2/Research/MSE_Graphics/HerringMSE_Final_Graphics/Rank", MSE_SummaryTranslatedPerfMetVector[i], sep="_"))
  tempData <- data.matrix(tempData)
  tempData <- tempData[ ,-1]
  # print(tempData)
  tempData <- colSums(tempData)
  Data[i,] <- tempData
}
rownames(Data) <- MSE_SummaryTranslatedPerfMetVector

MakeVECSummaryGraphicDecisionTable(OutputDirectory= MSE_OutputDirectory,
                                   Title= "Valued Ecosystem Component: Predator Species", 
                                   IconList=MSE_IconList, 
                                   RowCategoryName = "Performance \n Metrics", 
                                   ColumnCategoryName = "Control Rule Options", 
                                   RowNames = MSE_SummaryTranslatedPerfMetVector,
                                   ColumnNames = MSE_TranslatedControlRuleVector,
                                   GraphicLayout = GraphicLayoutAllOMs, 
                                   GraphicNRow = GraphicRowsAllOMs, 
                                   GraphicNCol = GraphicColumnsAllOMs, 
                                   GraphicHeights = GraphicHeightsAllOMs,
                                   GraphicWidths = GraphicWidthsALLOMs,
                                   ImageWidth = MSE_ImageWidth,
                                   ImageHeight = MSE_ImageHeight,
                                   
                                   VerticalBarData = Data, 
                                   VerticalBarWidths = 0.5,
                                   VerticalBarColors=MSE_PerfMetColors, 
                                   #VerticalBarXLabel="Test", 
                                   #VerticalBarYLabel="YVar",
                                   VerticalBarAxes = TRUE,
                                   OutputFileName = MSE_OutputFile)


##### Protected Resources & Ecotourism VEC #####
GraphicLayoutAllOMs <- c(  1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  3,  
                           4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  3,  
                           5,  6,  6,  6,  6,  6,  6,  6,  6,  6,  3,
                           5,  7,  7,  7,  7,  7,  7,  7,  7,  7,  3,
                           5,  8,  9, 10, 11, 12, 13, 14, 15, 16,  3,
                          17, 17, 17, 17, 17, 17, 17, 17, 17, 17,  3,
                          18, 19, 20, 21, 22, 23, 24, 25, 26, 27,  3, 
                          28, 28, 28, 28, 28, 28, 28, 28, 28, 28,  3,
                          29, 30, 31, 32, 33, 34, 35, 36, 37, 38,  3,
                          39, 39, 39, 39, 39, 39, 39, 39, 39, 39,  3,
                          40, 41, 42, 43, 44, 45, 46, 47, 48, 49,  3,
                          50, 50, 50, 50, 50, 50, 50, 50, 50, 50,  3,
                          51, 52, 53, 54, 55, 56, 57, 58, 59, 60,  3,
                          61, 61, 61, 61, 61, 61, 61, 61, 61, 61,  3) #4 


GraphicRowsAllOMs <- 14
GraphicColumnsAllOMs <- 11
GraphicHeightsAllOMs <- c(1,0.25,1,0.25,1,0.25,rep(c(2,0.25), GraphicRowsAllOMs/2-3))
GraphicWidthsALLOMs <- c(2,rep(1, GraphicColumnsAllOMs-1),0.25)
MSE_ImageWidth <- 700
MSE_ImageHeight <- 700

MSE_TranslatedControlRuleVector <- c("1","2","3","4A","4B","4C","4D","4E","4F")
MSE_OutputDirectory <- "/Users/ahart2/Research/MSE_Graphics/HerringMSE_Final_Graphics"
MSE_SummaryPerformanceMetricVector <- c("MedSSBrelSSBzero", "PropSSBrel30_75SSBzero", "SurpProd", "MedPropYrs_goodProd_Targplustern")
MSE_SummaryTranslatedPerfMetVector <- c("SSB Relative to Unfished Biomass", "Prop Year SSB is 30-75% of SSB Zero", "Surplus Production", "Prop Year Tern Production > 1")
MSE_IconList <- "Protected&Tourism"
MSE_OutputFile <- "VEC_ProtectedResources_Ecotourism"

Data <- matrix(NA, nrow=length(MSE_SummaryPerformanceMetricVector), ncol=length(MSE_TranslatedControlRuleVector))
colnames(Data) <- MSE_TranslatedControlRuleVector

for(i in 1:length(MSE_SummaryPerformanceMetricVector)){
  # Extract data for barplots from Rank file
  tempData <- read.csv(paste("/Users/ahart2/Research/MSE_Graphics/HerringMSE_Final_Graphics/Rank", MSE_SummaryTranslatedPerfMetVector[i], sep="_"))
  tempData <- data.matrix(tempData)
  tempData <- tempData[ ,-1]
  # print(tempData)
  tempData <- colSums(tempData)
  Data[i,] <- tempData
}
rownames(Data) <- MSE_SummaryTranslatedPerfMetVector

MakeVECSummaryGraphicDecisionTable(OutputDirectory= MSE_OutputDirectory,
                                   Title= "Valued Ecosystem Component: \n Protected Resources & Ecotourism", 
                                   IconList = MSE_IconList, 
                                   RowCategoryName = "Performance \n Metrics", 
                                   ColumnCategoryName = "Control Rule Options", 
                                   RowNames = MSE_SummaryTranslatedPerfMetVector,
                                   ColumnNames = MSE_TranslatedControlRuleVector,
                                   GraphicLayout = GraphicLayoutAllOMs, 
                                   GraphicNRow = GraphicRowsAllOMs, 
                                   GraphicNCol = GraphicColumnsAllOMs, 
                                   GraphicHeights = GraphicHeightsAllOMs,
                                   GraphicWidths = GraphicWidthsALLOMs,
                                   ImageWidth = MSE_ImageWidth,
                                   ImageHeight = MSE_ImageHeight,
                                   
                                   VerticalBarData = Data, 
                                   VerticalBarWidths = 0.5,
                                   VerticalBarColors=MSE_PerfMetColors, 
                                   #VerticalBarXLabel="Test", 
                                   #VerticalBarYLabel="YVar",
                                   VerticalBarAxes = TRUE,
                                   OutputFileName = MSE_OutputFile)


##### Herring, Mackerel & Lobster Fisheries VEC #####
GraphicLayoutAllOMs <- c(  1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  3,  
                           4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  3,  
                           5,  6,  6,  6,  6,  6,  6,  6,  6,  6,  3,
                           5,  7,  7,  7,  7,  7,  7,  7,  7,  7,  3,
                           5,  8,  9, 10, 11, 12, 13, 14, 15, 16,  3,
                          17, 17, 17, 17, 17, 17, 17, 17, 17, 17,  3,
                          18, 19, 20, 21, 22, 23, 24, 25, 26, 27,  3,
                          28, 28, 28, 28, 28, 28, 28, 28, 28, 28,  3,
                          29, 30, 31, 32, 33, 34, 35, 36, 37, 38,  3,
                          39, 39, 39, 39, 39, 39, 39, 39, 39, 39,  3,
                          40, 41, 42, 43, 44, 45, 46, 47, 48, 49,  3,
                          50, 50, 50, 50, 50, 50, 50, 50, 50, 50,  3,
                          51, 52, 53, 54, 55, 56, 57, 58, 59, 60,  3,
                          61, 61, 61, 61, 61, 61, 61, 61, 61, 61,  3,
                          62, 63, 64, 65, 66, 67, 68, 69, 70, 71,  3,
                          72, 72, 72, 72, 72, 72, 72, 72, 72, 72,  3,#5
                          73, 74, 75, 76, 77, 78, 79, 80, 81, 82,  3,
                          83, 83, 83, 83, 83, 83, 83, 83, 83, 83,  3,#6
                          84, 85, 86, 87, 88, 89, 90, 91, 92, 93,  3,
                          94, 94, 94, 94, 94, 94, 94, 94, 94, 94,  3, #7
                          95, 96, 97, 98, 99,100,101,102,103,104,  3,
                         105,105,105,105,105,105,105,105,105,105,  3) #8 


GraphicRowsAllOMs <- 22
GraphicColumnsAllOMs <- 11
GraphicHeightsAllOMs <- c(1,0.25,1,0.25,1,0.25,rep(c(2,0.25), GraphicRowsAllOMs/2-3))
GraphicWidthsALLOMs <- c(2,rep(1, GraphicColumnsAllOMs-1),0.25)
MSE_ImageWidth <- 700
MSE_ImageHeight <- 1000

MSE_TranslatedControlRuleVector <- c("1","2","3","4A","4B","4C","4D","4E","4F")
MSE_OutputDirectory <- "/Users/ahart2/Research/MSE_Graphics/HerringMSE_Final_Graphics"
MSE_SummaryPerformanceMetricVector <- c("PropSSBrelhalfSSBmsy", "PropFrelFmsy", "YieldrelMSY", "Yield", "PropClosure", "p50_NR","NetRevEquilibrium",  "Yvar")
MSE_SummaryTranslatedPerfMetVector <- c("Probability of Overfished B < 0.5 Bmsy", "Prop Year Overfishing Occurs F > Fmsy", "Yield Relative to MSY",
                                        "Yield", "Prop Year Closure Occurs", "Net Revenue for Herring", "Prop Year Net Revenue at Equilibrium", "Interannual Variation in Yield")
MSE_IconList <- "HerringMackerelLobsterFisheries"
MSE_OutputFile <- "VEC_Herring_Mackerel_Lobster_Fisheries"

Data <- matrix(NA, nrow=length(MSE_SummaryPerformanceMetricVector), ncol=length(MSE_TranslatedControlRuleVector))
colnames(Data) <- MSE_TranslatedControlRuleVector

for(i in 1:length(MSE_SummaryPerformanceMetricVector)){
  # Extract data for barplots from Rank file
  tempData <- read.csv(paste("/Users/ahart2/Research/MSE_Graphics/HerringMSE_Final_Graphics/Rank", MSE_SummaryTranslatedPerfMetVector[i], sep="_"))
  tempData <- data.matrix(tempData)
  tempData <- tempData[ ,-1]
  # print(tempData)
  tempData <- colSums(tempData)
  Data[i,] <- tempData
}
rownames(Data) <- MSE_SummaryTranslatedPerfMetVector

MakeVECSummaryGraphicDecisionTable(OutputDirectory= MSE_OutputDirectory,
                                   Title= "Valued Ecosystem Component: Herring, Mackerel \n & Lobster Fisheries", 
                                   IconList = MSE_IconList, 
                                   RowCategoryName = "Performance \n Metrics", 
                                   ColumnCategoryName = "Control Rule Options", 
                                   RowNames = MSE_SummaryTranslatedPerfMetVector,
                                   ColumnNames = MSE_TranslatedControlRuleVector,
                                   GraphicLayout = GraphicLayoutAllOMs, 
                                   GraphicNRow = GraphicRowsAllOMs, 
                                   GraphicNCol = GraphicColumnsAllOMs, 
                                   GraphicHeights = GraphicHeightsAllOMs,
                                   GraphicWidths = GraphicWidthsALLOMs,
                                   ImageWidth = MSE_ImageWidth,
                                   ImageHeight = MSE_ImageHeight,
                                   
                                   VerticalBarData = Data, 
                                   VerticalBarWidths = 0.5,
                                   VerticalBarColors=MSE_PerfMetColors, 
                                   #VerticalBarXLabel="Test", 
                                   #VerticalBarYLabel="YVar",
                                   VerticalBarAxes = TRUE,
                                   OutputFileName = MSE_OutputFile)



##### Predator Fisheries VEC #####
GraphicLayoutAllOMs <- c(  1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  3,  
                           4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  3,  
                           5,  6,  6,  6,  6,  6,  6,  6,  6,  6,  3,
                           5,  7,  7,  7,  7,  7,  7,  7,  7,  7,  3,
                           5,  8,  9, 10, 11, 12, 13, 14, 15, 16,  3,
                           17, 17, 17, 17, 17, 17, 17, 17, 17, 17,  3,
                           18, 19, 20, 21, 22, 23, 24, 25, 26, 27,  3,
                           28, 28, 28, 28, 28, 28, 28, 28, 28, 28,  3,
                           29, 30, 31, 32, 33, 34, 35, 36, 37, 38,  3,
                           39, 39, 39, 39, 39, 39, 39, 39, 39, 39,  3)

GraphicRowsAllOMs <- 10
GraphicColumnsAllOMs <- 11
GraphicHeightsAllOMs <- c(1,0.25,1,0.25,1,0.25,rep(c(2,0.25), GraphicRowsAllOMs/2-3))
GraphicWidthsALLOMs <- c(2,rep(1, GraphicColumnsAllOMs-1),0.25)
MSE_ImageWidth <- 700
MSE_ImageHeight <- 400

MSE_TranslatedControlRuleVector <- c("1","2","3","4A","4B","4C","4D","4E","4F")
MSE_OutputDirectory <- "/Users/ahart2/Research/MSE_Graphics/HerringMSE_Final_Graphics"
MSE_SummaryPerformanceMetricVector <- c("MedPredAvWt_status", "AvPropYrs_okBstatusgf")
MSE_SummaryTranslatedPerfMetVector <- c("Tuna Weight Status", "Prop Year Good Dogfish Biomass")
MSE_IconList <- "TunaGroundfishFishery"
MSE_OutputFile <- "VEC_PredatorFisheries"

Data <- matrix(NA, nrow=length(MSE_SummaryPerformanceMetricVector), ncol=length(MSE_TranslatedControlRuleVector))
colnames(Data) <- MSE_TranslatedControlRuleVector

for(i in 1:length(MSE_SummaryPerformanceMetricVector)){
  # Extract data for barplots from Rank file
  tempData <- read.csv(paste("/Users/ahart2/Research/MSE_Graphics/HerringMSE_Final_Graphics/Rank", MSE_SummaryTranslatedPerfMetVector[i], sep="_"))
  tempData <- data.matrix(tempData)
  tempData <- tempData[ ,-1]
  # print(tempData)
  tempData <- colSums(tempData)
  Data[i,] <- tempData
}
rownames(Data) <- MSE_SummaryTranslatedPerfMetVector

MakeVECSummaryGraphicDecisionTable(OutputDirectory= MSE_OutputDirectory,
                                   Title= "Valued Ecosystem Component: Predator Fisheries", 
                                   IconList = MSE_IconList, 
                                   RowCategoryName = "Performance \n Metrics", 
                                   ColumnCategoryName = "Control Rule Options", 
                                   RowNames = MSE_SummaryTranslatedPerfMetVector,
                                   ColumnNames = MSE_TranslatedControlRuleVector,
                                   GraphicLayout = GraphicLayoutAllOMs, 
                                   GraphicNRow = GraphicRowsAllOMs, 
                                   GraphicNCol = GraphicColumnsAllOMs, 
                                   GraphicHeights = GraphicHeightsAllOMs,
                                   GraphicWidths = GraphicWidthsALLOMs,
                                   ImageWidth = MSE_ImageWidth,
                                   ImageHeight = MSE_ImageHeight,
                                   
                                   VerticalBarData = Data, 
                                   VerticalBarWidths = 0.5,
                                   VerticalBarColors=MSE_PerfMetColors, 
                                   #VerticalBarXLabel="Test", 
                                   #VerticalBarYLabel="YVar",
                                   VerticalBarAxes = TRUE,
                                   OutputFileName = MSE_OutputFile)


####################### Targeted Graphics ###################################################

# Web diagrams for 4 OM and 6 performance metrics to highlight tradeoffs

MSE_OriginalDataFile <- "/Users/ahart2/Downloads/allres.rds"
MSE_ControlRuleNames <- c("StrawmanA", "StrawmanB", "Params upfront", "MeetCriteria1", "MeetCriteria5")
MSE_TranslatedControlRuleVector <- c(" 1"," 2"," 3"," 4A", "4E") 
MSE_ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#2b8cbe")
MSE_CRNumbers <- c(4191, 12858, 5393, 4171, 5363)
MSE_PerformanceMetricVector <- c("MedPropYrs_goodProd_Targplustern", "p50_NR", "YieldrelMSY", "Yvar", "PropClosure","PropFrelFmsy")
MSE_TranslatedPerfMetVector <- c("Prop Year Tern Production > 1", "Net Revenue for Herring", "Yield Relative to MSY", 
                                 "Interannual Variation in Yield", "Prop Year Closure Occurs", "Prop Year Overfishing Occurs F > Fmsy")

MSE_FilePath <- "/Users/ahart2/Research/MSE_Graphics"
MSE_OperatingModelList <- c( "HiM_LowSteep_AssBias_RecWt", "HiM_LowSteep_NoAssBias_RecWt", 
                             "LoM_HiSteep_AssBias_RecWt", "LoM_HiSteep_NoAssBias_RecWt")
MSE_OperatingModelColors <- c("#0868ac", "#bd0026", "#a8ddb5", "#feb24c")
MSE_TranslatedOperatingModel <- c("B", "D", "F", "H")
MSE_OutputDirectory <- "HerringMSE_Final_Graphics"

ProduceWebPlots(OriginalDataFile = MSE_OriginalDataFile, 
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
                FilePath = MSE_FilePath,
                OutputDirectory = MSE_OutputDirectory,
                CustomTitle <- "FocusedWeb")



# Run for Tuna bargraph for Growth senario all 8 OM

MSE_OriginalDataFile <- "/Users/ahart2/Downloads/allres.rds"
MSE_ControlRuleNames <- c("StrawmanA", "StrawmanB", "Params upfront", "MeetCriteria1", "MeetCriteria5")
MSE_TranslatedControlRuleVector <- c(" 1"," 2"," 3"," 4A", "4E") 
MSE_ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#2b8cbe")
MSE_CRNumbers <- c(4191, 12858, 5393, 4171, 5363)
MSE_PerformanceMetricColors <- c("#084081", "#feb24c", "#4eb3d3", "#fc4e2a", "#a8ddb5", "#238443", "#f768a1", "#bd0026", "#78c679", "#bcbddc", "#ffeda0")
MSE_PerformanceMetricVector <- c("PropSSBrelSSBmsy", "PropSSBrelhalfSSBmsy", "MedSSBrelSSBzero", "PropSSBrel30_75SSBzero", "SurpProd", "MedPredAvWt_status", "AvPropYrs_okBstatusgf", 
                                 "PropFrelFmsy", "YieldrelMSY", "Yield", "PropClosure", "p50_NR", "NetRevEquilibrium", "Yvar", "MedPropYrs_goodProd_Targplustern")
MSE_TranslatedPerfMetVector <- c("Prop Year Biomass < Bmsy", "Probability of Overfished B < 0.5 Bmsy", "SSB Relative to Unfished Biomass", "Prop Year SSB is 30-75% of SSB Zero", "Surplus Production", "Tuna Weight Status", "Prop Year Good Dogfish Biomass",
                                 "Prop Year Overfishing Occurs F > Fmsy", "Yield Relative to MSY", "Yield", "Prop Year Closure Occurs", "Net Revenue for Herring",
                                 "Prop Year Net Revenue at Equilibrium",  "Interannual Variation in Yield", "Prop Year Tern Production > 1")

MSE_FilePath <- "/Users/ahart2/Research/MSE_Graphics"
MSE_OperatingModelList <- c("HiM_LowSteep_AssBias_OldWt", "HiM_LowSteep_AssBias_RecWt", "HiM_LowSteep_NoAssBias_OldWt", 
                            "HiM_LowSteep_NoAssBias_RecWt", "LoM_HiSteep_AssBias_OldWt", "LoM_HiSteep_AssBias_RecWt", 
                            "LoM_HiSteep_NoAssBias_OldWt", "LoM_HiSteep_NoAssBias_RecWt")
MSE_OperatingModelColors <- c("#084081", "#0868ac", "#800026", "#bd0026", "#4eb3d3", "#a8ddb5", "#fc4e2a", "#feb24c")
MSE_TranslatedOperatingModel <- c("A", "B", "C", "D", "E", "F", "G", "H")
MSE_OutputDirectory <- "HerringMSE_Final_Graphics"

ProduceBarPlots(OriginalDataFile = MSE_OriginalDataFile, 
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
                FilePath = MSE_FilePath,
                OutputDirectory = MSE_OutputDirectory)


################### Diagnostic Plots ########################################################
##### Full Web Diagrams With All Performance Metrics #####

# Web diagrams for 4 OM and all performance metrics

MSE_OriginalDataFile <- "/Users/ahart2/Downloads/allres.rds"
MSE_ControlRuleNames <- c("StrawmanA", "StrawmanB", "Params upfront", "MeetCriteria1", "MeetCriteria5")
MSE_TranslatedControlRuleVector <- c(" 1"," 2"," 3"," 4A", "4E") 
MSE_ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#2b8cbe")
MSE_CRNumbers <- c(4191, 12858, 5393, 4171, 5363)
MSE_PerformanceMetricVector <- c("PropSSBrelSSBmsy", "PropSSBrelhalfSSBmsy", "MedSSBrelSSBzero", "PropSSBrel30_75SSBzero", "SurpProd", "MedPredAvWt_status", "AvPropYrs_okBstatusgf", 
                                 "PropFrelFmsy", "YieldrelMSY", "Yield", "PropClosure", "p50_NR", "NetRevEquilibrium", "Yvar", "MedPropYrs_goodProd_Targplustern")
MSE_TranslatedPerfMetVector <- c("Prop Year Biomass < Bmsy", "Probability of Overfished B < 0.5 Bmsy", "SSB Relative to Unfished Biomass", "Prop Year SSB is 30-75% of SSB Zero", "Surplus Production", "Tuna Weight Status", "Prop Year Good Dogfish Biomass",
                                 "Prop Year Overfishing Occurs F > Fmsy", "Yield Relative to MSY", "Yield", "Prop Year Closure Occurs", "Net Revenue for Herring", "Prop Year Net Revenue at Equilibrium",
                                 "Interannual Variation in Yield", "Prop Year Tern Production > 1")
MSE_CustomTitle <- "AllPerfMetDiagnostic"

MSE_FilePath <- "/Users/ahart2/Research/MSE_Graphics"
MSE_OperatingModelList <- c( "HiM_LowSteep_AssBias_RecWt", "HiM_LowSteep_NoAssBias_RecWt", 
                             "LoM_HiSteep_AssBias_RecWt", "LoM_HiSteep_NoAssBias_RecWt")
MSE_OperatingModelColors <- c("#0868ac", "#bd0026", "#a8ddb5", "#feb24c")
MSE_TranslatedOperatingModel <- c("B", "D", "F", "H")
MSE_OutputDirectory <- "HerringMSE_Final_Graphics"

ProduceWebPlots(OriginalDataFile = MSE_OriginalDataFile, 
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
                FilePath = MSE_FilePath,
                OutputDirectory = MSE_OutputDirectory,
                CustomTitle <- MSE_CustomTitle)


# Web diagrams for 4 OM and all performance metrics 25% CI

MSE_OriginalDataFile <- "/Users/ahart2/Downloads/allres.rds"
MSE_ControlRuleNames <- c("StrawmanA", "StrawmanB", "Params upfront", "MeetCriteria1", "MeetCriteria5")
MSE_TranslatedControlRuleVector <- c(" 1"," 2"," 3"," 4A", "4E") 
MSE_ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#2b8cbe")
MSE_CRNumbers <- c(4191, 12858, 5393, 4171, 5363)
# Missing NetRevEquilibrium
MSE_PerformanceMetricVector <- c("PropSSBrelSSBmsy_25", "PropSSBrelhalfSSBmsy_25", "MedSSBrelSSBzero_25", "PropSSBrel30_75SSBzero_25", "SurpProd_25", "Q25PredAvWt_status", "Q25PropYrs_okBstatus", 
                                 "PropFrelFmsy_25", "YieldrelMSY_25", "Yield_25", "PropClosure_25", "p25_NR",  "Yvar_25", "Q25PropYrs_goodProd_Targplustern")
MSE_TranslatedPerfMetVector <- c("Prop Year Biomass < Bmsy", "Probability of Overfished B < 0.5 Bmsy", "SSB Relative to Unfished Biomass", "Prop Year SSB is 30-75% of SSB Zero", "Surplus Production", "Tuna Weight Status", "Prop Year Good Dogfish Biomass",
                                 "Prop Year Overfishing Occurs F > Fmsy", "Yield Relative to MSY", "Yield", "Prop Year Closure Occurs", "Net Revenue for Herring", 
                                 "Interannual Variation in Yield", "Prop Year Tern Production > 1")

# MSE_PerformanceMetricVector <- c("PropSSBrelSSBmsy_25", "PropSSBrelhalfSSBmsy_25", "MedSSBrelSSBzero_25", "PropSSBrel30_75SSBzero_25", "SurpProd_25", "Q25PredAvWt_status", "Q25PropYrs_okBstatus", 
#                                  "PropFrelFmsy_25", "YieldrelMSY_25", "Yield_25", "PropClosure_25", "p25_NR", "NetRevEquilibrium_25", "Yvar_25", "Q25PropYrs_goodProd_Targplustern")
# MSE_TranslatedPerfMetVector <- c("Prop Year Biomass < Bmsy", "Probability of Overfished B < 0.5 Bmsy", "SSB Relative to Unfished Biomass", "Prop Year SSB is 30-75% of SSB Zero", "Surplus Production", "Tuna Weight Status", "Prop Year Good Dogfish Biomass",
#                                  "Prop Year Overfishing Occurs F > Fmsy", "Yield Relative to MSY", "Yield", "Prop Year Closure Occurs", "Net Revenue for Herring", "Prop Year Net Revenue at Equilibrium",
#                                  "Interannual Variation in Yield", "Prop Year Tern Production > 1")
MSE_CustomTitle <- "25PercentCI"

MSE_FilePath <- "/Users/ahart2/Research/MSE_Graphics"
MSE_OperatingModelList <- c( "HiM_LowSteep_AssBias_RecWt", "HiM_LowSteep_NoAssBias_RecWt", 
                             "LoM_HiSteep_AssBias_RecWt", "LoM_HiSteep_NoAssBias_RecWt")
MSE_OperatingModelColors <- c("#0868ac", "#bd0026", "#a8ddb5", "#feb24c")
MSE_TranslatedOperatingModel <- c("B", "D", "F", "H")
MSE_OutputDirectory <- "HerringMSE_Final_Graphics"

ProduceWebPlots(OriginalDataFile = MSE_OriginalDataFile, 
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
                FilePath = MSE_FilePath,
                OutputDirectory = MSE_OutputDirectory,
                CustomTitle = MSE_CustomTitle)


# Web diagrams for 4 OM and all performance metrics 75% CI

MSE_OriginalDataFile <- "/Users/ahart2/Downloads/allres.rds"
MSE_ControlRuleNames <- c("StrawmanA", "StrawmanB", "Params upfront", "MeetCriteria1", "MeetCriteria5")
MSE_TranslatedControlRuleVector <- c(" 1"," 2"," 3"," 4A", "4E") 
MSE_ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#2b8cbe")
MSE_CRNumbers <- c(4191, 12858, 5393, 4171, 5363)
# Missing NetRevEquilibrium
MSE_PerformanceMetricVector <- c("PropSSBrelSSBmsy_75", "PropSSBrelhalfSSBmsy_75", "MedSSBrelSSBzero_75", "PropSSBrel30_75SSBzero_25", "SurpProd_75", "Q75PredAvWt_status", "Q75PropYrs_okBstatus", 
                                 "PropFrelFmsy_75", "YieldrelMSY_75", "Yield_75", "PropClosure_75", "p75_NR", "NetRevEquilibrium_75", "Yvar_75", "Q75PropYrs_goodProd_Targplustern")
MSE_TranslatedPerfMetVector <- c("Prop Year Biomass < Bmsy", "Probability of Overfished B < 0.5 Bmsy", "SSB Relative to Unfished Biomass", "Prop Year SSB is 30-75% of SSB Zero", "Surplus Production", "Tuna Weight Status", "Prop Year Good Dogfish Biomass",
                                 "Prop Year Overfishing Occurs F > Fmsy", "Yield Relative to MSY", "Yield", "Prop Year Closure Occurs", "Net Revenue for Herring", 
                                 "Interannual Variation in Yield", "Prop Year Tern Production > 1")

# MSE_PerformanceMetricVector <- c("PropSSBrelSSBmsy_75", "PropSSBrelhalfSSBmsy_75", "MedSSBrelSSBzero_75", "PropSSBrel30_75SSBzero_25", "SurpProd_75", "Q75PredAvWt_status", "Q75PropYrs_okBstatus", 
#                                  "PropFrelFmsy_75", "YieldrelMSY_75", "Yield_75", "PropClosure_75", "p75_NR", "NetRevEquilibrium_75", "Yvar_75", "Q75PropYrs_goodProd_Targplustern")
# MSE_TranslatedPerfMetVector <- c("Prop Year Biomass < Bmsy", "Probability of Overfished B < 0.5 Bmsy", "SSB Relative to Unfished Biomass", "Prop Year SSB is 30-75% of SSB Zero", "Surplus Production", "Tuna Weight Status", "Prop Year Good Dogfish Biomass",
#                                  "Prop Year Overfishing Occurs F > Fmsy", "Yield Relative to MSY", "Yield", "Prop Year Closure Occurs", "Net Revenue for Herring", "Prop Year Net Revenue at Equilibrium",
#                                  "Interannual Variation in Yield", "Prop Year Tern Production > 1")
MSE_CustomTitle <- "75PercentCI"

MSE_FilePath <- "/Users/ahart2/Research/MSE_Graphics"
MSE_OperatingModelList <- c( "HiM_LowSteep_AssBias_RecWt", "HiM_LowSteep_NoAssBias_RecWt", 
                             "LoM_HiSteep_AssBias_RecWt", "LoM_HiSteep_NoAssBias_RecWt")
MSE_OperatingModelColors <- c("#0868ac", "#bd0026", "#a8ddb5", "#feb24c")
MSE_TranslatedOperatingModel <- c("B", "D", "F", "H")
MSE_OutputDirectory <- "HerringMSE_Final_Graphics"

ProduceWebPlots(OriginalDataFile = MSE_OriginalDataFile, 
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
                FilePath = MSE_FilePath,
                OutputDirectory = MSE_OutputDirectory,
                CustomTitle = MSE_CustomTitle)














