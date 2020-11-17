# Required library
library(dplyr)

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")


unzip(zipfile="./data/Dataset.zip",exdir="./data")

# 1. Merge the training and the test sets to create one data set.

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")


x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")


features <- read.table('./data/UCI HAR Dataset/features.txt')


activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')



colnames(x_train) <- features[,2]
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"


colnames(x_test) <- features[,2]
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
colnames(activityLabels) <- c('activityId','activityType')


merged_train <- cbind(y_train, subject_train, x_train)
merged_test <- cbind(y_test, subject_test, x_test)
finaldata<- rbind(merged_train, merged_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.


MrgColNames <- colnames(finaldata)


mean_and_std <- (grepl("activityId" , MrgColNames) | 
                   grepl("subjectId" , MrgColNames) | 
                   grepl("mean.." , MrgColNames) | 
                   grepl("std.." , MrgColNames) 
)


ExtractMeanAndStd <- finaldata[ , mean_and_std == TRUE]

# 3. Use descriptive activity names to name the activities in the data set.
DescriptiveActNames <- merge(ExtractMeanAndStd, activityLabels,
                             by='activityId',
                             all.x=TRUE)

# 4. Appropriately label the data set with descriptive variable names.
# Already done in bullet 1 and 2.


# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.


TidyData <- aggregate(. ~subjectId + activityId, DescriptiveActNames, mean)
TidyData <- TidyData[order(TidyData$subjectId, TidyData$activityId),]


write.table(TidyData, "TidyData.txt", row.name=FALSE)