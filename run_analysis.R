library(readr)
library(dplyr)

#tidy1 <- function(){
#
#        ## Read in the feature data. 
#        ## This can be used to name the columns of the training and test datasets.
#        ## Note: there are 561 features.
#        feat <- read.csv("features.txt", sep=" ", header=FALSE, as.is = TRUE)
#        names(feat) <- c("featID", "featName")
#
#        ## Read in the training data using read_fwf from reader package
#        ## Note: there are 561 variables(columns) and there are 7352 observations.
#        train <- read_fwf("train/X_train.txt", fwf_widths(rep(16,561)))
#        ## Use vector feat$featName to give sensible names to each variable (column)
#        names(train) <- feat$featName
#        ## Read in the activity train data
#        ytrain <- read.csv("train/y_train.txt", header=FALSE)
#        ## Add the activity data to the train data
#        train <- mutate(train, activity = ytrain$activity)
#
#        ## Read in the test data using read_fwf from reader package
#        ## Note: there are 561 variables(columns) and there are 2947 observations.
#        test <- read_fwf("test/X_test.txt", fwf_widths(rep(16,561)))
#        ## Use vector feat$featName to give sensible names to each variable (column)
#        names(xtest) <- feat$featName
#        ## Read in the activity test data
#        ytest <- read.csv("test/y_test.txt", header=FALSE)
#        ## Add the activity data to the test data
#        test <- mutate(test, activity = ytest$activity)
#
#        ## merge the train and the test datasets
#        data <- rbind(train,test)
#
#	## Uses descriptive activity names to name the activities in the data set
#        data$activity <- factor(data$activity)
#        levels(data$activity) <- c("walking","walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")
#
#	## Extracts only the measurements on the mean and standard deviation for each measurement.
#        data1 <- data[ , grepl( "mean|sd" , names( data ) ) ]
#
#	## Write the tidy dataset to file
#        write.table(data, "tidy_data.txt", row.name=FALSE) 
#}

readX <- function(file, featNames, widths = rep(16,561)){
	## read in data from fixed width file 
	## widths is a vecor of wich with to use for each variable in the file
	## featureNames is used to set the variable names
        data <- read_fwf(file, fwf_widths(widths, featNames))
}

readY <- function(file, names){
	## read in data from csv type of file file 
	## names is used to set the variable names
        data <- read.csv(file, sep=" ", header=FALSE, as.is = TRUE, col.names=names)
}

tidy2 <- function(){

        ## Read in the feature data. 
        ## This can be used to name the columns of the training and test datasets.
        ## Note: there are 561 features.
#       feat <- read.csv("features.txt", sep=" ", header=FALSE, as.is = TRUE)
#        names(feat) <- c("featID", "featName")
        feat <- readY("features.txt", c("featId", "featName"))
        act <- readY("activity_labels.txt", c("actId", "actName"))


	#### 0) Read in training data components: 
	####   measurements, activity data and subject data.
	#### 4) Giving each variable a descritive name

	## Read training datasets
        ## Note: there are 561 variables and there are 7352 observations.
        xtrain <- readX("train/X_train.txt", feat$featNames)
        ytrain <- readY("train/y_train.txt", "activity")
        strain <- readY("train/subject_train.txt", "subject")


	## Read test datasets
        ## Note: there are 561 and there are 2947 observations.
        xtest <- readX("test/X_test.txt", feat$featNames)
        ytest <- readY("test/y_test.txt", "activity")
        stest <- readY("test/subject_test.txt", "subject")

        #### 1) merge the train and the test datasets 
	####    and combine the different parts
        data <- rbind(xtrain,xtest)
        ydata <- rbind(ytrain,ytest)
        sdata <- rbind(strain,stest)
        data <- mutate(data, activity = ydata$activity, subject = sdata$subject)

	#### 2) Extract the measurements on the mean and standard deviation 
	####    for each measurement.
        data1 <- data[ , grepl( "mean|sd" , names( data ) ) ]

        #### 3) Use descriptive names to name the activities in the data set
        data1$activity <- factor(data1$activity)
#        levels(data$activity) <- c("walking","walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")
        levels(data1$activity) <- act$actName

        data2 <- data1 %>% 
	        group_by(activity, subject) %>% 
		summarise_each(funs(mean))

	## Write the tidy dataset to file
        write.table(data2, "tidy_data.txt", row.name=FALSE) 

}
#----------------------------------------------------------------------------------

#        ## Note: there are 561 variables(columns) and there are 7352 observations.
#        train <- read_fwf("train/X_train.txt", fwf_widths(rep(16,561)))
#
#        ## Read in the activity train data
#        ytrain <- read.csv("train/y_train.txt", header=FALSE)
#	colnames(ytrain) <- "activity"
#        ## Add the activity data to the train data
#        train <- mutate(train, activity = ytrain$activity)
#
#        ## Read in the test data using read_fwf from reader package
#        ## Note: there are 561 variables(columns) and there are 2947 observations.
#        test <- read_fwf("test/X_test.txt", fwf_widths(rep(16,561)))
#
#        ## Read in the activity test data
#        ytest <- read.csv("test/y_test.txt", header=FALSE)
#        ## Add the activity data to the test data
#        test <- mutate(test, activity = ytest$activity)
#
#        ## 1) merge the train and the test datasets
#        data <- rbind(train,test)
#
#        ## 4) Use vector feat$featName to give sensible/descriptive names to each variable
#        names(data) <- c(feat$featName,'activity')
##
#	## 3) Uses descriptive activity names to name the activities in the data set
#        data$activity <- factor(data$activity)
#        levels(data$activity) <- c("walking","walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")
#
#	## 2) Extracts only the measurements on the mean and standard deviation for each measurement.
#        data1 <- data[ , grepl( "mean|sd" , names( data ) ) ]

	## From dataset creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#	data2 <- summarize(data1, xxxxxxxxx)

#	## Write the tidy dataset to file
#        write.table(data, "tidy_data.txt", row.name=FALSE) 

#}
