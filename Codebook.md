Script Name: run_analysis.R

# Obtain and Clean Data and create a subset of the Average values

## Description

This script downloads and unzips A Public Domain Dataset for Human Activity Recognition Using Smartphones which can be downloaded from [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Dataset Information
The dataset was obtained by a group of 30 volunteer participants wearing a smartphone (Samsung Galaxy SII) on the waist. Each participant performed the following six activities: Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing and Laying. 
The Dataset contains both test data and training data. The participant split was 70% of the participants were used to obtain training data and 30% for the test data.

## Steps to gather the data

#### 1. Merge the training and test sets to create one data set.

Merge the Training and Test Sets where:
   X_train.txt Contains the collected data for training participants
   y_train.txt Contains the activity labels for the training participants (eg: Walking, Laying...)
   subject_train.txt Contains the training participant IDs
   
   X_test.txt Contains the collected data for test participants
   y_test.txt Contains the activity labels for the test participants (eg: Walking, Laying...)
   subject_test.txt Contains the test participant IDs
    
Training Data are found in the 'train' subfolder and test data is found in the 'test' subfolder. 
    
    
#### 2. Extracts only the measurements on the mean and standard deviation for each    measurement.

From the merged data, obtain only the data which contains the mean and standard deviation values for each measurement. The columns names which identifies which fields are mean and standard deviation is found in the following file:
   features.txt
      
      
#### 3. Uses descriptive activity names to name the activities in the data set

As the merged data contains only the activity id and not the activity name, each activity in the merged dataset should contain the activity name in the 'activity' column. The activity names can be found in the following file:
   activity_labels.txt


#### 4. Appropriately labels the data set with descriptive variable names.

As the dataset now contains non-descriptive field (column) names to represent the features, these non-descriptive fields should be renamed to indicate the actual feature. The feature labels are found in the following file:
   features.txt
   

#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Once the completed dataset is obtained and cleaned, a second dataset is created with the average values for each participant for each activity. 

### Dataset Reference
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
