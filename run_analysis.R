


download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "assignment_4.zip")

################ Unzip file ####################################

unzip(zipfile="assignment_4.zip")

path = file.path("C:/Users/vezyrakisg/Documents", "UCI HAR Dataset")

files = list.files(path, recursive=TRUE)




###list.files("C:/Users/vezyrakisg/Documents/UCi HAR Dataset/", recursive=TRUE)


x_train = read.table(file.path(path, "train", "X_train.txt"),header = FALSE)
y_train = read.table(file.path(path, "train", "y_train.txt"),header = FALSE)
subject_train = read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
#Reading the testing tables
x_test = read.table(file.path(path, "test", "X_test.txt"),header = FALSE)
y_test = read.table(file.path(path, "test", "y_test.txt"),header = FALSE)
subject_test = read.table(file.path(path, "test", "subject_test.txt"),header = FALSE)
#Read the features data
features = read.table(file.path(path, "features.txt"),header = FALSE)
#Read activity labels data
activity_headers = read.table(file.path(path, "activity_labels.txt"),header = FALSE)


colnames(x_train) = features[,2]
colnames(y_train) = "activityId"
colnames(subject_train) = "subjectId"

colnames(x_test) = features[,2]
colnames(y_test) = "activityId"
colnames(subject_test) = "subjectId"


colnames(activity_headers) <- c('activityId','activityType')




mrg_train = cbind(y_train, subject_train, x_train)
mrg_test = cbind(y_test, subject_test, x_test)
#Create the main data table merging both table tables - this is the outcome of 1
AllData = rbind(mrg_train, mrg_test)


colNames = colnames(AllData)


mean_and_std = (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
#A subtset has to be created to get the required dataset
Mean_Std_Data <- AllData[ , mean_and_std == TRUE]

setWithActivityNames = merge(Mean_Std_Data, activity_headers, by='activityId', all.x=TRUE)



# New tidy set has to be created 
TidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
TidySet <- TidySet[order(secTidySet$subjectId, secTidySet$activityId),]



write.table(TidySet, "TidySet.txt", row.name=FALSE)







