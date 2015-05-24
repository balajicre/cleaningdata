## This file runs the analysis for the cleaning data project to generate a tidy data set.
## It assumes the data set is in the same folder as this script.
## Step 1. Combines the training and test data.
## Step 2. Extract mean and standard deviation from the combined dataset
## Step 3. Generates the tidy data set.

##Step 1. This function reads the data from the given directory and combines the training
##and testing data.
combinetrainingAndTestData<-function(dirPath){
  
  ## read the data for activity labels from the text file
  tPath <- paste("./", dirPath, "/activity_labels.txt", sep="")
  activityLabels <- read.table(tPath)
  
  ## read the data for test and training subject labels from the text file
  tPath <- paste("./", dirPath, "/train/subject_train.txt", sep="")
  subjectTrainingLabels <- read.table(tPath)
  tPath <- paste("./", dirPath, "/test/subject_test.txt", sep="")
  subjectTestLabels <- read.table(tPath)
  
  ## read the data for test and training of y labels
  tPath <- paste("./", dirPath, "/train/y_train.txt", sep="")
  yTrain <- read.table(tPath)
  tPath <- paste("./", dirPath, "/test/y_test.txt", sep="")
  yTest <- read.table(tPath)
  
  ## merge data for y test and training activity labels
  mergedYTrainLabels <- merge(yTrain,activityLabels,by="V1")
  mergedYTestLabels <- merge(yTest,activityLabels,by="V1")
  
  
  
  ## read the data for training and test data sets
  tpath <- paste("./", dirPath, "/test/X_test.txt", sep="")
  xTestData <- read.table(tpath)
  tpath <- paste("./", dirPath, "/train/X_train.txt", sep="")
  xTrainData <- read.table(tpath)
  
  
  
  ## merge the test and training data and the respective labels together
  trainData <- cbind(subjectTrainingLabels,mergedYTrainLabels,xTrainData)
  testData <- cbind(subjectTestLabels,mergedYTestLabels,xTestData)
  
  ## Merge test and training data
  combinedData <- rbind(trainData,testData)
  
  return (combinedData)
}

##Step 2. This function calculates the mean and standard deviation for each measurement. It takes
##the combined training and test data as input along with the directory path containing the dataset.
getMeanAndStd <- function(mergedData, dirPath) {
  tpath <- paste("./", dirPath, "/features.txt", sep="")
  featuresData <- read.table(tpath)
  
  
  ## set the column headers for combined data with Subject, activity_id, activity and the second column
  ## of features data
  colnames(mergedData) <- c("Subject","Activity_Id","Activity",as.vector(featuresData[,2]))
  
  ## get the mean and std columnns indices using grep command
  meanDataPoints <- grep("mean()", colnames(mergedData), fixed=TRUE)
  stdDataPoints <- grep("std()", colnames(mergedData), fixed=TRUE)
  
  ## Combine mean and std
  meanStdDataPoints <- c(meanDataPoints, stdDataPoints)
   
  ## sort the data point indices
  meanStdDataPoints <- sort(meanStdDataPoints)
  
  ## get the data based on the indices from the sorted vectors.
  result <- mergedData[,c(1,2,3,meanStdDataPoints)]
  return (result)
}
## Creates the tidy data set on the current folder where the script is executed.
## Rearranges the data per activity and calculates the mean 
## Renames the column with appropriate labels
createTidyDataSet<-function(meanStdDataPoint) {
  
  require(reshape2)
  ## rearrange the data such that all the activity columns (mean and std) are collaseced 
  ## to single column and their measurement values in another column
  ## i.e 66 columns are mapped back to 2 columns resulting in a data set containing 5 columns 
  reArrangedData <- melt(meanStdDataPoint, id=c("Subject","Activity_Id","Activity"))
  
  ## create the the tidy data set for each activity and calculate the mean
  tidyData <- dcast(reArrangedData, formula = Subject + Activity_Id + Activity ~ variable, mean)
  
  ## rename the columns to something more descriptive
  columnNames <- colnames(tidyData)
  columnNames <- gsub("-mean()","Mean",columnNames,fixed=TRUE)
  columnNames <- gsub("-std()","Std",columnNames,fixed=TRUE)
  
  ## put back in the tidy column names
  colnames(tidyData) <- columnNames
  
  ## write the output into a file
  write.table(tidyData, file="tidyDataSet.txt", sep="\t", row.names=FALSE)
}
combinedDataPoints<-combinetrainingAndTestData("UCI HAR Dataset");
meanStdPoints<-getMeanAndStd(combinedDataPoints,"UCI HAR Dataset")
tidyData<-createTidyDataSet(meanStdPoints);
