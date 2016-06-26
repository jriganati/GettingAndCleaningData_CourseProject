### Introduction
This repository contains the required Course Project submissions for the Coursera course *Getting and Cleaning Data*

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.
The goal is to work with a provided set of data to prepare a tidy data set that can be used for later analysis.

### Analyzed Data
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data used in this project represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

The data are located in this repository's *UCI HAR Dataset* directory.

The data were downloaded from here:
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained:
* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Analysis Script
The data were analyzed with R version 3.3.0 (2016-05-03).  
The R script created to perform the analysis is called *run_analysis.R*.  This file can be run in R as long as the *UCI HAR Dataset* directory and its files are contained in the working directory.

The final result of the analysis is a dataframe called *meanValues*, which was output to the *meanValues.txt* file.

See *CodeBook.md* for details about the *meanValues* dataframe.
