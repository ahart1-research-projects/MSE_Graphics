# MSE graphic code

######################## Functions which produces plots ###################################
ProducePlots <- function(OriginalDataFile=NULL, FilePath=NULL, OutputDirectory=NULL, ControlRuleNames=NULL, TranslatedControlRuleVector=NULL, ControlRuleColors=NULL, 
                         CRNumbers=NULL, PerformanceMetricVector=NULL, PerformanceMetricColors=PerformanceMetricColorsDefault,
                         TranslatedPerfMetVector=NULL, OperatingModelList=NULL, 
                         OperatingModelColors=OperatingModelColorsDefault, TranslatedOperatingModel=NULL){
  # Args:
       # OriginalDataFile: Matrix with a column for every performance metric, contains all data, RDS file type
       # FilePath: File path to MSE_Graphics project
       # OutputDirectory: string containing folder name to store all formatted data matrices and corresponding graphics
       # ControlRuleNames: Vector of control rule names corresponding to data
       # TranslatedControlRuleVector: Vector of full control rule names, must be same order and length as ControlRuleNames
            # Below are metrics and corresponding translated label that should be used, other metrics may be used but will not be scaled in any plot (mainly web diagrams)
               # "PropSSBrelSSBmsy"                 : "Prop Year Biomass < Bmsy"
               # "PropSSBrelhalfSSBmsy"             : "Probability of Overfished B < 0.5 Bmsy"
               # "MedPredAvWt_status"               : "Tuna Weight Status" 
               # "AvPropYrs_okBstatusgf"            : "Prop Year Good Dogfish Biomass" 
               # "PropFrelFmsy"                     : "Prop Year Overfishing Occurs F > Fmsy"
               # "YieldrelMSY"                      : "Yield Relative to MSY"
               # "Yield"                            : "Yield"
               # "PropClosure"                      : "Prop Year Closure Occurs"
               # "p50_NR"                           : "Net Revenue for Herring"
               # "Yvar"                             : "Interannual Variation in Yield"
               # "MedPropYrs_goodProd_Targplustern" : "Prop Year Tern Production > 1"
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
  source(paste(FilePath, "WebDiagramScript.R", sep="/"))
  
  # Create output directory
  dir.create(paste(FilePath, OutputDirectory, sep="/"))
  
  ################################################ Subset Data For Graphics ######################################################
  ##### Full Subset Data #####
  CR_BB_Data <- ExtractCRandOMInformation(OriginalDataFile=OriginalDataFile, ChooseYrs = "BB", CRNumbers = CRNumbers, 
                                     CRNames = ControlRuleNames, TranslatedCRName = TranslatedControlRuleVector, OperatingModelList = OperatingModelList)
  write.table(CR_BB_Data, file=paste(FilePath, OutputDirectory, "CR_BB_Data", sep="/"))
  CR_BB3yr_Data <- ExtractCRandOMInformation(OriginalDataFile=OriginalDataFile, ChooseYrs = "BB3yr", CRNumbers = CRNumbers, 
                                        CRNames = ControlRuleNames, TranslatedCRName = TranslatedControlRuleVector, OperatingModelList = OperatingModelList)
  write.table(CR_BB3yr_Data, file=paste(FilePath, OutputDirectory, "CR_BB3yr_Data", sep="/"))
  AllSubsettedHerringData <- rbind(CR_BB_Data, CR_BB3yr_Data)
  write.table(AllSubsettedHerringData, paste(FilePath, OutputDirectory, "AllSubsettedHerringData", sep="/"))
  
  ################################################ Produce Bargraphs ######################################################
  
  ########## Format Subsetted data for barplots ##########
  ##### Produce OM vs CR data files #####
  # Loop over performance metrics for BB data
  for(perfmet in PerformanceMetricVector){
    Make_OM_vs_CR_Matrix(OperatingModels=OperatingModelList, 
                         ControlRules = ControlRuleNames, 
                         Data = paste(FilePath, OutputDirectory, "CR_BB_Data", sep="/"), 
                         PerformanceMetric=perfmet, 
                         ChooseYrs="BB", 
                         TranslatedOperatingModel=TranslatedOperatingModel,
                         TranslatedCRName = TranslatedControlRuleVector,
                         OutputDirectory = OutputDirectory,
                         FilePath = FilePath)
  }
  # Loop over performance metrics for BB3yr data
  for(perfmet in PerformanceMetricVector){
    Make_OM_vs_CR_Matrix(OperatingModels=OperatingModelList, 
                         ControlRules = ControlRuleNames, 
                         Data = paste(FilePath, OutputDirectory, "CR_BB3yr_Data", sep="/"), 
                         PerformanceMetric=perfmet, 
                         ChooseYrs="BB3yr", 
                         TranslatedOperatingModel=TranslatedOperatingModel,
                         TranslatedCRName = TranslatedControlRuleVector,
                         OutputDirectory = OutputDirectory,
                         FilePath = FilePath)
  }
  
  ##### Make Operating Models vs Performance metric files #####
  # Loop over control rules for BB data
  for(i in 1:length(ControlRuleNames)){
    Make_OM_vs_PerfMet_Matrix(OperatingModels=OperatingModelList, 
                              ControlRule=ControlRuleNames[i], 
                              Data=paste(FilePath, OutputDirectory, "CR_BB_Data", sep="/"), 
                              PerformanceMetrics=PerformanceMetricVector, 
                              ChooseYrs = "BB", 
                              TranslatedOperatingModel=TranslatedOperatingModel, 
                              TranslatedPerfMetVector=TranslatedPerfMetVector,
                              OutputDirectory = OutputDirectory,
                              FilePath = FilePath)
  }
  # Loop over control rules for BB3yr data
  for(i in 1:length(ControlRuleNames)){
    Make_OM_vs_PerfMet_Matrix(OperatingModels=OperatingModelList, 
                              ControlRule=ControlRuleNames[i], 
                              Data=paste(FilePath, OutputDirectory, "CR_BB3yr_Data", sep="/"), 
                              PerformanceMetrics=PerformanceMetricVector, 
                              ChooseYrs = "BB3yr", 
                              TranslatedOperatingModel=TranslatedOperatingModel, 
                              TranslatedPerfMetVector=TranslatedPerfMetVector,
                              OutputDirectory = OutputDirectory,
                              FilePath = FilePath)
  }
  
  ###### Make Control Rule vs Performance metric files #####
  # Loop over control rules for BB data
  for(i in 1:length(OperatingModelList)){
    Make_CR_vs_PerfMet_Matrix(OperatingModel=OperatingModelList[i], 
                              ControlRules=ControlRuleNames, 
                              Data=paste(FilePath, OutputDirectory, "CR_BB_Data", sep="/"), 
                              PerformanceMetrics = PerformanceMetricVector, 
                              ChooseYrs = "BB",
                              TranslatedPerfMetVector=TranslatedPerfMetVector, 
                              TranslatedCRName=TranslatedControlRuleVector,
                              OutputDirectory = OutputDirectory, 
                              FilePath = FilePath)
  }
  # Loop over control rules for BB3yr data
  for(i in 1:length(OperatingModelList)){
    Make_CR_vs_PerfMet_Matrix(OperatingModel = OperatingModelList[i], ControlRules = ControlRuleNames, 
                              Data=paste(FilePath, OutputDirectory, "CR_BB3yr_Data", sep="/"), 
                              PerformanceMetrics = PerformanceMetricVector, 
                              ChooseYrs = "BB3yr",
                              TranslatedPerfMetVector=TranslatedPerfMetVector, 
                              TranslatedCRName=TranslatedControlRuleVector,
                              OutputDirectory = OutputDirectory,
                              FilePath = FilePath)
  }
  
  ##### Make Web diagram Performance metric vs. CR for 1 OM files
  # Loop over operating models for BB data
  for(i in 1:length(OperatingModelList)){
    Make_WebDiagram_Matrix_1_OM(OperatingModel=OperatingModelList[i], 
                                ControlRule=ControlRuleNames, 
                                Data=paste(FilePath, OutputDirectory, "CR_BB_Data", sep="/"), 
                                PerformanceMetrics=PerformanceMetricVector, 
                                ChooseYrs = "BB",
                                TranslatedPerfMetVector=TranslatedPerfMetVector, 
                                TranslatedCRName=TranslatedControlRuleVector,
                                OutputDirectory = OutputDirectory,
                                FilePath = FilePath)
  }
  # Loop over operating models for BB3yr data
  for(i in 1:length(OperatingModelList)){
    Make_WebDiagram_Matrix_1_OM(OperatingModel=OperatingModelList[i], 
                                ControlRule=ControlRuleNames, 
                                Data=paste(FilePath, OutputDirectory, "CR_BB3yr_Data", sep="/"), 
                                PerformanceMetrics=PerformanceMetricVector, 
                                ChooseYrs = "BB3yr",
                                TranslatedPerfMetVector=TranslatedPerfMetVector, 
                                TranslatedCRName=TranslatedControlRuleVector,
                                OutputDirectory = OutputDirectory,
                                FilePath = FilePath)
  }
  
  ##### Make Web diagram Performance metric vs. OM for 1 CR files
  # Loop over control rules for BB data
  for(i in 1: length(ControlRuleNames)){
    Make_WebDiagram_Matrix_1_CR(OperatingModels=OperatingModelList, 
                                ControlRule=ControlRuleNames[i], 
                                Data=paste(FilePath, OutputDirectory, "CR_BB_Data", sep="/"), 
                                PerformanceMetrics=PerformanceMetricVector, 
                                ChooseYrs = "BB",
                                TranslatedOperatingModel=TranslatedOperatingModel, 
                                TranslatedPerfMetVector=TranslatedPerfMetVector,
                                OutputDirectory = OutputDirectory,
                                FilePath = FilePath)
  }
  # Loop over control rules for BB3yr data
  for(i in 1: length(ControlRuleNames)){
    Make_WebDiagram_Matrix_1_CR(OperatingModels=OperatingModelList, 
                                ControlRule=ControlRuleNames[i], 
                                Data=paste(FilePath, OutputDirectory, "CR_BB3yr_Data", sep="/"), 
                                PerformanceMetrics=PerformanceMetricVector, 
                                ChooseYrs = "BB3yr",
                                TranslatedOperatingModel=TranslatedOperatingModel, 
                                TranslatedPerfMetVector=TranslatedPerfMetVector,
                                OutputDirectory = OutputDirectory,
                                FilePath = FilePath)
  }
  
  ########## Make Bargraphs ##########
  ##### Make plot with multiple performance metrics vs. multiple control rules for one operating model #####              THESE 2 WORK
  # Loop over operating models for BB data
  for(om in 1:length(OperatingModelList)){ # ????????? fix legend in png file
    OutputFileName <- paste(FilePath, OutputDirectory, paste("Graph_PerfMet_vs_CR_BB", OperatingModelList[om], ".png", sep="_"), sep="/")
    MultiplePerfMetricPlots(Data=paste(paste(FilePath, OutputDirectory, "Data_PerfMet_vs_CR_BB", sep="/"), OperatingModelList[om], sep="_"), 
                            xlab= "Control Rules",
                            BarNames=TranslatedControlRuleVector,
                            main= paste("Performance Metric Values for \n Operating Model", TranslatedOperatingModel[om], "BB", sep=" "),
                            PlotColor = PerformanceMetricColors,
                            PlotType="PerformanceMetric_ControlRule",
                            OutputFile = OutputFileName)
  }
  # Loop over operating models for BB3yr data
  for(om in 1: length(OperatingModelList)){
    OutputFileName <-  paste(FilePath, OutputDirectory, paste("Graph_PerfMet_vs_CR_BB3yr", OperatingModelList[om], ".png", sep="_"), sep="/")
    MultiplePerfMetricPlots(Data=paste(paste(FilePath, OutputDirectory, "Data_PerfMet_vs_CR_BB3yr", sep="/"), OperatingModelList[om], sep="_"), 
                            xlab= "Control Rules", 
                            BarNames=TranslatedControlRuleVector,
                            main= paste("Performance Metric Values for \n Operating Model", TranslatedOperatingModel[om], "BB3yr", sep=" "),
                            PlotColor = PerformanceMetricColors,
                            PlotType="PerformanceMetric_ControlRule", 
                            OutputFile = OutputFileName)
  }
  
  ##### Make plot with multiple performance metrics vs. multiple operating models for one control rule #####               THESE 2 WORK
  # Loop over control rules for BB data
  for(cr in 1: length(ControlRuleNames)){
    OutputFileName <- paste(FilePath, OutputDirectory, paste("Graph_PerfMet_vs_OM_BB", ControlRuleNames[cr], ".png", sep="_"), sep="/")
    MultiplePerfMetricPlots(Data=paste(paste(FilePath, OutputDirectory, "Data_PerfMet_vs_OM_BB", sep="/"), ControlRuleNames[cr], sep="_"),
                            xlab="Operating Models",
                            main=paste("Performance Metric Values for \n Control Rule", TranslatedControlRuleVector[cr], "BB", sep=" "),
                            PlotColor = PerformanceMetricColors,
                            PlotType = "PerformanceMetric_OperatingModel",
                            OutputFile = OutputFileName)
  }
  # Loop over control rules for BB3yr data
  for(cr in 1: length(ControlRuleNames)){
    OutputFileName <- paste(FilePath, OutputDirectory, paste("Graph_PerfMet_vs_OM_BB3yr", ControlRuleNames[cr], ".png", sep="_"), sep="/")
    MultiplePerfMetricPlots(Data=paste(paste(FilePath, OutputDirectory, "Data_PerfMet_vs_OM_BB3yr", sep="/"), ControlRuleNames[cr], sep="_"),
                            xlab="Operating Models",
                            main=paste("Performance Metric Values for \n Control Rule", TranslatedControlRuleVector[cr], "BB3yr", sep=" "),
                            PlotColor = PerformanceMetricColors,
                            PlotType = "PerformanceMetric_OperatingModel",
                            OutputFile = OutputFileName)
  }

  ##### Make multipanel plot with one performance metric vs. multiple control rules for one operating model #####             THESE 2 WORK
  # Loop over performance metrics for BB data
  for(pm in 1: length(PerformanceMetricVector)){
    OutputFileName <- paste(FilePath, OutputDirectory, paste("Graph_Multipanel_One_OM_vs_CR_BB", PerformanceMetricVector[pm], ".png", sep="_"), sep="/")
    SinglePerfMetricPlots(Data = paste(paste(FilePath, OutputDirectory, "Data_OM_vs_CR_BB", sep="/"), PerformanceMetricVector[pm], sep="_"), 
                          # ylab = TranslatedPerfMetVector[pm], 
                          main = paste(TranslatedPerfMetVector[pm], "\n for Operating Model"),  
                          PlotType = "MultiPanel_1_OperatingModel_MultipleControlRule", 
                          OperatingModelList = OperatingModelList, 
                          PlotColor = ControlRuleColors,
                          OutputFile = OutputFileName,
                          TranslatedControlRuleVector = TranslatedControlRuleVector,
                          TranslatedOperatingModel = TranslatedOperatingModel)
  }
  # Loop over performance metrics for BB3yr data
  for(pm in 1: length(PerformanceMetricVector)){
    OutputFileName <- paste(FilePath, OutputDirectory, paste("Graph_Multipanel_One_OM_vs_CR_BB3yr", PerformanceMetricVector[pm], ".png", sep="_"), sep="/")
    SinglePerfMetricPlots(Data = paste(paste(FilePath, OutputDirectory, "Data_OM_vs_CR_BB3yr", sep="/"), PerformanceMetricVector[pm], sep="_"), 
                          # ylab = TranslatedPerfMetVector[pm], 
                          main = paste(TranslatedPerfMetVector[pm], "\n for Operating Model"),
                          PlotType = "MultiPanel_1_OperatingModel_MultipleControlRule", 
                          OperatingModelList = OperatingModelList, 
                          PlotColor = ControlRuleColors, 
                          OutputFile = OutputFileName,
                          TranslatedControlRuleVector = TranslatedControlRuleVector,
                          TranslatedOperatingModel = TranslatedOperatingModel)
  }
  
  # # ?????????????? PlotColor is not working correctly
  # ##### Make plots with multiple control rules and multiple operating models for one performance metric #####               # THESE 2 WORK
  # # Loop over performance metrics for BB data
  # for(pm in 1: length(PerformanceMetricVector)){
  #   OutputFileName <- paste(FilePath, OutputDirectory, paste("Graph_MultipleOM_MultipleCR_BB", PerformanceMetricVector[pm], ".png", sep="_"), sep="/")
  #   SinglePerfMetricPlots(Data = paste(paste(FilePath, OutputDirectory, "Data_OM_vs_CR_BB", sep="/"), PerformanceMetricVector[pm], sep="_"),
  #                         # ylab = TranslatedPerfMetVector[pm],
  #                         main = paste(TranslatedPerfMetVector[pm], "for BB", sep=" "),
  #                         PlotType = "Y_MultipleOperatingModel_X_MultipleControlRule",
  #                         PlotColor = OperatingModelColors,
  #                         OutputFile = OutputFileName)
  # }
  # # Loop over performance metrics for BB3yr data
  # for(pm in 1: length(PerformanceMetricVector)){
  #   OutputFileName <- paste(FilePath, OutputDirectory, paste("Graph_MultipleOM_MultipleCR_BB3yr", PerformanceMetricVector[pm], ".png", sep="_"), sep="/")
  #   SinglePerfMetricPlots(Data = paste(paste(FilePath, OutputDirectory, "Data_OM_vs_CR_BB3yr", sep="/"), PerformanceMetricVector[pm], sep="_"),
  #                         # ylab = TranslatedPerfMetVector[pm],
  #                         main = paste(TranslatedPerfMetVector[pm], "for BB3yr", sep=" "),
  #                         PlotType = "Y_MultipleOperatingModel_X_MultipleControlRule",
  #                         PlotColor = OperatingModelColors,
  #                         OutputFile = OutputFileName)
  # }

  ########## Make Web/Radar Diagrams ##########
  source(paste(FilePath, "WebDiagramScript.R", sep="/"))

  ##### Make Web diagrams, each web = performance metrics for one operating model under same control rule #####             THESE 2 WORK
  # Loop over control rules for BB data
  for(cr in 1:length(ControlRuleNames)){
    WebDiagramPlots(Data = paste(paste(FilePath, OutputDirectory, "Data_Web_PerfMet_vs_OM_BB", sep="/"), ControlRuleNames[cr], sep="_" ),
                    PlotColor=OperatingModelColors,
                    LegendLabels = paste("Operating Model", TranslatedOperatingModel),
                    AxisLabels = TranslatedPerfMetVector,
                    OutputFileName = paste(FilePath, OutputDirectory, paste("Graph_Web_PerfMet_vs_OM_BB", ControlRuleNames[cr], ".png", sep="_"), sep="/"),
                    MainTitle = paste("Control Rule", TranslatedControlRuleVector[cr], sep=" "))
  }
  # Loop over control rules for BB3yr data
  for(cr in 1:length(ControlRuleNames)){
    WebDiagramPlots(Data = paste(paste(FilePath, OutputDirectory, "Data_Web_PerfMet_vs_OM_BB3yr", sep="/"), ControlRuleNames[cr], sep="_" ),
                    PlotColor=OperatingModelColors,
                    LegendLabels = paste("Operating Model", TranslatedOperatingModel),
                    AxisLabels = TranslatedPerfMetVector,
                    OutputFileName = paste(FilePath, OutputDirectory, paste("Graph_Web_PerfMet_vs_OM_BB3yr", ControlRuleNames[cr], ".png", sep="_"), sep="/"),
                    MainTitle = paste("Control Rule", TranslatedControlRuleVector[cr], sep=" "))
  }

  ##### Make web diagrams, each web= performance metrics for one control rule under the same operating model #####          THESE 2 WORK
  # Loop over operating models for BB data
  for(om in 1:length(OperatingModelList)){
    WebDiagramPlots(Data = paste(paste(FilePath, OutputDirectory, "Data_Web_PerfMet_vs_CR_BB", sep="/"), OperatingModelList[om], sep="_" ),
                    PlotColor=ControlRuleColors,
                    LegendLabels = paste("Control Rule", TranslatedControlRuleVector),
                    AxisLabels = TranslatedPerfMetVector,
                    OutputFileName = paste(FilePath, OutputDirectory, paste("Graph_Web_PerfMet_vs_CR_BB", OperatingModelList[om], ".png", sep="_"), sep="/"),
                    MainTitle = paste("Operating Model", TranslatedOperatingModel[om], sep=" "))
  }
  # Loop over operating models for BB3yr data
  for(om in 1:length(OperatingModelList)){
    WebDiagramPlots(Data = paste(paste(FilePath, OutputDirectory, "Data_Web_PerfMet_vs_CR_BB3yr", sep="/"), OperatingModelList[om], sep="_" ),
                    PlotColor=ControlRuleColors,
                    LegendLabels = paste("Control Rule", TranslatedControlRuleVector),
                    AxisLabels = TranslatedPerfMetVector,
                    OutputFileName = paste(FilePath, OutputDirectory, paste("Graph_Web_PerfMet_vs_CR_BB3yr", OperatingModelList[om], ".png", sep="_"), sep="/"),
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


################################################# Produce Graphs for MSE #######################################################
# Performance metrics to focus on for Herring MSE
# % MSY >= 100%, acceptable level as low as 85%
# PropSSBrelSSBmsy = Proportion Years Herring SSB < SSBmsy(Median)
# PropSSBrelhalfSSBmsy = Proportion years herring SSB < 0.5SSBmsy(Median)
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

##### First Draft of Graphics: 4 Performance metrics to narrow control rule options #####

MSE_OriginalDataFile <- "/Users/ahart2/Downloads/allres.rds"
MSE_ControlRuleNames <- c("StrawmanA", "StrawmanB", "Params upfront", "MeetCriteria1", "MeetCriteria2", "MeetCriteria3", "MeetCriteria4", "MeetCriteria5", "MeetCriteria6")
MSE_TranslatedControlRuleVector <- c(" 1"," 2"," 3"," 4A"," 4B"," 4C"," 4D"," 4E"," 4F") 
MSE_ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#a8ddb5", "#084081", "#238443" , "#2b8cbe", "#7bccc4")
MSE_CRNumbers <- c(4191, 12858, 5393, 4171, 4272, 4373, 5171, 5363, 7161)
MSE_PerformanceMetricVector <- c("YieldrelMSY", "Yvar", "PropSSBrelhalfSSBmsy", "PropClosure")
MSE_PerformanceMetricColors <- c("#084081", "#feb24c", "#4eb3d3", "#fc4e2a")
MSE_TranslatedPerfMetVector <- c("Yield Relative to MSY", "Interannual Variation in Yield", "Probability of Overfished", "Prop Year Closure Occurs")   
MSE_FilePath <- "/Users/ahart2/Research/MSE_Graphics"
MSE_OperatingModelList <- c("HiM_LowSteep_AssBias_OldWt", "HiM_LowSteep_AssBias_RecWt", "HiM_LowSteep_NoAssBias_OldWt", 
                            "HiM_LowSteep_NoAssBias_RecWt", "LoM_HiSteep_AssBias_OldWt", "LoM_HiSteep_AssBias_RecWt", 
                            "LoM_HiSteep_NoAssBias_OldWt", "LoM_HiSteep_NoAssBias_RecWt")
MSE_OperatingModelColors <- c("#084081", "#0868ac", "#800026", "#bd0026", "#4eb3d3", "#a8ddb5", "#fc4e2a", "#feb24c")
MSE_TranslatedOperatingModel <- c("A", "B", "C", "D", "E", "F", "G", "H")

# This formats the data and makes all associated plots for the 4 chosen performance metrics (used to narrow control rule options)
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
             FilePath = MSE_FilePath,
             OutputDirectory = "HerringMSE_Chosen4PerfMet")

##### Second Draft of Graphics: Original 4 performance metrics + a few examples #####

MSE_OriginalDataFile <- "/Users/ahart2/Downloads/allres.rds"
MSE_ControlRuleNames <- c("StrawmanA", "StrawmanB", "Params upfront", "MeetCriteria1", "MeetCriteria2", "MeetCriteria3", "MeetCriteria4", "MeetCriteria5", "MeetCriteria6")
MSE_TranslatedControlRuleVector <- c(" 1"," 2"," 3"," 4A"," 4B"," 4C"," 4D"," 4E"," 4F") 
MSE_ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#a8ddb5", "#084081", "#238443" , "#2b8cbe", "#7bccc4")
MSE_CRNumbers <- c(4191, 12858, 5393, 4171, 4272, 4373, 5171, 5363, 7161)
MSE_PerformanceMetricVector <- c("YieldrelMSY", "Yvar", "PropSSBrelhalfSSBmsy", "PropClosure", "p50_NR", "MedPredAvWt_status")
MSE_PerformanceMetricColors <- c("#084081", "#feb24c", "#4eb3d3", "#fc4e2a", "#a8ddb5", "#238443")
MSE_TranslatedPerfMetVector <- c("Yield Relative to MSY", "Interannual Variation in Yield", "Probability of Overfished", "Prop Year Closure Occurs", "Net Revenue for Herring", "Predator Avg Weight: Dogfish")
MSE_FilePath <- "/Users/ahart2/Research/MSE_Graphics"
MSE_OperatingModelList <- c("HiM_LowSteep_AssBias_OldWt", "HiM_LowSteep_AssBias_RecWt", "HiM_LowSteep_NoAssBias_OldWt", 
                            "HiM_LowSteep_NoAssBias_RecWt", "LoM_HiSteep_AssBias_OldWt", "LoM_HiSteep_AssBias_RecWt", 
                            "LoM_HiSteep_NoAssBias_OldWt", "LoM_HiSteep_NoAssBias_RecWt")
MSE_OperatingModelColors <- c("#084081", "#0868ac", "#800026", "#bd0026", "#4eb3d3", "#a8ddb5", "#fc4e2a", "#feb24c")
MSE_TranslatedOperatingModel <- c("A", "B", "C", "D", "E", "F", "G", "H")

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
             FilePath = MSE_FilePath,
             OutputDirectory = "HerringMSE_AdditionalPerfMet")

##### Third Draft of Graphics: Include all performance metrics for presentation, OM with recent growth, CR 1,2,3,4A, 4E #####

MSE_OriginalDataFile <- "/Users/ahart2/Downloads/allres.rds"
MSE_ControlRuleNames <- c("StrawmanA", "StrawmanB", "Params upfront", "MeetCriteria1", "MeetCriteria5")
MSE_TranslatedControlRuleVector <- c(" 1"," 2"," 3"," 4A", "4E") 
MSE_ControlRuleColors <- c("#b30000", "#feb24c", "#fc4e2a", "#4eb3d3", "#2b8cbe")
MSE_CRNumbers <- c(4191, 12858, 5393, 4171, 5363)
MSE_PerformanceMetricVector <- c("PropSSBrelSSBmsy", "PropSSBrelhalfSSBmsy", "MedPredAvWt_status", "AvPropYrs_okBstatusgf", 
                                 "PropFrelFmsy", "YieldrelMSY", "Yield", "PropClosure", "p50_NR", "Yvar", "MedPropYrs_goodProd_Targplustern")
MSE_PerformanceMetricColors <- c("#084081", "#feb24c", "#4eb3d3", "#fc4e2a", "#a8ddb5", "#238443", "#f768a1", "#bd0026", "#78c679", "#bcbddc", "#ffeda0")
MSE_TranslatedPerfMetVector <- c("Prop Year Biomass < Bmsy", "Probability of Overfished B < 0.5 Bmsy", "Tuna Weight Status", "Prop Year Good Dogfish Biomass",
                                 "Prop Year Overfishing Occurs F > Fmsy", "Yield Relative to MSY", "Yield", "Prop Year Closure Occurs", "Net Revenue for Herring",
                                 "Interannual Variation in Yield", "Prop Year Tern Production > 1")
                                 
MSE_FilePath <- "/Users/ahart2/Research/MSE_Graphics"
MSE_OperatingModelList <- c( "HiM_LowSteep_AssBias_RecWt", "HiM_LowSteep_NoAssBias_RecWt", 
                             "LoM_HiSteep_AssBias_RecWt", "LoM_HiSteep_NoAssBias_RecWt")
MSE_OperatingModelColors <- c("#0868ac", "#bd0026", "#a8ddb5", "#feb24c")
MSE_TranslatedOperatingModel <- c("B", "D", "F", "H")

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
             FilePath = MSE_FilePath,
             OutputDirectory = "HerringMSE_AllPerfMetToPresent")




