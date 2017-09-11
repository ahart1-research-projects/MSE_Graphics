# This script subsets the herring data

##### First define the function which picks out the subset of data we are interested in #####
ExtractCRandOMInformation <- function(OriginalDataFile=NULL, ChooseYrs=NULL, CRNumbers=NULL, CRNames = NULL, TranslatedCRName=NULL, OperatingModelList=NULL){
  # This script extracts the 9 control rules from all available data based on CR and CRnum information 
  # and appends a column containing control rule names and operating model numbered (arbitrary but consistent)
  
  # Args:
       # OriginalDataFile: Matrix with a column for every performance metric, contains all data, RDS file type
       # ChooseYrs: String containing information for CR (BB or BB3yr options)
       # CRNumbers: Vector containing different numbers for control rules, must be same length and order as CRNames
       # CRNames: Vector containing strings of different control rules, must be same length and order as CRnumInfo
       # TranslatedCRName: Vector of full control rule names, must be same order and length as CRNames
       # OperatingModelList: Vector of operating model names corresponding to data
       
  # Returns: 
       # A matrix containing same columns as original data, only rows associated with 9 control rules of interest

  CRSubset_HerringMSEData <- NULL
  CRandOMSubset_HerringMSEData <- NULL
  
  HerringMSEData <- readRDS(OriginalDataFile)
  
  # Pick subset of data for chosen control rules
  for(num in 1:length(CRNumbers)){ 
    # Pick rows from HerringMSEData matrix where CR and CRnum match chosen combination (data for each control rule= number control rule x2 since BB and BB3yr data available)
    MatrixRows <- which(HerringMSEData[,which(colnames(HerringMSEData)=="CR")]==ChooseYrs & HerringMSEData[,which(colnames(HerringMSEData)=="CRnum")]==CRNumbers[num])
    # Repeat CRName and TranslatedCRName associated with CRnumVectorInfo[num]
    CRName <- rep(CRNames[num], length(MatrixRows)) 
    # print(CRName)
    TranslatedCRName <- rep(TranslatedCRName[num], length(MatrixRows))

    # Combine labels column with corresponding row in HerringMSEData
    LabeledCRData <- cbind(CRName, TranslatedCRName, HerringMSEData[MatrixRows,])
    # print(LabeledCRData)
    
    # Combine subset with results matrix
    CRSubset_HerringMSEData <- rbind(CRSubset_HerringMSEData, LabeledCRData)
     #print(CRSubset_HerringMSEData)
  }
  # Pick subset of chosen control rule data for chosen operating models
  for(num in 1:length(OperatingModelList)){
    # Pick rows from CRSubset_HerringMSEData which contain data for the chosen operating models
    MatrixRows <- which(CRSubset_HerringMSEData[,"OM"] == OperatingModelList[num])
    # Combine subset with full results matrix
    CRandOMSubset_HerringMSEData <- rbind(CRandOMSubset_HerringMSEData, CRSubset_HerringMSEData[MatrixRows,])
  }
  
  # These next few lines calculate PropSSBrel30_75SSBzero metric using PropSSBrel3SSBzero and PropSSBrel75SSBzero columns & 25% and 75% CI columns, these lines are very specific to this project
  PropSSBrel30_75SSBzero <- CRandOMSubset_HerringMSEData[ ,"PropSSBrel75SSBzero"] - CRandOMSubset_HerringMSEData[ ,"PropSSBrel3SSBzero"]
  # Add this data to the matrix
  CRandOMSubset_HerringMSEData <- cbind(CRandOMSubset_HerringMSEData, PropSSBrel30_75SSBzero) 
  # 25% CI
  PropSSBrel30_75SSBzero_25 <- CRandOMSubset_HerringMSEData[ ,"PropSSBrel75SSBzero_25"] - CRandOMSubset_HerringMSEData[ ,"PropSSBrel3SSBzero_25"]
  CRandOMSubset_HerringMSEData <- cbind(CRandOMSubset_HerringMSEData, PropSSBrel30_75SSBzero_25)
  # 75% CI
  PropSSBrel30_75SSBzero_75 <- CRandOMSubset_HerringMSEData[ ,"PropSSBrel75SSBzero_75"] - CRandOMSubset_HerringMSEData[ ,"PropSSBrel3SSBzero_75"]
  CRandOMSubset_HerringMSEData <- cbind(CRandOMSubset_HerringMSEData, PropSSBrel30_75SSBzero_75)
  
  # Calculate Prop SSB is > 30% of SSB zero (currently Prop SSB < 30% of SSB zero)
  PropSSBGreater30SSBzero <- 1 - CRandOMSubset_HerringMSEData[, "PropSSBrel3SSBzero"]
  CRandOMSubset_HerringMSEData <- cbind(CRandOMSubset_HerringMSEData, PropSSBGreater30SSBzero)
  
  # Calculate proportion simulations (out of 100) that net revenue at equilibrium
  NetRevEquilibrium <- CRandOMSubset_HerringMSEData[, "stationary"]/100
  # Add this revised proportion data to the matrix
  CRandOMSubset_HerringMSEData <- cbind(CRandOMSubset_HerringMSEData, NetRevEquilibrium)
  
  # print((CRandOMSubset_HerringMSEData))
  
  # Return results matrix
  return(CRandOMSubset_HerringMSEData)
}



