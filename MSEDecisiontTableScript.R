# MSE Decision Table Script



################################################ Produce Decision Tables ######################################################

# Make sure DecisionTableFunctions.R file is sourced

# GraphicLayout information for all 9 control rules and 8 operating models
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
GraphicWidthsALLOMs <- c(2,rep(1, GraphicColumnsAllOMs-1),0.25)

MSE_TranslatedOperatingModel <- c("A", "B", "C", "D", "E", "F", "G", "H")
MSE_TranslatedControlRuleVector <- c("1","2","3","4A","4B","4C","4D","4E","4F")
MSE_ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#a8ddb5", "#084081", "#238443" , "#2b8cbe", "#7bccc4")


# setwd to file with graphics
setwd("/Users/arhart/Research/MSE_Graphics/Icons")
IconList=c("HerringFishery", "HerringResource", "LobsterFishery", "TunaFishery", "WhaleSeabirdWatching")

# Extract data for barplots from Data_OM_vs_CR_BB3yr file
Data <- read.table("/Users/arhart/Research/MSE_Graphics/HerringMSE_Chosen4PerfMet/Data_OM_vs_CR_BB3yr_Yvar")
Data <- as.matrix(Data)

MakeGraphicDecisionTable(OutputDirectory= "/Users/arhart/Research/MSE_Graphics/HerringMSE_Chosen4PerfMet",
                         Title="Interannual Variation in Yield", 
                         IconList=c("HerringFishery", "HerringResource", "WhaleSeabirdSealResource", "GroundfishFishery"),
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
                         OutputFileName = "Example_DecisionTable_IAV_Yield")






# Format data for Decision tables using barplot function
MSE_OriginalDataFile <- "/Users/arhart/Downloads/allres.rds"
MSE_ControlRuleNames <- c("StrawmanA", "StrawmanB", "Params upfront", "MeetCriteria1", "MeetCriteria5")
MSE_TranslatedControlRuleVector <- c(" 1"," 2"," 3"," 4A", "4E") 
MSE_ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#2b8cbe")
MSE_CRNumbers <- c(4191, 12858, 5393, 4171, 5363)
MSE_PerformanceMetricVector <- c("PropSSBrelSSBmsy", "PropSSBrelhalfSSBmsy", "MedSSBrelSSBzero", 
                                 "PropFrelFmsy", "YieldrelMSY", "Yield", "Yvar",
                                 "PropClosure", "p50_NR",
                                 "MedPredAvWt_status", "AvPropYrs_okBstatusgf", "MedPropYrs_goodProd_Targplustern")
MSE_PerformanceMetricColors <- c("#084081", "#feb24c", "#4eb3d3", "#fc4e2a", "#a8ddb5", "#238443", "#f768a1", "#bd0026", "#78c679", "#bcbddc", "#ffeda0")
MSE_TranslatedPerfMetVector <- c("Prop Year Biomass < Bmsy", "Probability of Overfished B < 0.5 Bmsy", "SSB Relative to Unfished Biomass", 
                                 "Prop Year Overfishing Occurs F > Fmsy", "Yield Relative to MSY", "Yield", "Interannual Variation in Yield",
                                 "Prop Year Closure Occurs", "Net Revenue for Herring", 
                                 "Tuna Weight Status", "Prop Year Good \n Dogfish Biomass", "Prop Year Tern Production > 1")


MSE_FilePath <- "/Users/arhart/Research/MSE_Graphics"
MSE_OperatingModelList <- c( "HiM_LowSteep_AssBias_RecWt", "HiM_LowSteep_NoAssBias_RecWt", 
                             "LoM_HiSteep_AssBias_RecWt", "LoM_HiSteep_NoAssBias_RecWt")
MSE_OperatingModelColors <- c("#0868ac", "#bd0026", "#a8ddb5", "#feb24c")
MSE_TranslatedOperatingModel <- c("B", "D", "F", "H")

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
                OutputDirectory = "HerringMSE_AllPerfMetToPresent_DecisionTableData")

##### Make Decision Table for 1 operating model, 5 control rules, all 12 performance metrics #####
# Info to automate decision table production

