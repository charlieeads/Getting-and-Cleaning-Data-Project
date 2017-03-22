

#Getting and Cleaning Data Course Project


#Part 1, loading in the data sets and naming the columns


#Getting my working directory
getwd()

#loading data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="Getting and Cleaning Data Project.zip")

#loading in X training data
x_Train <- read.table("./Getting and Cleaning Data Project/UCI HAR Dataset/train/X_train.txt")
   
#loading in y training data 
y_Train <- read.table("./Getting and Cleaning Data Project/UCI HAR Dataset/train/y_train.txt")

#loading in subject training data
subject_Train <- read.table("./Getting and Cleaning Data Project/UCI HAR Dataset/train/subject_train.txt")


#taking a quick peak at the data
head(x_Train)
head(y_Train)
head(subject_Train)


#loading in X test data
x_Test <- read.table("./Getting and Cleaning Data Project/UCI HAR Dataset/test/X_test.txt")

#loading in y test data 
y_Test <- read.table("./Getting and Cleaning Data Project/UCI HAR Dataset/test/y_test.txt")

#loading in subject test data
subject_Test <- read.table("./Getting and Cleaning Data Project/UCI HAR Dataset/test/subject_test.txt")

#loading in features data
subject_Features <- read.table("./Getting and Cleaning Data Project/UCI HAR Dataset/features.txt")

#loading in activity labels data
subject_Activity <- read.table("./Getting and Cleaning Data Project/UCI HAR Dataset/activity_labels.txt")


#taking a quick peak at the data
head(x_Test)
head(y_Test)
head(subject_Features)
head(subject_Activity)
head(subject_Test)


#Naming the columns

colnames(x_Train) <- subject_Features[,2]

colnames(subject_Train) <- "subjectID"

colnames(y_Train) <- "ActivityID"



colnames(x_Test) <- subject_Features[,2] 

colnames(subject_Test) <- "subjectID"

colnames(y_Test) <- "ActivityID"


colnames(subject_Activity) <- c('ActivityID','activityType')



#1 merging the data sets
#4a this is also part of #4 as I am labeling the data set with desciptive variable names

#using cbind and rbind to combine these data sets
merge_Train <- cbind(y_Train, subject_Train, x_Train)

merge_test <- cbind(y_Test, subject_Test, x_Test)

mergedData <- rbind(merge_Train, merge_test)


#Checking data
head(mergedData)
names(mergedData)



#2 extracting out parts with mean and standard deviation for each measurement
#4b this is also part of #4(the last part)

#Putting column names into a variable
columnnames <- colnames(mergedData)

#Vector defining ID, mean and SD
mean_std <- (grepl("ActivityID", columnnames) |
             grepl("subjectID", columnnames) | 
             grepl("mean..", columnnames) | 
             grepl("std..", columnnames))

#Peaking at the data
head(mean_std)
mean_std

#subsetting the TRUE values from mean_std into a variable
MeanAndStd <- mergedData[, mean_std == TRUE]

head(MeanAndStd)




#3 making descriptive names for activies in data set


#this will merge the descriptive subject_Activity column into the MeanAndStd table
ActivityNames <- merge(MeanAndStd, subject_Activity,by='ActivityID', all.x=TRUE)

head(ActivityNames)



#4 see end of #1 and #2(#4a and #4b), these were part of labeling the data set with descriptive names



#Step 5 Creating a second Tidy Data set with Average of each variable for each activity and subject

#creating this second data set with average of each variable on activity and subject
tidydataset2 <- aggregate(. ~subjectID + ActivityID, ActivityNames, mean)

head(tidydataset2)

tidydataset2 <- tidydataset2[order(tidydataset2$subjectID, tidydataset2$ActivityID),]

head(tidydataset2)

#writing the data set into a txt file on computer
write.table(tidydataset2, "tidaydataset2.txt", row.names = FALSE)

