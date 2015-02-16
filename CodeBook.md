# Tidy Human Activity Recognition Using Smartphones Dataset

Original dataset can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

and described here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

For the run_analysis.R script, we did the following:

1. Merged the training and test datasets.
2. Each dataset is a combination of the Subject, X and Y features.
3. The columns are:
	+ Subject
	+ Activity
	+ Measurements of the accelerometer and gyroscope.
4. The activities are: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
5. We remove all features that are not measuring the means and standard deviation.
6. Rename the activity number to the activity names.
5. The CombinedMeansData.txt file contains the means of the features by subject and activity.

