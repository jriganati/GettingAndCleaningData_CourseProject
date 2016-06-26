---
## Getting and Cleaning Data - Course Project ##
---
### Introduction ###

This repository contains the required Course Project submissions for the Coursera course Getting and Cleaning Data

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.
The goal is the creation of an R script to work with a provided set of data to prepare a tidy data set that can be used for later analysis.

The analysis was performed with R version 3.3.0 (2016-05-03) and requires the 'dplyr' package.

### Analysis results ###
The result of the R analysis is a dataframe called *meanValues*.  
Each observation identifies a test subject, an activity performed by the test subject, and 86 variables of data collected during the activity.  
A given subject will have a single observation for a given activity.  
Each of an observation's variables is the average of multiple values provided with the source datasets.

*meanValues* variables:
* activity: the activity name
* subject: the identity of the subject that performed the activity
* remaining variables: details of the variables can be found in the data source's features_info.txt file.

### Files associated with this analysis ###

* 'run_Analysis.R': The R script for completing the data analysis.
*	'CodeBook.md': This file
*	'README.md': Description file for the GitHub repository.

Source data files (see *About the source data* for details):
* 'UCI HAR Dataset/features_info.txt': Shows information about the variables used on the feature vector.
* 'UCI HAR Dataset/features.txt': List of all features.
* 'UCI HAR Dataset/activity_labels.txt': Links the class labels with their activity name.
* 'UCI HAR Dataset/train/X_train.txt': Training set.
* 'UCI HAR Dataset/train/y_train.txt': Training labels.
* 'UCI HAR Dataset/test/X_test.txt': Test set.
* 'UCI HAR Dataset/test/y_test.txt': Test labels.

### The analysis ###
The *run_Analysis.R* R script accomplishes the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script performs the following steps:
1. Loads the datasets' column names from the features.txt file into the *colnames* dataframe
2. Loads the test dataset from X_test.txt file into the *testset* dataframe, using information from *colnames* to label the columns.
3. Loads the train dataset from X_train.txt file into the *trainset* dataframe, using information from *colnames* to label the columns.
4. Creates the *testactivity*, *trainactivity*, *testsubject,* and *trainsubject* dataframes from their respective data source files.
5. Mutates *testset* to include columns from *testactivity* and *testsubject*.  This serves to identify each observations' activity and subject.
6. Mutates *trainset* to include columns from *trainactivity* and *trainsubject*.  This serves to identify each observations' activity and subject.
7. Merges *testset* and *trainset* into a new dataframe called *tbl_comb*.  The two dataframes have identical columns, so this was done with rbind.
8. Creates a new dataframe, called *tbl_extract*, by selecting from *tbl_comb* the following variables: activity; subject; any variable containing the text 'mean' or 'std'.
9. Loads descriptive activity labels from the activity_labels.txt file into a new dataframe called *actlabels*.
10. Mutates *tbl_extract* to make the activity variable a factor variable with labels from the *actlabels* dataframe.
11. Updates variable names in the *tbl_extract* dataframe to be more user friendly by removing non-alphanumeric characters.
12. Groups *tbl_extract* by the activity and subject variables.
13. Creates the final *meanValues* dataframe by summarizing *tbl_extract* with the mean function.

### About the source data ###
The data used in this analysis can be found in the repository's *UCI HAR Dataset* directory.
The data was obtained from:   
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The following details about the source data are taken from the data source's included *README.txt* file.
The source data was not modified in any way as part of this analysis.
```
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit� degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.
```
