## -----------------------------------------
##  Getting and Cleaning Data - Assignment
## -----------------------------------------

## ---------------------------------------------------------------------------------------------------------------------------
## Dataset Source and Citation
## Obtained from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
## A Public Domain Dataset for Human Activity Recognition Using Smartphones. 
## 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. 
## Bruges, Belgium 24-26 April 2013.
## ---------------------------------------------------------------------------------------------------------------------------

## Download and Unzip Data

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "UCI_HAR_Dataset.zip"
DownloadedFilePath <- file.path(getwd(), fileName)

if(!file.exists(DownloadedFilePath)) {
   sourceDownload <- download.file(URL, destfile = fileName , method = "curl")
}

sourceData <- unzip(DownloadedFilePath)

## Initialise folder/subfolder and file names
Dir.Dataset <- 'UCI HAR Dataset'
Dir.Train <- 'train'
Dir.Test <- 'test'

File.Activity <- 'activity_labels.txt'
File.Features <- 'features.txt'
File.Train.Data <- 'X_train.txt'
File.Train.Labels <- 'y_train.txt'
File.Train.Subj <- 'subject_train.txt'
File.Test.Data <- 'X_test.txt'
File.Test.Labels <- 'y_test.txt'
File.Test.Subj <- 'subject_test.txt'

## Files In Main Directory
Table.Activity <- read.table(file.path(Dir.Dataset, File.Activity), col.names = c("Activity_ID", "Activity"))
Table.Features <- read.table(file.path(Dir.Dataset, File.Features))
Desc.Col <-  2

## Files In Train Directory to table
Table.Train.Dataset <- read.table(file.path(Dir.Dataset, Dir.Train, File.Train.Data))
Table.Train.Labels <- read.table(file.path(Dir.Dataset, Dir.Train, File.Train.Labels), col.names = "Activity")
Table.Train.Subj <- read.table(file.path(Dir.Dataset, Dir.Train, File.Train.Subj), col.names = "Subj_ID")

## Files In Test Directory to table
Table.Test.Dataset <- read.table(file.path(Dir.Dataset, Dir.Test, File.Test.Data))
Table.Test.Labels <- read.table(file.path(Dir.Dataset, Dir.Test, File.Test.Labels), col.names = "Activity")
Table.Test.Subj <- read.table(file.path(Dir.Dataset, Dir.Test, File.Test.Subj), col.names = "Subj_ID")

## Merge Dataset Rows 
Table.Complete.Dataset <- rbind(Table.Train.Dataset, Table.Test.Dataset)
Table.Complete.Labels <- rbind(Table.Train.Labels, Table.Test.Labels)
Table.Complete.Subj <- rbind(Table.Train.Subj, Table.Test.Subj)

## Extract only the measurements on the mean and standard deviation for each measurement
MeanAndStdCols <- grep("-mean\\()|-std\\()", Table.Features[, Desc.Col], ignore.case = TRUE)
Table.Complete.Dataset <- Table.Complete.Dataset[, MeanAndStdCols]

## Appropriately label the data set with descriptive variable names
Table.Features$V2 <- gsub("\\()", "", Table.Features$V2)
colnames(Table.Complete.Dataset) <- t(MeanAndStdCols)
colnames(Table.Complete.Dataset) <- t(Table.Features[colnames(Table.Complete.Dataset), Desc.Col])

## Merge Dataset Cols
Table.Complete.Dataset <- cbind(Table.Complete.Subj, Table.Complete.Labels, Table.Complete.Dataset)

## Use descriptive activity names to name the activities in the data set
Table.Complete.Dataset$Activity <- Table.Activity[Table.Complete.Dataset$Activity, Desc.Col]

## From above, create a second, independent tidy dataset with the average of each variable for
##  each activity and each subject
Table.Dataset.Average <- aggregate(.~Subj_ID+Activity, data = Table.Complete.Dataset, mean)
write.table(Table.Dataset.Average, "AverageTestTrainData.txt", row.names = FALSE, col.names = TRUE)
