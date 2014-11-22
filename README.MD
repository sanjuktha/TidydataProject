# Coursera Getting and Cleaning Data Project Submission

## Objective

The objective of the project was to create a tidy data set from the raw data collected as part of a study on Human Activity Recognition using Smartphones. 

## Details
The tidy data set created at the end of the project comprises of the mean of each variable grouped by activity and subject. 
A brief description of the raw data set and the subset of variables included for the project is provided in the Codebook.MD file.
The transformations to the raw data set have been scripted in R and are available in the run_analysis.R script. The set of transformations that have been applied to create the tidy data set have been listed in the Codebook.MD file.
The run_analysis.R script downloads the dataset into the R working directory and then uses the individual files to transform and arrive at the tidy data set.
The tidy data set obtained at the end of the execution is written onto the tidyset.txt file. This file uses a comma "," as the delimiter.

## References
The dataset used for the project has been sourced from the following study:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012 

