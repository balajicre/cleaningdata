This document is the readme file for the cleaning data project.This document describes the scripts and the 
dataset present in the repository.

The problem is generating a tidy dataset from a given set of measurements present in various files. This is described
in UCI HAR Dataset folder.

The run_analysis.R script has 3 functions in it.

combinetrainingAndTestData: This function combines the training and test data present in the UCI HAR Dataset sub folders.

getMeanAndStd: This function computes the mean and standard deviation from the combined test and training data for various categories of measurements.

createTidyDataSet: This function generates the tidy data set and writes a new file tidyDataset.txt



