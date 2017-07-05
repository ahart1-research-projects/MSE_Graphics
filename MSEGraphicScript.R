# MSE graphic code

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

################################################ Subset Data For Graphics ######################################################
##### Actually subset the data #####
source("/Users/ahart2/Research/MSE_Graphics/FormatHerringData.R")

##### Full Subset Data #####
HerringMSEData <- readRDS("/Users/ahart2/Downloads/allres.rds")
ControlRuleNames <- c("StrawmanA", "StrawmanB", "Params upfront", "MeetCriteria1", "MeetCriteria2", "MeetCriteria3", "MeetCriteria4", "MeetCriteria5", "MeetCriteria6")
CRNumbers <- c(4191, 12858, 5393, 4171, 4272, 4373, 5171, 5363, 7161)


CR_BB_Data <- ExtractCRInformation(HerringMSEData = HerringMSEData, CRInfo = "BB", CRnumVectorInfo = CRNumbers, CRNames = ControlRuleNames)
CR_BB3yr_Data <- ExtractCRInformation(HerringMSEData = HerringMSEData, CRInfo = "BB3yr", CRnumVectorInfo = CRNumbers, CRNames = ControlRuleNames)
AllSubsettedHerringData <- rbind(CR_BB_Data, CR_BB3yr_Data)
#########################

# Available summary info from AllSubsettedHerringData
OperatingModelList <- unique(AllSubsettedHerringData[,"OM"])
ControlRuleNames <- unique(AllSubsettedHerringData[,"CRName"])

# Performance metrics of interest
PerformanceMetricVector <- c("PropSSBrelSSBmsy", "PropSSBrelhalfSSBmsy", "PropSSBrel3SSBzero", "PropSSBrel75SSBzero", "Yvar", "YieldrelMSY",
                             "p50_IAVNR", "p50_IAVGR", "PropFrelFmsy", "PropClosure")
# Easily interpreted names of performance metrics, must be same order/length as PerformanceMetricVector, but should be more descriptive
TranslatedPerfMetVector <- c("Prop Years SSB < SSBmsy", "Prop Years SSB < 0.5 SSBmsy", "Prop Years SSB < 0.3 SSBf=0", "Prop Years SSB < 0.75 SSBf=0", "Interannual Variation in Yield",
                            "Yield Relative to MSY", "Interannual Variation Net Revenue", "Interannual Variation Gross Revenue", "Prop Years Overfishing Occurs", "Prop Year Closure Occurs")

################################################ Produce Bargraphs ######################################################

########## Format Subsetted data for barplots ##########
##### Produce OM vs CR data files #####
# setwd("/Users/arhart/Research/MSE_Graphics/Data")
# Loop over performance metrics for BB data
for(perfmet in PerformanceMetricVector){
  Make_OM_vs_CR_Matrix(OperatingModels=OperatingModelList, ControlRules = ControlRuleNames, Data = CR_BB_Data, PerformanceMetric=perfmet, ChooseYrs="BB")
}
# Loop over performance metrics for BB3yr data
for(perfmet in PerformanceMetricVector){
  Make_OM_vs_CR_Matrix(OperatingModels=OperatingModelList, ControlRules = ControlRuleNames, Data = CR_BB3yr_Data, PerformanceMetric=perfmet, ChooseYrs="BB3yr")
}

##### Make Operating Models vs Performance metric files #####
# Loop over control rules for BB data
for(i in 1:length(ControlRuleNames)){
  Make_OM_vs_PerfMet_Matrix(OperatingModels=OperatingModelList, ControlRule=ControlRuleNames[i], Data=CR_BB_Data, PerformanceMetrics=PerformanceMetricVector, ChooseYrs = "BB")
}
# Loop over control rules for BB3yr data
for(i in 1:length(ControlRuleNames)){
  Make_OM_vs_PerfMet_Matrix(OperatingModels=OperatingModelList, ControlRule=ControlRuleNames[i], Data=CR_BB3yr_Data, PerformanceMetrics=PerformanceMetricVector, ChooseYrs = "BB3yr")
}

###### Make Control Rule vs Performance metric files #####
# Loop over control rules for BB data
for(i in 1:length(OperatingModelList)){
  Make_CR_vs_PerfMet_Matrix(OperatingModel=OperatingModelList[i], ControlRules=ControlRuleNames, Data=CR_BB_Data, PerformanceMetrics = PerformanceMetricVector, ChooseYrs = "BB")
}
# Loop over control rules for BB3yr data
for(i in 1:length(OperatingModelList)){
  Make_CR_vs_PerfMet_Matrix(OperatingModel = OperatingModelList[i], ControlRules = ControlRuleNames, Data=CR_BB3yr_Data, PerformanceMetrics = PerformanceMetricVector, ChooseYrs = "BB3yr")
}


