# MSE graphic code

##### First define the function which picks out the subset of data we are interested in #####
ExtractCRInformation <- function(HerringMSEData=NULL, CRInfo=NULL, CRnumVectorInfo=NULL, CRNames = NULL){
  # This script extracts the 9 control rules from all available data based on CR and CRnum information 
  # and appends a column containing control rule names and operating model numbered (arbitrary but consistent)
  
  # Args:
  # HerringMSEData: File read in
  # CRInfo: String containing information for CR (BB or BB3yr options)
  # CRnumInfo: Vector containing different numbers for control rules
  # CRNames: Vector containing strings of different control rules, must be same length as CRnumInfo
  # Returns: 
  # A matrix containing same columns as original data, only rows associated with 9 control rules of interest
  CRSubset_HerringMSEData <- NULL
  
  for(num in 1:length(CRnumVectorInfo)){
    # Pick rows from HerringMSEData matrix where CR and CRnum match chosen combination
    MatrixRows <- which(HerringMSEData[,which(colnames(HerringMSEData)=="CR")]==CRInfo & HerringMSEData[,which(colnames(HerringMSEData)=="CRnum")]==CRnumVectorInfo[num])
    print(MatrixRows)
    CRName <- rep(CRNames[num], length(MatrixRows))
    print(CRName)
    
    LabeledCRData <- cbind(CRName, HerringMSEData[MatrixRows,])
    print(LabeledCRData)
    
    CRSubset_HerringMSEData <- rbind(CRSubset_HerringMSEData, LabeledCRData)
    print(CRSubset_HerringMSEData)
  }
  
  return(CRSubset_HerringMSEData)
}


##### Subset Data #####
HerringMSEData <- readRDS("/Users/ahart2/Documents/Research/Herring MSE/allres.rds")
ControlRuleNames <- c("StrawmanA", "StrawmanB", "Params upfront", "MeetCriteria1", "MeetCriteria2", "MeetCriteria3", "MeetCriteria4", "MeetCriteria5", "MeetCriteria6")
CRNumbers <- c(4191, 12858, 5393, 4171, 4272, 4373, 5171, 5363, 7161)

CR_BB_Data <- ExtractCRInformation(HerringMSEData = HerringMSEData, CRInfo = "BB", CRnumVectorInfo = CRNumbers, CRNames = ControlRuleNames)
CR_BB3yr_Data <- ExtractCRInformation(HerringMSEData = HerringMSEData, CRInfo = "BB3yr", CRnumVectorInfo = CRNumbers, CRNames = ControlRuleNames)
AllSubsettedHerringData <- rbind(CR_BB_Data, CR_BB3yr_Data)
#####

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




# TestData used for plot coding
TestBarDataVector <- c(1,2,3,4,5,6,7,8,9,10)
TestBarDataMatrix <- as.matrix(c(1,2,3,4,5,6,7,8,9,10,10,9,8,7,6,5,4,3,2,1),2,10)
TestStackedBar <-NULL
TestStackedBar$NumberPetTurkey <- c(1,2,3,0,0,1,0,1,0,0)
TestStackedBar$NumberOtherPets <- c(0,2,4,3,1,0,0,1,0,2)
#TestStackedBar$LivesOnFarm <- c("yes", "yes", "yes", "no", "no", "no", "yes", "yes", "no", "no")





