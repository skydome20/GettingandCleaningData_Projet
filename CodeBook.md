#CodeBook#

This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.


##The data source##

- Original data: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


- Original description of the dataset: [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##The data set##
The dataset includes the following files:


- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

##The variables of dataset##


1. The `x_train.txt` and `x_test.txt` contains 561 variables.  
2. The `feature.txt` contains all colnames of 561 variables.  
3. The `y_train.txt` and `y_test.txt` contains activity labels.  
4. The `activity_labels.txt` contains activity names.


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