##### Create a matrix with focused subset for plotting #####

Make_OM_vs_CR_Matrix <- function(OperatingModels=NULL, ControlRules=NULL, Data=NULL, PerformanceMetric=NULL, ChooseYrs=NULL, 
                                 TranslatedOperatingModel=NULL, TranslatedCRName=NULL, OutputDirectory=NULL, FilePath = NULL){
  # Args:
       # OperatingModels: Vector containing operating model names
       # ControlRules: Vector containing control rule names
       # Data: A matrix where each performance metric is in a column, must have a column with CRNames
       # PerformanceMetric: Column name for a particular performance metric
       # ChooseYrs: "BB" or "BB3yr", correspond to data source
       # TranslatedOperatingModel: Vector of full operating model names, must be same order and length as OperatingModelList
       # TranslatedCRName: Vector of full control rule names, must be same order and length as CRNames
       # OutputDirectory: string containing folder name to store all formatted data matrices and corresponding graphics
       # FilePath: File path to MSE_Graphics project
  
  # Returns:
       # A table with information on chosen performance metric for each operating model and each control rule
            # Rows are operating models
            # Columns are control rules
  
  # Read in data
  Data <- read.table(Data)
  # print(Data) # for some reason as.matrix turns everything into a string
  Data <- as.matrix(Data)

  # Set up matrix
  Data_OM_vs_CR <- matrix(NA, length(OperatingModels), length(ControlRules))
  
  # Fill matrix with data corresponding to chosen PerformanceMetric
  for(i in 1: length(OperatingModels)){
    Data_OM_vs_CR[i,] <- Data[which(Data[,"OM"]==OperatingModels[i]), PerformanceMetric]
  }
  rownames(Data_OM_vs_CR) <- TranslatedOperatingModel
  colnames(Data_OM_vs_CR) <- TranslatedCRName
  
  OutputFileName <- paste(FilePath, OutputDirectory, paste("Data_OM_vs_CR", ChooseYrs, PerformanceMetric, sep="_"), sep="/")
  # print(OutputFileName) # problem with FilePath
  # Write data to file
  # write.table(Data_OM_vs_CR, file=paste(FilePath, OutputDirectory, paste("Data_OM_vs_CR", ChooseYrs, PerformanceMetric, sep="_"), sep="/"))
  write.table(Data_OM_vs_CR, file=OutputFileName)
}



