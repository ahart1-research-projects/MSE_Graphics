# This script subsets the herring data

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



##### Create a matrix with focused subset for plotting #####

Make_OM_vs_CR_Matrix <- function(OperatingModels=NULL, ControlRules=NULL, Data=NULL, PerformanceMetric=NULL, ChooseYrs=NULL){
  # Args:
       # OperatingModels: Vector containing operating model names
       # ControlRules: Vector containing control rule names
       # Data: A matrix where each performance metric is in a column, must have a column with CRNames
       # PerformanceMetric: Column name for a particular performance metric
       # ChooseYrs: "BB" or "BB3yr", correspond to data source
  # Returns:
       # A table with information on chosen performance metric for each operating model and each control rule
  
  # Set up matrix
  Data_OM_vs_CR <- matrix(NA, length(OperatingModels), length(ControlRules))
  
  # Fill matrix with data corresponding to chosen PerformanceMetric
  for(i in 1: length(OperatingModels)){
    Data_OM_vs_CR[i,] <- Data[which(Data[,"OM"]==OperatingModelList[i]), PerformanceMetric]
  }
  rownames(Data_OM_vs_CR) <- OperatingModelList
  colnames(Data_OM_vs_CR) <- Data[which(Data[,"OM"]==OperatingModelList[1]), "CRName"]
  
  # Write data to file
  write.table(Data_OM_vs_CR, file=paste("Data_OM_vs_CR", ChooseYrs, PerformanceMetric, sep="_"))
}



Make_OM_vs_PerfMet_Matrix <- function(OperatingModels=NULL, ControlRule=NULL, Data=NULL, PerformanceMetrics=NULL, ChooseYrs=NULL){
  # Args:
       # OperatingModels: Vector containing operating model names
       # ControlRule: Name of control rule of interest
       # Data: A matrix where each performance metric is in a column, must have a column with CRNames
       # PerformanceMetrics: Vector of performance metric names
       # ChooseYrs: "BB" or "BB3yr", correspond to data source
  # Returns:
       # A table with information on chosen control rule for each operating model and each performance metric
  
  # Set up matrix
  Data_PerfMet_vs_OM <- matrix(NA, length(PerformanceMetrics), length(OperatingModels))
  
  # Fill matrix with data corresponding to chosen Control Rule
  for(metric in 1:length(PerformanceMetrics)){
    Data_PerfMet_vs_OM[metric, ] <- Data[which(Data[,"CRName"]== ControlRule),PerformanceMetrics[metric]]
  }
  
  rownames(Data_PerfMet_vs_OM) <- PerformanceMetrics
  colnames(Data_PerfMet_vs_OM) <- OperatingModels
  
  # Write data to file
  write.table(Data_PerfMet_vs_OM, file=paste("Data_PerfMet_vs_OM", ChooseYrs, ControlRule, sep="_"))
}


# ChooseYrs is still not being added to file name, I can't figure out well  
Make_CR_vs_PerfMet_Matrix <- function(OperatingModel=NULL, ControlRules=NULL, Data=NULL, PerformanceMetrics=NULL, ChooseYrs=NULL){
  # Args:
       # OperatingModel: Name of operating model of interest
       # ControlRules: Vector containing control rule names
       # Data: A matrix where each performance metric is in a column, must have a column with CRNames
       # PerformanceMetrics: Vector of performance metric names
       # ChooseYrs: "BB" or "BB3yr", correspond to data source
  # Returns:
       # A table with information on chosen operating model for each control rule and each performance metric
  
  # Set up matrix
  Data_PerfMet_vs_CR <- matrix(NA, length(PerformanceMetrics), length(ControlRules))
  
  # Fill matrix with data corresponding to chosen Control Rule
  for(metric in 1:length(PerformanceMetrics)){
    Data_PerfMet_vs_CR[metric, ] <- Data[which(Data[,"OM"]== OperatingModel),PerformanceMetrics[metric]]
  }
  
  rownames(Data_PerfMet_vs_CR) <- PerformanceMetrics
  colnames(Data_PerfMet_vs_CR) <- ControlRules
  
  # Write data to file
  write.table(Data_PerfMet_vs_CR, file=paste("Data_PerfMet_vs_CR", ChooseYrs, OperatingModel, sep="_"))
}