# GraphicLayout information for 5 control rules and 4 operating models
GraphicLayout_HalfOMs <- c( 1,  1,  1,  1,  1,  1,  3,
                            2,  2,  2,  2,  2,  2,  3,
                            4,  5,  5,  5,  5,  5,  3,
                            4,  6,  6,  6,  6,  6,  3,
                            4,  7,  8,  9, 10, 11,  3,
                           12, 12, 12, 12, 12, 12,  3,
                           13, 14, 15, 16, 17, 18,  3,
                           19, 19, 19, 19, 19, 19,  3,
                           20, 21, 22, 23, 24, 25,  3,
                           26, 26, 26, 26, 26, 26,  3,
                           27, 28, 29, 30, 31, 32,  3,
                           33, 33, 33, 33, 33, 33,  3,
                           34, 35, 36, 37, 38, 39,  3,
                           40, 40, 40, 40, 40, 40,  3,
                           41, 42, 43, 44, 45, 46,  3,
                           47, 47, 47, 47, 47, 47,  3,
                           48, 49, 50, 51, 52, 53,  3,
                           54, 54, 54, 54, 54, 54,  3,
                           55, 56, 57, 58, 59, 60,  3,
                           61, 61, 61, 61, 61, 61,  3,
                           62, 63, 64, 65, 66, 67,  3,
                           68, 68, 68, 68, 68, 68,  3,
                           69, 70, 71, 72, 73, 74,  3,
                           75, 75, 75, 75, 75, 75,  3,
                           76, 77, 78, 79, 80, 81,  3,
                           82, 82, 82, 82, 82, 82,  3,
                           83, 84, 85, 86, 87, 88,  3,
                           89, 89, 89, 89, 89, 89,  3,
                           90, 91, 92, 93, 94, 95,  3,
                           96, 96, 96, 96, 96, 96,  3)

# GraphicLayout_HalfOMs <- c( 1,  1,  1,  1,  2,  3,  4,
#                             5,  5,  5,  5,  5,  5,  4,
#                             6,  7,  7,  7,  7,  7,  4,
#                             6,  8,  8,  8,  8,  8,  4,
#                             6,  9, 10, 11, 12, 13,  4,
#                            14, 14, 14, 14, 14, 14,  4,
#                            15, 16, 17, 18, 19, 20,  4,
#                            21, 21, 21, 21, 21, 21,  4,
#                            22, 23, 24, 25, 26, 27,  4,
#                            28, 28, 28, 28, 28, 28,  4,
#                            29, 30, 31, 32, 33, 34,  4,
#                            35, 35, 35, 35, 35, 35,  4,
#                            36, 37, 38, 39, 40, 41,  4,
#                            42, 42, 42, 42, 42, 42,  4,
#                            43, 44, 45, 46, 47, 48,  4,
#                            49, 49, 49, 49, 49, 49,  4,
#                            50, 51, 52, 53, 54, 55,  4,
#                            56, 56, 56, 56, 56, 56,  4,
#                            57, 58, 59, 60, 61, 62,  4,
#                            63, 63, 63, 63, 63, 63,  4,
#                            64, 65, 66, 67, 68, 69,  4,
#                            70, 70, 70, 70, 70, 70,  4,
#                            71, 72, 73, 74, 75, 76,  4,
#                            77, 77, 77, 77, 77, 77,  4,
#                            78, 79, 80, 81, 82, 83,  4,
#                            84, 84, 84, 84, 84, 84,  4,
#                            85, 86, 87, 88, 89, 90,  4,
#                            91, 91, 91, 91, 91, 91,  4,
#                            92, 93, 94, 95, 96, 97,  4,
#                            98, 98, 98, 98, 98, 98,  4)

GraphicRows_HalfOMs <- 30
GraphicColumns_HalfOMs <- 7
GraphicHeights_HalfOMs <- c(1,0.25,1,0.25,1,0.25,rep(c(2,0.25), GraphicRows_HalfOMs/2-3))
GraphicWidths_HalfOMs <- c(17,rep(5, GraphicColumns_HalfOMs-1),0.25)

# MSE_OriginalDataFile <- "/Users/arhart/Downloads/allres.rds"
# MSE_ControlRuleNames <- c("StrawmanA", "StrawmanB", "Params upfront", "MeetCriteria1", "MeetCriteria5")
MSE_TranslatedControlRuleVector <- c(" 1"," 2"," 3"," 4A", "4E") 
# MSE_ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#2b8cbe")
# MSE_CRNumbers <- c(4191, 12858, 5393, 4171, 5363)
# MSE_PerformanceMetricVector <- c("PropSSBrelSSBmsy", "PropSSBrelhalfSSBmsy", "MedSSBrelSSBzero", "MedPredAvWt_status", "AvPropYrs_okBstatusgf", 
#                                  "PropFrelFmsy", "YieldrelMSY", "Yield", "PropClosure", "p50_NR", "Yvar", "MedPropYrs_goodProd_Targplustern")
# MSE_PerformanceMetricColors <- c("#084081", "#feb24c", "#4eb3d3", "#fc4e2a", "#a8ddb5", "#238443", "#f768a1", "#bd0026", "#78c679", "#bcbddc", "#ffeda0")
MSE_TranslatedPerfMetVector <- c("Prop Year \n Biomass < Bmsy", "Probability of Overfished \n B < 0.5 Bmsy", "SSB Relative to \n Unfished Biomass", 
                                 "Prop Year Overfishing \n Occurs F > Fmsy", "Yield Relative to MSY", "Yield", "Interannual Variation \n in Yield",
                                 "Prop Year Closure \n Occurs", "Net Revenue for \n Herring", 
                                 "Tuna Weight Status", "Prop Year Good \n Dogfish Biomass", "Prop Year Tern \n Production > 1")


