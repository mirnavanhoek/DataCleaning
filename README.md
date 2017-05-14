# DataCleaning

## The repository includes the following files:

* 'README.md': Explains how to produce a tidy dataset from the Samsung Dataset
* 'run\_analysis.R': The R script that can be used to produce the tidy sataset
* 'codebook': A file describing the variables in the datast


## The data files that are used:
* 'feature.txt': A file listing all the features
* 'activity\_labels.txt': A file that links the class labels with their activity name.
* 'train/X\_train.txt': A fixed width file conaining the measurements of the training set
* 'train/y\_train.txt': A file containing the training labels
* 'train/subject\_train.txt': A file identifying for each row in the training set the subject who performed the activity.
* 'test/X\_test.txt': A fixed width file conaining the measurements of the test set
* 'test/y\_test.txt': A file containing the test labels
* 'test/subject\_test.txt': A file identifying for each row in the test set the subject who performed the activity.
Note: the data files are not included in the repository, but can be downloaded: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## To create the tidy dataset as requested in the programming assignment of the "Getting and Cleaning Data" course:
1. Make sure the data files are in the working directory and the two subdirectories train and test.
2. start RStudio
3. type: source("run\_analysis.R")
4. type: tidyData <- tidy2()

In the working directory the file you will find the file: 'tidy\_data.txt' which contains the requested tidy dataset.