Make_OM_vs_PerfMet_Matrix <- function(OperatingModels=NULL, ControlRule=NULL, Data=NULL, PerformanceMetrics=NULL, ChooseYrs=NULL, 
                                      TranslatedOperatingModel=NULL, TranslatedPerfMetVector=NULL, OutputDirectory=NULL, FilePath=NULL){
  # Args:
       # OperatingModels: Vector containing operating model names
       # ControlRule: Name of control rule of interest
       # Data: A matrix where each performance metric is in a column, must have a column with CRNames
       # PerformanceMetrics: Vector of performance metric names
       # ChooseYrs: "BB" or "BB3yr", correspond to data source
       # TranslatedOperatingModel: Vector of full operating model names, must be same order and length as OperatingModelList
       # TranslatedPerfMetVector: Vector of full performance metric names, must be same order and length as PerformanceMetrics
       # OutputDirectory: string containing folder name to store all formatted data matrices and corresponding graphics
       # FilePath: File path to MSE_Graphics project
  
  # Returns:
       # A table with information on chosen control rule for each operating model and each performance metric
            # rows are performance metrics
            # columns are operating models
  
  # Read in data
  Data <- read.table(Data)
  Data <- as.matrix(Data)
  #print(Data[,"OM"])
  
  # Set up matrix
  Data_PerfMet_vs_OM <- matrix(NA, length(PerformanceMetrics), length(OperatingModels))
  
  #print (Data[which(Data[,"CRName"]== ControlRule),PerformanceMetrics[10]])
  
  # Fill matrix with data corresponding to chosen Control Rule
  for(metric in 1:length(PerformanceMetrics)){
    Data_PerfMet_vs_OM[metric, ] <- Data[which(Data[,"CRName"]== ControlRule),PerformanceMetrics[metric]]
  }
  
  rownames(Data_PerfMet_vs_OM) <- TranslatedPerfMetVector
  colnames(Data_PerfMet_vs_OM) <- TranslatedOperatingModel
  
  # Write data to file
  write.table(Data_PerfMet_vs_OM, file=paste(FilePath, OutputDirectory, paste("Data_PerfMet_vs_OM", ChooseYrs, ControlRule, sep="_"), sep="/"))
}


Make_CR_vs_PerfMet_Matrix <- function(OperatingModel=NULL, ControlRules=NULL, Data=NULL, PerformanceMetrics=NULL, ChooseYrs=NULL,
                                      TranslatedPerfMetVector=NULL, TranslatedCRName=NULL, OutputDirectory=NULL, FilePath=NULL){
  # Args:
       # OperatingModel: Name of operating model of interest
       # ControlRules: Vector containing control rule names
       # Data: A matrix where each performance metric is in a column, must have a column with CRNames
       # PerformanceMetrics: Vector of performance metric names
       # ChooseYrs: "BB" or "BB3yr", correspond to data source
       # TranslatedPerfMetVector: Vector of full performance metric names, must be same order and length as PerformanceMetrics
       # TranslatedCRName: Vector of full control rule names, must be same order and length as CRNames
       # OutputDirectory: string containing folder name to store all formatted data matrices and corresponding graphics
       # FilePath: File path to MSE_Graphics project
  
  # Returns:
       # A table with information on chosen operating model for each control rule and each performance metric
            # rows are performance metrics
            # columns are control rules
  
  # Read in data
  Data <- read.table(Data)
  Data <- as.matrix(Data)
  
  # Set up matrix
  Data_PerfMet_vs_CR <- matrix(NA, length(PerformanceMetrics), length(ControlRules))
  
  # Fill matrix with data corresponding to chosen Control Rule
  for(metric in 1:length(PerformanceMetrics)){
    Data_PerfMet_vs_CR[metric, ] <- Data[which(Data[,"OM"]== OperatingModel),PerformanceMetrics[metric]]
  }
  
  rownames(Data_PerfMet_vs_CR) <- TranslatedPerfMetVector 
  colnames(Data_PerfMet_vs_CR) <- TranslatedCRName
  
  # Write data to file
  write.table(Data_PerfMet_vs_CR, file=paste(FilePath, OutputDirectory, paste("Data_PerfMet_vs_CR", ChooseYrs, OperatingModel, sep="_"), sep="/"))
}