# MSE_OperatingModelColors <- c("#0868ac", "#bd0026", "#a8ddb5", "#feb24c")


#PerfMetNames <- c("PropSSBrelSSBmsy", "PropSSBrelhalfSSBmsy", "MedSSBrelSSBzero", "MedPredAvWt_status", "AvPropYrs_okBstatusgf", 
 #                 "PropFrelFmsy", "YieldrelMSY", "Yield", "PropClosure", "p50_NR", "Yvar", "MedPropYrs_goodProd_Targplustern")

ColorScale <- c("#ffffcc", "#d9f0a3", "#addd8e", "#78c679", "#31a354", "#006837")

# setwd to file with graphics
setwd("/Users/arhart/Research/MSE_Graphics/Icons")

# MSE_FilePath <- "/Users/arhart/Research/MSE_Graphics"  ?????? use in for loop)
MSE_OperatingModelList <- c("HiM_LowSteep_AssBias_RecWt", "HiM_LowSteep_NoAssBias_RecWt", 
                            "LoM_HiSteep_AssBias_RecWt", "LoM_HiSteep_NoAssBias_RecWt")
MSE_TranslatedOperatingModel <- c("B", "D", "F", "H")
 

for(i in 1:length(MSE_OperatingModelList)){
                     Data <- read.table(paste("/Users/arhart/Research/MSE_Graphics/HerringMSE_AllPerfMetToPresent_DecisionTableData/Data_PerfMet_vs_CR_BB3yr", MSE_OperatingModelList[i], sep="_"))
                     Data <- as.matrix(Data)
                     
                     MakeGraphicDecisionTable(OutputDirectory= "/Users/arhart/Research/MSE_Graphics/HerringMSE_AllPerfMetToPresent",
                                              Title=paste("Operating Model", MSE_TranslatedOperatingModel[i], sep=" "), 
                                              IconList=c(),
                                              RowCategoryName = "Performance \n Metrics", 
                                              ColumnCategoryName = "Control Rule Options", 
                                              RowNames = MSE_TranslatedPerfMetVector,
                                              ColumnNames = MSE_TranslatedControlRuleVector,
                                              GraphicLayout = GraphicLayout_HalfOMs, 
                                              GraphicNRow = GraphicRows_HalfOMs, 
                                              GraphicNCol = GraphicColumns_HalfOMs, 
                                              GraphicHeights = GraphicHeights_HalfOMs,
                                              GraphicWidths = GraphicWidths_HalfOMs,
                                              
                                              VerticalBarData = Data, 
                                              VerticalBarWidths = 0.4,
                                              VerticalBarColors = ColorScale,
                                              VerticalBarAxes = TRUE,
                                              OutputFileName = paste("DecisionTable_OM", MSE_TranslatedOperatingModel[i], sep=""))
}


############################ After 8/15/17 Revisions to Graphics ###########################################

##### Make Ranked decision tables for each performance metric ##### 
# GraphicLayout information for all 9 control rules and 8 operating models
# GraphicLayoutAllOMs <- c(  1,  1,  1,  1,  1,  2,  3,  4,  5,  6,   
#                            7,  7,  7,  7,  7,  7,  7,  7,  7,  7,  
#                            8,  9,  9,  9,  9,  9,  9,  9,  9,  9, 
#                            8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 
#                            8, 11, 12, 13, 14, 15, 16, 17, 18, 19,
#                           20, 20, 20, 20, 20, 20, 20, 20, 20, 20,
#                           21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 
#                           31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 
#                           32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 
#                           42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 
#                           43, 44, 45, 46, 47, 48, 49, 50, 51, 52,
#                           53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 
#                           54, 55, 56, 57, 58, 59, 60, 61, 62, 63,  
#                           64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 
#                           65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
#                           75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 
#                           76, 77, 78, 79, 80, 81, 82, 83, 84, 85,
#                           86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 
#                           87, 88, 89, 90, 91, 92, 93, 94, 95, 96,
#                           97, 97, 97, 97, 97, 97, 97, 97, 97, 97, 
#                           98, 99,100,101,102,103,104,105,106,107,
#                          108,108,108,108,108,108,108,108,108,108,  
#                          109,110,111,112,113,114,115,116,117,118,
#                          119,119,119,119,119,119,119,119,119,119)

