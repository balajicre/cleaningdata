This is the code book that describes the variables, data and the transformations performed on the data to create a clean data set.

The data that is transformed to create the tidy data set is in the UCI HAR Dataset. There is a README.txt inside the folder that 
explains the different variables and measurement present in it.

run_analysis.R is the main script that performs the clean up and generates the tidy data set. The output is a text file called
tidyDataSet.txt.

combinetrainingAndTestData: This function combines the training and test data present in the UCI HAR Dataset sub folders. The input to the function
is the folder UCI HAR Dataset.
xTestData is a local variable in combinetrainingAndTestData that contains 541 columns of measurements in the test set.
xTrainData is a local variable in combinetrainingAndTestData that contains 541 columns of measurements in the training set.
yTrain is a local variable in combinetrainingAndTestData that contains all possible label data in the training set.
yTest is a local variable in combinetrainingAndTestData that contains all possible label data in the test set.
activityLabels is a local variable in combinetrainingAndTestData that contains different types of acitivity categories.
subjectTrainingLabels is a local variable in combinetrainingAndTestData that contains all subject data in the training set.
subjectTestLabels is a local variable in combinetrainingAndTestData that contains all subject data in the test set.
combinedData is the return variable that contains the mreged training and test data.

getMeanAndStd: This function computes the mean and standard deviation from the combined test and training data for various categories of measurements.
The input to the function is UCI HAR Datsset and the merged training and test data.
featuresData is a local variable in getMeanAndStd that contains the names of the 541 features.
meanDataPoints is a local variable in getMeanAndStd that contains the indices of the mean data points in the given input mergedData
stdDataPoints is a local variable in getMeanAndStd that contains the indices of the std dataa points in the given input mergedData.
results is the return variable in getMeanAndStd that contains only the mean and std data points in the given input that contains the training and test dataset.


createTidyDataSet: This function generates the tidy data set and writes a new file tidyDataset.txt. The input to the function is the mean and std
data points.
reArrangedData is a local variable in createTidyDataSet that contains the downselection of 66 observations on the given input.
tidyData is the return variable in createTidyDataSet that contains the mean of all the activities across all the variables.



The script contains 3 global variables:
1. combinedDataPoints which is the output from combinetrainingAndTestData
2. meanStdPoints which is the output from getMeanAndStd
3. tidyData which is the output from createTidyDataSet

The above variables are created in the following lines of code in run_analysis.R 101-103
combinedDataPoints<-combinetrainingAndTestData("UCI HAR Dataset");
meanStdPoints<-getMeanAndStd(combinedDataPoints,"UCI HAR Dataset")
tidyData<-createTidyDataSet(meanStdPoints);

combinedDataPoints is created by merging X_train.txt and X_test.txt. It has a total of 10299 measurements with 564 columns. 561 columns came from
features.txt and the remaining 3 columns were added which are subject, activity id and activities from activities.txt and y labels.

meanStdPoints is created by subsetting the data that contains the column with mean or std in its columnts. This resulted in data set
of dimension 10299 rows with 69 columns in it.

tidyData is the mean of the related activities across the different variables of the data.
