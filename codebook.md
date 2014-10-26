run_analysis.R codebook

This script collects a dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip containg data realting to activities recorded from accelerometers in smartphones. The information on this dataset can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones This data is then cleaned and tidied as follows:

    1. Merges the training and test sets to create one data set, First by rows using rbind() then later into one dataset using cbind() (after some cleaning is done)

    2. Reads file features.txt and extracts only the measurements on the mean and standard deviation for each measurement.

    3. Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:

    4. The script also appropriately labels the data set with descriptive names

    5. Finally, the script creates a 2nd, independent tidy data set with the average of each measurement for each activity and each subject.