Make_WebDiagram_Matrix_1_OM <- function(OperatingModel=NULL, ControlRules=NULL, Data=NULL, PerformanceMetrics=NULL, ChooseYrs=NULL,
                                        TranslatedPerfMetVector=NULL, TranslatedCRName=NULL, OutputDirectory=NULL, FilePath=NULL){
  # Args:
       # OperatingModel: Name of operating model of interest
       # ControlRules: Vector containing control rule names
       # Data: A matrix where each performance metric is in a column, must have a column with CRNames
       # PerformanceMetrics: Vector of performance metric names
       # ChooseYrs: "BB" or "BB3yr", correspond to data source
       # TranslatedPerfMetVector: Vector of full performance metric names, must be same order and length as PerformanceMetrics
       # TranslatedCRName: Vector of full control rule names, must be same order and length as CRNames
       # OutputDirectory: string containing folder name to store all formatted data matrices and corresponding graphics
       # FilePath: File path to MSE_Graphics project
  
  # Returns:
       # A table with information on chosen operating model for each control rule and each performance metric
            # rows are operating models
            # columns are performance metrics, the first column contains operating model names
  
  # Read in data
  Data <- read.table(Data)
  Data <- as.matrix(Data)
  
  # Set up matrix
  Data_Web_PerfMet_vs_CR <- matrix(NA, length(ControlRules), length(PerformanceMetrics))

  # Fill matrix with data corresponding to chosen Control Rule
  for(metric in 1:length(PerformanceMetrics)){
    Data_Web_PerfMet_vs_CR[ ,metric] <- Data[which(Data[,"OM"]== OperatingModel), PerformanceMetrics[metric]]
  }
  
  colnames(Data_Web_PerfMet_vs_CR) <- TranslatedPerfMetVector
  rownames(Data_Web_PerfMet_vs_CR) <- TranslatedCRName
  
  # Write data to file
  write.table(Data_Web_PerfMet_vs_CR, file=paste(FilePath, OutputDirectory, paste("Data_Web_PerfMet_vs_CR", ChooseYrs, OperatingModel, sep="_"), sep="/"))
}

Make_WebDiagram_Matrix_1_CR <- function(OperatingModels=NULL, ControlRule=NULL, Data=NULL, PerformanceMetrics=NULL, ChooseYrs=NULL,
                                        TranslatedOperatingModel=NULL, TranslatedPerfMetVector=NULL, OutputDirectory=NULL, FilePath=NULL){
  # Args:
       # OperatingModels: Vector containing operating model names
       # ControlRule: Name of control rule of interest
       # Data: A matrix where each performance metric is in a column, must have a column with CRNames
       # PerformanceMetrics: Vector of performance metric names
       # ChooseYrs: "BB" or "BB3yr", correspond to data source
       # TranslatedOperatingModel: Vector of full operating model names, must be same order and length as OperatingModelList
       # TranslatedPerfMetVector: Vector of full performance metric names, must be same order and length as PerformanceMetrics
       # OutputDirectory: string containing folder name to store all formatted data matrices and corresponding graphics
       # FilePath: File path to MSE_Graphics project
  
  # Returns:
       # A table with information on chosen control rule for each operating model and each performance metric
            # rows are control rules
            # columns are performance metrics, the first column contains control rule names
  
  # Read in data
  Data <- read.table(Data)
  Data <- as.matrix(Data)
  
  # Set up matrix
  Data_Web_PerfMet_vs_OM <- matrix(NA, length(OperatingModels), length(PerformanceMetrics))
  
  # Fill matrix with data corresponding to chosen Control Rule
  for(metric in 1:length(PerformanceMetrics)){
    Data_Web_PerfMet_vs_OM[ ,metric] <- Data[which(Data[,"CRName"]== ControlRule),PerformanceMetrics[metric]]
  }
  
  colnames(Data_Web_PerfMet_vs_OM) <- TranslatedPerfMetVector
  rownames(Data_Web_PerfMet_vs_OM) <- TranslatedOperatingModel
  
  # Write data to file
  write.table(Data_Web_PerfMet_vs_OM, file=paste(FilePath, OutputDirectory, paste("Data_Web_PerfMet_vs_OM", ChooseYrs, ControlRule, sep="_"), sep="/"))
}

