### STEP 1: Merges the training and the test sets to create one data set

# Reading the Training dataset
TrainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
TrainX <- read.table("./UCI HAR Dataset/train/X_train.txt")
TrainY <- read.table("./UCI HAR Dataset/train/y_train.txt")
TrainData <- cbind(TrainSubject, TrainY, TrainX)

# Reading the Test dataset
TestSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
TestX <- read.table("./UCI HAR Dataset/test/X_test.txt")
TestY <- read.table("./UCI HAR Dataset/test/y_test.txt")
TestData <- cbind(TestSubject, TestY, TestX)

# Combine both Training and Test datasets
CombinedData <- rbind(TrainData, TestData)

## Rename the column names.

# Get the feature names using for X_train.txt and X_test.txt.
# The feature names are in the second column.
FeatureNames <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[, 2]

# Rename the first column to be "Subject", followed by FeatureNames, and the last as the "Activity"
names(CombinedData) <- c("Subject", "Activity", FeatureNames)


### STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.

# Get the feature names with "mean" and "std"
MeanStdFeatureNames <- grep("(mean|std)\\(\\)", names(CombinedData))

# Keep the first column "Subject" and second column "Activity" and the columns with "mean" and "std".
CombinedData <- CombinedData[, c(1, 2, MeanStdFeatureNames)]

### STEP 3: Uses descriptive activity names to name the activities in the data set
ActivityNames <- read.table("UCI HAR Dataset/activity_labels.txt")
CombinedData$Activity <- factor(CombinedData$Activity, labels=ActivityNames[, 2])

### STEP 4: Appropriately labels the data set with descriptive variable names.

# Change t to Time, f to Frequency, mean() to Mean and std() to StdDev
# Remove extra dashes and BodyBody naming error from original feature names
names(CombinedData) <- gsub("^t", "Time", names(CombinedData))
names(CombinedData) <- gsub("^f", "Frequency", names(CombinedData))
names(CombinedData) <- gsub("-mean\\(\\)", "Mean", names(CombinedData))
names(CombinedData) <- gsub("-std\\(\\)", "StdDev", names(CombinedData))
names(CombinedData) <- gsub("-", "", names(CombinedData))
names(CombinedData) <- gsub("BodyBody", "Body", names(CombinedData))

### STEP 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

CombinedMeansData <- ddply(CombinedData, .(Subject, Activity), numcolwise(mean))
names(CombinedMeansData)[-c(1,2)] <- paste0("Mean_of_", names(CombinedMeansData)[-c(1,2)])

# Write to output file CombinedMeansData.txt
write.table(CombinedMeansData, "./UCI HAR Dataset/CombinedMeansData.txt", row.name=FALSE)

