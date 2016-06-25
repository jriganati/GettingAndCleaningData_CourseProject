# run_analysis.R
# Getting and Cleaning Data Course Project
#
# The purpose of this script is to collect, work with, and clean a data set.  
# The source for the data used by this script:
#      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# This script does the following:
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names.
# 5) From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#
# The final result is a dataframe called meanValues

library(dplyr)

# identify the files we'll be working with
file_activityLabels <- "UCI HAR Dataset/activity_labels.txt"
file_columnNames <- "UCI HAR Dataset/features.txt"
file_testSet <- "UCI HAR Dataset/test/X_test.txt"
file_testActivity <- "UCI HAR Dataset/test/Y_test.txt"
file_testSubject <- "UCI HAR Dataset/test/subject_test.txt"
file_trainSet <- "UCI HAR Dataset/train/X_train.txt"
file_trainActivity <- "UCI HAR Dataset/train/Y_train.txt"
file_trainSubject <- "UCI HAR Dataset/train/subject_train.txt"

# Load the column names for the 561 variables in the data sets
colnames <- read.delim(file_columnNames,header=FALSE,sep="",col.names=c("colnumber","colname"),row.names=1,as.is=TRUE)

# Load the data sets, making sure to include the column names (Requirement 4)
testset <- read.delim(file_testSet, header=FALSE, sep="", strip.white=TRUE, col.names=colnames$colname)
trainset <- read.delim(file_trainSet, header=FALSE, sep="", strip.white=TRUE, col.names=colnames$colname)

# Load the activities and subjects
testactivity <- read.delim(file_testActivity,header=FALSE)
trainactivity <- read.delim(file_trainActivity,header=FALSE)
testsubject <- read.delim(file_testSubject,header=FALSE)
trainsubject <- read.delim(file_trainSubject,header=FALSE)

# Add the activity and subject columns to the data sets
tbl_test <- tbl_df(testset)
tbl_test <- tbl_test %>% mutate(activity=testactivity[,1]) %>% mutate(subject=testsubject[,1])

tbl_train <- tbl_df(trainset)
tbl_train <- tbl_train %>% mutate(activity=trainactivity[,1]) %>% mutate(subject=trainsubject[,1])

####
# Requirement 1 - 
# Merges the training and the test sets to create one data set
#
# Our two data sets have all of the same columns, so we can just rbind them together
tbl_comb <- rbind(tbl_train,tbl_test)

####
# Requirement 2 -
# Extracts only the measurements on the mean and and standard deviation for each measurement
#
# We want columns with "mean" or "std" in the name
# We'll also include our activity and subject columns
tbl_extract <- select(tbl_comb,activity,subject, contains("mean"),contains("std"))

####
# Requirement 3 - 
# Uses descriptive activity names to name the activities in the data set
#
# load the activity labels, then update the activity column in tbl_extract 
# to be factors labeled with the activity labels
actlabels <- read.table(file_activityLabels,
                        header=FALSE,
                        col.names = c("activitynumber","activitylabel"))

tbl_extract <- mutate(tbl_extract, activity = factor(tbl_extract$activity,
                                                     levels = actlabels[,1],
                                                     labels = actlabels[,2]))
####
# Requirement 4 -
# Appropriately labels the data set with descriptive variable names.
#
# We already included column names when we loaded the data sets.
# Now we'll make the variable (column) names more descriptive/friendlier by removing
# non-alphanumberic characters
names(tbl_extract) <- gsub("[^[:alnum:]]","",names(tbl_extract))

####
# Requirement 5 -
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
#
# Group the tbl_extract data by activity and subject, and then summarize 
# with the mean() function
tbl_extract <- group_by(tbl_extract,activity,subject) 

meanValues <- summarize_each(tbl_extract,funs(mean))