GraphicLayoutAllOMs <- c(  1,  1,  1,  1,  1,  2,  3,  4,  5,  6,  7,  
                           8,  8,  8,  8,  8,  8,  8,  8,  8,  8,  7,  
                           9, 10, 10, 10, 10, 10, 10, 10, 10, 10,  7,
                           9, 11, 11, 11, 11, 11, 11, 11, 11, 11,  7,
                           9, 12, 13, 14, 15, 16, 17, 18, 19, 20,  7,
                          21, 21, 21, 21, 21, 21, 21, 21, 21, 21,  7,
                          22, 23, 24, 25, 26, 27, 28, 29, 30, 31,  7,
                          32, 32, 32, 32, 32, 32, 32, 32, 32, 32,  7,
                          33, 34, 35, 36, 37, 38, 39, 40, 41, 42,  7,
                          43, 43, 43, 43, 43, 43, 43, 43, 43, 43,  7,
                          44, 45, 46, 47, 48, 49, 50, 51, 52, 53,  7,
                          54, 54, 54, 54, 54, 54, 54, 54, 54, 54,  7, 
                          55, 56, 57, 58, 59, 60, 61, 62, 63, 64,  7,
                          65, 65, 65, 65, 65, 65, 65, 65, 65, 65,  7, 
                          66, 67, 68, 69, 70, 71, 72, 73, 74, 75,  7,
                          76, 76, 76, 76, 76, 76, 76, 76, 76, 76,  7,
                          77, 78, 79, 80, 81, 82, 83, 84, 85, 86,  7,
                          87, 87, 87, 87, 87, 87, 87, 87, 87, 87,  7,
                          88, 89, 90, 91, 92, 93, 94, 95, 96, 97,  7,
                          98, 98, 98, 98, 98, 98, 98, 98, 98, 98,  7, 
                          99,100,101,102,103,104,105,106,107,108,  7,
                         109,109,109,109,109,109,109,109,109,109,  7, 
                         110,111,112,113,114,115,116,117,118,119,  7,
                         120,120,120,120,120,120,120,120,120,120,  7)

GraphicRowsAllOMs <- 24
GraphicColumnsAllOMs <- 11
GraphicHeightsAllOMs <- c(1,0.25,1,0.25,1,0.25,rep(c(2,0.25), GraphicRowsAllOMs/2-3))
GraphicWidthsALLOMs <- c(2,rep(1, GraphicColumnsAllOMs-1),0.25)

MSE_TranslatedOperatingModel <- c("A", "B", "C", "D", "E", "F", "G", "H", "Summary")
MSE_TranslatedControlRuleVector <- c("1","2","3","4A","4B","4C","4D","4E","4F")
MSE_PerfMetColors <- c("#ffffe5","#f7fcb9","#d9f0a3","#addd8e","#78c679","#41ab5d","#238443","#006837","#004529")

# setwd to file with graphics
setwd("/Users/arhart/Research/MSE_Graphics/Icons")
IconList=c("HerringFishery", "HerringResource", "LobsterFishery", "TunaFishery", "WhaleSeabirdWatching", "WhaleSeabirdWatching")

# Extract data for barplots from Data_OM_vs_CR_BB3yr file
Data <- read.table("/Users/arhart/Research/MSE_Graphics/HerringMSE_AdditionalPerfMet/Data_OM_vs_CR_BB3yr_MedPredAvWt_status")
Data <- as.matrix(Data)

MakePerfMetGraphicDecisionTable(OutputDirectory= "/Users/arhart/Research/MSE_Graphics",
                         Title="Interannual Variation in Yield", 
                         IconList=c("HerringFishery", "HerringResource", "TunaFishery", "LobsterFishery", "WhaleSeabirdWatching"),
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
                         VerticalBarXLabel="Test", 
                         VerticalBarYLabel="YVar",
                         VerticalBarAxes = TRUE,
                         OutputFileName = "Example_RankedDecisionTable_TunaWeight")


