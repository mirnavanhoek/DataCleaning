library(readr)
library(dplyr)

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
        feat <- readY("features.txt", c("featId", "featName"))
        act <- readY("activity_labels.txt", c("actId", "actName"))


        #### 0) Read in training data components: 
        ####   measurements, activity data and subject data.
        #### 4) Giving each variable a descritive name

        ## Read training datasets
        ## Note: there are 561 variables and there are 7352 observations.
        xtrain <- readX("train/X_train.txt", feat$featName)
        ytrain <- readY("train/y_train.txt", "activity")
        strain <- readY("train/subject_train.txt", "subject")


        ## Read test datasets
        ## Note: there are 561 and there are 2947 observations.
        xtest <- readX("test/X_test.txt", feat$featName)
        ytest <- readY("test/y_test.txt", "activity")
        stest <- readY("test/subject_test.txt", "subject")

        #### 1) merge the train and the test datasets 
        ####    and combine the different dataset parts (activity and subject data)
        data <- rbind(xtrain,xtest)
        ydata <- rbind(ytrain,ytest)
        sdata <- rbind(strain,stest)
        data <- mutate(data, activity = ydata$activity, subject = sdata$subject)

        #### 2) Extract the measurements on the mean and standard deviation 
        ####    for each measurement. And the activity and subject variables
        data1 <- data[ , grepl( "mean|sd|activity|subject" , names( data ) ) ]

        #### 3) Use descriptive names to name the activities in the data set
        data1$activity <- factor(data1$activity)
        levels(data1$activity) <- act$actName

        data2 <- data1 %>% 
                group_by(activity, subject) %>% 
                summarise_each(funs(mean))

        ## Write the tidy dataset to file
        write.table(data2, "tidy_data.txt", row.name=FALSE) 
        data2

}
