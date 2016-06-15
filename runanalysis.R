## runanalysis.R
##
install.packages("data.table")
library(data.table)
library(dplyr)
#
## Retrieve Data
##
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##
if (!file.exists("./data")) {
	dir.create("./data")
}
#
download.file(url,destfile="./data/zipdata.zip")
setwd("./data")
unzip("./data/zipdata.zip")
setwd("..")
##
features <- readLines("./data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
##
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
#
y_train <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
#
##
## 1. Merge the training and the test sets to create one data set.
##
x_train <- as.data.table(x_train)
x_test <- as.data.table(x_test)
xyz_data <- rbind(x_train, x_test)
#
y_train <- as.data.table(y_train)
y_test <- as.data.table(y_test)
activity <- rbind(y_train, y_test)
#
subject_train <- as.data.table(subject_train)
subject_test <- as.data.table(subject_test)
subject <- rbind(subject_train, subject_test)
#
##
## 2. Extract only the mean and standard deviation for each measurement. 
##
colnames(xyz_data) <- c(features)
#
xyz_mean <- select(xyz_data,contains("mean("))
xyz_std <- select(xyz_data,contains("std("))
mean_std_data <- cbind(xyz_mean, xyz_std)
#
##
## 3. Use descriptive activity names to name the activities in the data set.
##
activity <- cbind(activity, V2="")
#
activity$V2[activity$V1==1]<- "Walking"
activity$V2[activity$V1==2]<- "Walking Upstairs"
activity$V2[activity$V1==3]<- "Walking Downstairs"
activity$V2[activity$V1==4]<- "Sitting"
activity$V2[activity$V1==5]<- "Standing"
activity$V2[activity$V1==6]<- "Laying"
#
activity$V1 <- NULL
#
##
## 4. Label the data set with descriptive variable names.
##
colnames(subject) <- "Subject"
colnames(activity) <- "Activity"
final_data <- cbind(subject, activity, mean_std_data)
#
feature_names <- names(final_data)
feature_names <- gsub("-", " ", feature_names,)
feature_names <- sub("^X", "", feature_names,)
feature_names <- sub("^[0-9][0-9]* ", "", feature_names,)
## Comment:  For some reason, sub did not work for me with
## sub(^X[0-9] etc.) which is why it takes place over two lines
feature_names <- sub("tBody", "Time Body ", feature_names,)
feature_names <- sub("tGravity", "Time Gravity ", feature_names,)
feature_names <- sub("fBody", "Freq Body ", feature_names,)
#
colnames(final_data) <- c(feature_names)
#
##
## 5. From the data set in step 4, create a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
##
final_sorted <- arrange(final_data,Subject)
final_grouped <- group_by(final_sorted,Subject,Activity)
tidy_data = summarize_each(final_grouped,funs(mean))
#
write.table(tidy_data,file="tidy_data.txt", row.name=F)
##