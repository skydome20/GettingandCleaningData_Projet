
#### This is a course project of "3.Getting and Cleaning Data" course on coursera
#### coded by skydome20

#################################################################################################################
#  You should create one R script called run_analysis.R that does the following.                                #
#                                                                                                               #
#  1.Merges the training and the test sets to create one data set.                                              #
#  2.Extracts only the measurements on the mean and standard deviation for each measurement.                    #
#  3.Uses descriptive activity names to name the activities in the data set                                     #
#  4.Appropriately labels the data set with descriptive variable names.                                         #
#  5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable #
#    for each activity and each subject.                                                                        #
#################################################################################################################

### pre-preparing process ###

library(data.table)

setwd('./data/s3/UCI HAR Dataset') #please change dirctory path depend on your data location

# read data 
    xTrain   <- read.table('./train/X_train.txt')
    subTrain <- read.table('./train/subject_train.txt')
    yTrain   <- read.table('./train/y_train.txt')
    
    xTest    <- read.table('./test/X_test.txt' )
    subTest  <- read.table('./test/subject_test.txt')
    yTest    <- read.table('./test/y_test.txt')
    
    features   <- read.table('./features.txt' )
    actLabel   <- read.table('./activity_labels.txt')

# rename colnames of train and test data with feature.txt 
    colnames(xTest) <- features[,2]
    colnames(xTrain)<- features[,2]

# rename colnames of "activity_labels" dataset
    colnames(actLabel) <- c('activityLabel','activityNames');

# add "activityLabel" column to "xtrain and xtest" dataSet with "y_test and y_train" dataSet
    xTrain$activityLabel <- yTrain[,1]
    xTest$activityLabel  <- yTest[,1]

# add "subject" column to "xtrain and xtest" dataSet with "subTest and subTrain" dataSet
    xTrain$subject <- subTrain[,1]
    xTest$subject  <- subTest[,1]


### 1.Merges the training and the test sets to create one data set. ###                                         
    xData <- rbind(xTrain,xTest)

### 2.Extracts only the measurements on the mean and standard deviation for each measurement. ###
    meanIndex <- grep('[Mm]ean', colnames(xData))
    stdIndex  <- grep('[Ss]td' , colnames(xData))
    # create a combined vector to extract necessary columns   
    combIndex <- c(meanIndex,stdIndex,562,563)  #the last two values indicate "activityLabel" and "subject" colnames 

    xData <- xData[,combIndex] # measurments of only mean and std columns


### 3.Uses descriptive activity names to name the activities in the data set ###     
    xData <- merge(xData, actLabel, by='activityLabel',all.x=TRUE)


### 4.Appropriately labels the data set with descriptive variable names. ###      
    colNames <- colnames(xData) #it's easier to edit strings by using a vector  
    
    colNames <- gsub('^t', "time", colNames)
    colNames <- gsub('^f', "freq", colNames)
    
    colNames <- gsub('mean', "Mean", colNames)
    colNames <- gsub('std', "Std", colNames)   

    colNames <- gsub('[Gg]yro', "Gyroscope", colNames)
    colNames <- gsub('[Aa]cc', "Accelerator", colNames)
    colNames <- gsub("[Mm]ag", "Magnitude", colNames)
    colNames <- gsub("[Bb]ody[Bb]ody|[Bb]ody", "Body", colNames)
    
    colNames <- gsub('\\()', "", colNames)
    
    colnames(xData) <- colNames # rename back to original dataset

### 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ###
    xData  <- xData[,colnames(xData)!='activityLabel'] #remove activityLabel column from dataset
    xData  <- data.table(xData) 
    
    # grouping mean data by Activity and Subject elements 
    tidyData <- aggregate(xData, list(Subject=xData$subject,Activity=xData$activityNames),mean)
    # remove the last two columns (activityNames, subject)
    tidyData <- tidyData[,1:(length(tidyData)-2)] 
    # write to tidy.txt and finish this project!
    write.table(tidyData, file = "tidy.txt", row.names = FALSE)


