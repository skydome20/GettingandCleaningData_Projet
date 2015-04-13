# Getting and Cleaning Data #

----------
The course project for "Getting and Cleaning Data" on Coursera.
 
## Course Project Instruction##

Here are the data for the project:
[
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

You should create one R script called run_analysis.R that does the following.


- 1.Merges the training and the test sets to create one data set.


- 2.Extracts only the measurements on the mean and standard deviation for each measurement.

- 3.Uses descriptive activity names to name the activities in the data set

- 4.Appropriately labels the data set with descriptive activity names.

- 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Cleaning up Steps##
1. download the dataset and read all dataset to R
2. use  `feature.txt` to rename colnames of `x_train.txt` and `x_test.txt` 
3. combine `x_train` with `y_train` as a new train dataset(**ntrain**). So is 'test' dataset.
4. use `rbind()` to merge **'ntest'** and **'ntrain'** as **'all'** , which fulfill requirement 1.
5. use `grep()` to extract columns with keywords('mean' and 'std'), which fulfill requirement 2.
6. merge **'all'** dataset with `activity_labels.txt` by the variable *"activityLabel"*, which fulfill requirement 3.
7. use `gsub()` to replace abbrevation words with descriptive words, which which fulfill requirement 4.
8. transform data type of **'all'** from *"data.frame"* to *"data.table"*. Then use `aggregate()` to summerize mean by grouping **'all'** according to given variables *'activity'* and *'subject'*, which which fulfill requirement 5.

##Requirement##
require `data.table` library 