########## Make Bargraphs ##########
##### Make plot with multiple performance metrics vs. multiple control rules for one operating model #####
# Loop over operating models for BB data
for(om in 1:length(OperatingModelList)){ # ????????? fix legend in png file
  png(filename = paste("Graph_PerfMet_vs_CR_BB", OperatingModelList[om], ".png", sep="_"))
  MultiplePerfMetricPlots(Data=paste("/Users/ahart2/Research/MSE_Graphics/Data_PerfMet_vs_CR_BB", OperatingModelList[om], sep="_"), 
                          xlab= "Control Rules", 
                          main= paste("Performance Metric Values for", OperatingModelList[om], "Operating Model BB", sep=" "),
                          PlotColor = c("blue","green","yellow","orange","light blue","dark green","pink","red","brown","purple"),
                          PlotType="PerformanceMetric_ControlRule")
  dev.off()
}
# Loop over operating models for BB3yr data
for(om in 1: length(OperatingModelList)){
  png(filename = paste("Graph_PerfMet_vs_CR_BB3yr", OperatingModelList[om], ".png", sep="_"))
  MultiplePerfMetricPlots(Data=paste("/Users/ahart2/Research/MSE_Graphics/Data_PerfMet_vs_CR_BB3yr", OperatingModelList[om], sep="_"), 
                          xlab= "Control Rules", 
                          main= paste("Performance Metric Values for", OperatingModelList[om], "Operating Model BB3yr", sep=" "),
                          PlotColor = c("blue","green","yellow","orange","light blue","dark green","pink","red","brown","purple"),
                          PlotType="PerformanceMetric_ControlRule")
  dev.off()
}

##### Make plot with multiple performance metrics vs. multiple operating models for one control rule #####
# Loop over control rules for BB data
for(cr in 1: length(ControlRuleNames)){
  png(filename = paste("Graph_PerfMet_vs_OM_BB", ControlRuleNames[cr], ".png", sep="_"))
  MultiplePerfMetricPlots(Data=paste("/Users/ahart2/Research/MSE_Graphics/Data_PerfMet_vs_OM_BB", ControlRuleNames[cr], sep="_"),
                          xlab="Operating Models",
                          main=paste("Performance Metric Values for", ControlRuleNames[cr], "Control Rule BB", sep=" "),
                          PlotColor = c("blue","green","yellow","orange","light blue","dark green","pink", "red", "brown","purple"),
                          PlotType = "PerformanceMetric_OperatingModel")
  dev.off()
}
# Loop over control rules for BB3yr data
for(cr in 1: length(ControlRuleNames)){
  png(filename = paste("Graph_PerfMet_vs_OM_BB3yr", ControlRuleNames[cr], ".png", sep="_"))
  MultiplePerfMetricPlots(Data=paste("/Users/ahart2/Research/MSE_Graphics/Data_PerfMet_vs_OM_BB3yr", ControlRuleNames[cr], sep="_"),
                          xlab="Operating Models",
                          main=paste("Performance Metric Values for", ControlRuleNames[cr], "Control Rule BB3yr", sep=" "),
                          PlotColor = c("blue","green","yellow","orange","light blue","dark green","pink", "red", "brown","purple"),
                          PlotType = "PerformanceMetric_OperatingModel")
  dev.off()
}

##### Make multipanel plot with one performance metric vs. multiple control rules for one operating model #####
# Loop over performance metrics for BB data
for(pm in 1: length(PerformanceMetricVector)){
  png(filename=paste("Graph_Multipanel_One_OM_vs_CR_BB", PerformanceMetricVector[pm], ".png", sep="_"))
  SinglePerfMetricPlots(Data = paste("/Users/ahart2/Research/MSE_Graphics/Data_OM_vs_CR_BB", PerformanceMetricVector[pm], sep="_"), # ???????? I don't think data is being referenced correctly
                        ylab = TranslatedPerfMetVector[pm], 
                        main = TranslatedPerfMetVector[pm],
                        PlotType = "Multipanel_1_OperatingModel_MultipleConrolRule", 
                        OperatingModelVector = OperatingModelList, 
                        PlotColor = c("dark blue", "light green","light blue", "dark green", "red", "orange","pink", "purple", "yellow"))
  dev.off()
}
# Loop over performance metrics for BB3yr data
for(pm in 1: length(PerformanceMetricVector)){
  png(filename=paste("Graph_Multipanel_One_OM_vs_CR_BB3yr", PerformanceMetricVector[pm], ".png", sep="_"))
  SinglePerfMetricPlots(Data = paste("/Users/ahart2/Research/MSE_Graphics/Data_OM_vs_CR_BB3yr", PerformanceMetricVector[pm], sep="_"), # ???????? I don't think data is being referenced correctly
                        ylab = TranslatedPerfMetVector[pm], 
                        main = TranslatedPerfMetVector[pm],
                        PlotType = "Multipanel_1_OperatingModel_MultipleConrolRule", 
                        OperatingModelVector = OperatingModelList, 
                        PlotColor = c("dark blue", "light green","light blue", "dark green", "red", "orange","pink", "purple", "yellow"))
  dev.off()
}


################################################ Produce Decision Tables ######################################################

##### Set up info for Decision Table Function #####
# RowNames
CRList <- c("CR1", "CR2", "CR3", "CR4", "CR5", "CR6", "CR7", "CR8", "CR9")

