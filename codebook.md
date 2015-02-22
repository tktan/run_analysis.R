# Code Book

## Transformation

Essentially, the R script, `run_analysis.R`,

1. Downloads and unzips the [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), if necessary.
2. Merges the training and test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement.
4. Uses descriptive activity names to name the activities in the data set.
5. Appropriately labels the data set with descriptive variable names.
6. From the data set in step 5, it creates a second, independently tidy data set with the average of each variable for each activity and each subject
7. Writes the results to `means.txt`

## Input Data
The R script downloads and unzips the UCI data set into the current
working directory.

## Output Data

In the original data set, the features come from the accelerometer and
gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.  These time domain
signals (prefix 't' to denote time) were captured at a constant rate of
50 Hz.  Then they were filtered using a median filter and a 3rd order
low pass Butterworth filter with a corner frequency of 20 Hz to remove
noise.  Similarly, the acceleration signal was then separated into body
and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ)
using another low pass Butterworth filter with a corner frequency of 0.3
Hz.

Subsequently, the body linear acceleration and angular velocity were
derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and
tBodyGyroJerk-XYZ).  Also the magnitude of these three-dimensional
signals were calculated using the Euclidean norm (tBodyAccMag,
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these
signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ,
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to
indicate frequency domain signals). 

Here, we first extract only the measurements on the mean and standard
deviation for each measurement.  After the pruning process, we are left
with 17 mean values (i.e., 
`tBodyAcc-mean-XYZ`,
`tGravityAcc-mean-XYZ`,
`tBodyAccJerk-mean-XYZ`,
`tBodyGyro-mean-XYZ`,
`tBodyGyroJerk-mean-XYZ`,
`tBodyAccMag-mean`,
`tGravityAccMag-mean`,
`tBodyAccJerkMag-mean`,
`tBodyGyroMag-mean`,
`tBodyGyroJerkMag-mean`,
`fBodyAcc-mean-XYZ`,
`fBodyAccJerk-mean-XYZ`,
`fBodyGyro-mean-XYZ`,
`fBodyAccMag-mean`,
`fBodyBodyAccJerkMag-mean`,
`fBodyBodyGyroMag-mean`,
`fBodyBodyGyroJerkMag-mean`) and 17 standard deviation values (i.e.,
`tBodyAcc-std-XYZ`,
`tGravityAcc-std-XYZ`,
`tBodyAccJerk-std-XYZ`,
`tBodyGyro-std-XYZ`,
`tBodyGyroJerk-std-XYZ`,
`tBodyAccMag-std`,
`tGravityAccMag-std`,
`tBodyAccJerkMag-std`,
`tBodyGyroMag-std`,
`tBodyGyroJerkMag-std`,
`fBodyAcc-std-XYZ`,
`fBodyAccJerk-std-XYZ`,
`fBodyGyro-std-XYZ`,
`fBodyAccMag-std`,
`fBodyBodyAccJerkMag-std`,
`fBodyBodyGyroMag-std`,
`fBodyBodyGyroJerkMag-std`).

Upon the successful run of the R script, `run_analysis.R`, you will get
a table saved in `means.txt`.  This is the average of each variable for
each `activity` and each `subject`.

Note that `subject` is an integer value from 1 to 30 and `activity` is
factor value that can be one of (`WALKING`, `WALKING_UPSTAIRS`,
`WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, or `LAYING`).
