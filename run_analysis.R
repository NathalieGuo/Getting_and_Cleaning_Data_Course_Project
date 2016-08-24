#Program: Getting and Cleaning Data Course Project
#Author: Na Guo
#Date: Aug-23-2016

library(downloader)
library(dplyr)

#Download and read zip files
if(!file.exists("data")){
  dir.create("data")
}
url<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(url,destfile="./data/activity.zip",mode="wb")
unzip(zipfile="./data/activity.zip",exdir="./data")

#List downloaded files 
list.files("./data/UCI HAR Dataset")
list.files("./data/UCI HAR Dataset/test")
list.files("./data/UCI HAR Dataset/train")

#Import relevant files
features<- read.table("./data/UCI HAR Dataset/features.txt")
activity<- read.table("./data/UCI HAR Dataset/activity_labels.txt")
subject_train<- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subject_test<- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
x_train<- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train<- read.table("./data/UCI HAR Dataset/train/y_train.txt")
x_test<- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test<- read.table("./data/UCI HAR Dataset/test/y_test.txt")

#Merge train and test data 
x_all<- rbind(x_train,x_test)
y_all<- rbind(y_train,y_test)
subject_all<- rbind(subject_train,subject_test) %>% rename(subjectID=V1)
activity$V2<- tolower(as.character((activity$V2))) 
activity$V2<- gsub("_"," ",activity$V2)
y_all<- inner_join(activity,y_all,by="V1") %>%
  rename(activityfactor=V1) %>% 
  rename(activitylabel=V2)
dataone<- cbind(subject_all,y_all,x_all) %>% select(-activityfactor) 

#Modify variable names of measurements
measures<- tolower(as.character(features[,2]))
measures<- gsub("\\(*)","",measures)
measures<- gsub("\\(|-|,","_",measures)

#Extract measuresments on the mean and standard deviation
names(dataone)<- c("subjectID","activitylabel",measures)
dataone<- select(dataone[!duplicated(names(dataone))],matches("mean|std|subjectID|activitylabel"))

#Create the second tidy dataset 
datatwo <- dataone %>% group_by(subjectID,activitylabel) %>%
  summarize_each(funs(mean))
names(datatwo)<- c("subjectID","activitylabel",paste0("avg_",measures))

#Export data into txt files
write.table(dataone,row.names = FALSE,file="./data/FirstDataSet.txt")
write.table(datatwo,row.names = FALSE,file="./data/SecondDataSet.txt")