# GraphicLayout information for all 9 control rules and 8 operating models                                                                                                                                                      
GraphicLayoutAllOMs <- c(  1,  1,  1,  1,  2,  3,  4,  5,  6,  7,
                           8,  8,  8,  8,  8,  8,  8,  8,  8,  8,
                           9, 10, 10, 10, 10, 10, 10, 10, 10, 10,
                           9, 11, 11, 11, 11, 11, 11, 11, 11, 11,
                           9, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                           21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
                           22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
                           32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
                           33, 34, 35, 36, 37, 38, 39, 40, 41, 42,
                           43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
                           44, 45, 46, 47, 48, 49, 50, 51, 52, 53,
                           54, 54, 54, 54, 54, 54, 54, 54, 54, 54,
                           55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
                           65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
                           66, 67, 68, 69, 70, 71, 72, 73, 74, 75,
                           76, 76, 76, 76, 76, 76, 76, 76, 76, 76,
                           77, 78, 79, 80, 81, 82, 83, 84, 85, 86,
                           87, 87, 87, 87, 87, 87, 87, 87, 87, 87,
                           88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
                           98, 98, 98, 98, 98, 98, 98, 98, 98, 98,
                           99,100,101,102,103,104,105,106,107,108,
                           109,109,109,109,109,109,109,109,109,109)
GraphicRowsAllOMs <- 22
GraphicColumnsAllOMs <- 10
GraphicHeightsAllOms <- c()




# TestData used for plot coding
TestBarDataVector <- c(1,2,3,4,5,6,7,8,9,10)
TestBarDataMultiple <- list(c(1,2,3),5,5,5,5,5,5,5)
TestBarDataMatrix <- as.matrix(c(1,2,3,4,5,6,7,8,9,10,10,9,8,7,6,5,4,3,2,1),2,10)
TestStackedBar <-NULL
TestStackedBar$NumberPetTurkey <- c(1,2,3,0,0,1,0,1,0,0)
TestStackedBar$NumberOtherPets <- c(0,2,4,3,1,0,0,1,0,2)
TestStackedBarData <- list(TestStackedBar, TestStackedBar, TestStackedBar, TestStackedBar,
                        TestStackedBar, TestStackedBar, TestStackedBar, TestStackedBar,
                        TestStackedBar, TestStackedBar)
#TestStackedBar$LivesOnFarm <- c("yes", "yes", "yes", "no", "no", "no", "yes", "yes", "no", "no")

# setwd to file with graphics
setwd("/Users/arhart/Research/MSE_Graphics/Icons")

# TryMaking Table
MakeGraphicDecisionTable(Title="PerformanceMetric", IconList=c("HerringFishery", "HerringResource", "LobsterFishery", "TunaFishery", "WhaleSeabirdWatching"),
                         RowCategoryName = "Operating Models", "Control Rule Options", 
                         RowNames = c("OM1", "OM2", "OM3", "OM4", "OM5","OM6","OM7","OM8"),
                         ColumnNames = c("CR1", "CR2","CR3","CR4","CR5","CR6","CR7","CR8","CR9"),
                         GraphicLayout = GraphicLayoutAllOMs, GraphicNRow = GraphicRowsAllOMs, 
                         GraphicNCol = GraphicColumnsAllOMs, PlotOrder = c("VerticalBarplot","VerticalStackedBarplot","HorizontalBarplot","HorizontalStackedBarplot","Pictogram",0,0,0,0), 
                         VerticalBarData = TestBarDataMultiple, VerticalBarWidths = c(1,2,3,4,5,6,7,8,9,10),
                         VerticalBarColors=c("blue","red"), VerticalBarXLabel="Xlabel", VerticalBarYLabel="YLabel",
                         VerticalBarAxes = TRUE,
                         
                         VerticalStackedBarData = TestStackedBarData, VerticalStackedBarWidths = c(1,2,3,4,5,6,7,8,9,10),
                         VerticalStackedBarColors= "orange", VerticalStackedBarXLabel="Xlabel",
                         VerticalStackedBarYLabel="Ylabel",VerticalStackedBarAxes=TRUE,
                         
                         HorizontalBarData = TestBarDataMultiple, HorizontalBarWidths = c(1,2,3,4,5,6,7,8,9,10),
                         HorizontalBarColors="green", HorizontalBarXLabel="Xlabel", HorizontalBarYLabel="YLabel",
                         HorizontalBarAxes = TRUE,
                         
                         HorizontalStackedBarData = TestStackedBarData, HorizontalStackedBarWidths = c(1,2,3,4,5,6,7,8,9,10),
                         HorizontalStackedBarColors= "pink", HorizontalStackedBarXLabel="Xlabel",
                         HorizontalStackedBarYLabel="Ylabel",HorizontalStackedBarAxes=TRUE,
                         
                         PictogramImage="HerringResource.png", PictogramData=c(10000,15000,20000,25000,30000,35000,40000,450000),
                         PictogramDataScale=10000, PictogramColumns=4)
  # ????????? control rule names are not plotting
   # ????????? plot with a bit more space between squares
       
                
