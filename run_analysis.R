##This code accesses datasets on Human Activity and cleans and merges them, than cleans the merged set 
##into a tidy data set. 
##Full description of data here:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Download the data
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f<- file.path(getwd(), "./data/zipfile.zip")
download.file(url, f, mode="wb")
unzip("./data/zipfile.zip", exdir="./data")

##Merge the datasets
#Read in each set
trainsub<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
trainy<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
trainx<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
testsub<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
testy<-read.table("./data/UCI HAR Dataset/test/y_test.txt")
testx<-read.table("./data/UCI HAR Dataset/test/X_test.txt")

#Build the two datasets
allx<-rbind(trainx, testx)
ally<-rbind(trainy, testy)
allsubject<-rbind(trainsub, testsub)

##Take the mean and std dev for each measurement
features <- read.table("./data/UCI HAR Dataset/features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
allx <- allx[, indices_of_good_features]
names(allx) <- features[indices_of_good_features, 2]
names(allx) <- gsub("\\(|\\)", "", names(allx))
names(allx) <- tolower(names(allx)) 

##Activity names for y
activity <- read.table("activity_labels.txt")
activity[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
ally[,1] = activities[ally[,1], 2]
names(ally) <- "activity"

## Form whole data set
names(allsubject)<-"subject"
Data<-cbind(allsubject, ally, allx)

##Form nicer tidy data set with just the means for each activity
library (reshape2)
id_labels = c("subject", "activity")
data_labels = setdiff(colnames(Data), id_labels)
melted_Data = melt(Data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function
tidy_Data = dcast(melted_Data, subject + activity ~ variable, mean)
write.table(tidy_Data, file = "./tidy_data.txt")
