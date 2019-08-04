####Download data########
if (!file.exists('./get_clean_data')){dir.create('./get_clean_data')}
fileurl<-'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileurl,destfile = './get_clean_data/actdata.zip')

#####read file#########
train<- read.table('./get_clean_data/UCI_HAR_Dataset/train/X_train.txt')
subject_train<-read.table('./get_clean_data/UCI_HAR_Dataset/train/subject_train.txt')
label_train<-read.table('./get_clean_data/UCI_HAR_Dataset/train/y_train.txt')
test<- read.table('./get_clean_data/UCI_HAR_Dataset/test/X_test.txt')
subject_test<-read.table('./get_clean_data/UCI_HAR_Dataset/test/subject_test.txt')
label_test<-read.table('./get_clean_data/UCI_HAR_Dataset/test/y_test.txt')
activity<-read.table('./get_clean_data/UCI_HAR_Dataset/activity_labels.txt')
features<-read.table('./get_clean_data/UCI_HAR_Dataset/features.txt')

#####1.Merges the training and the test sets to create one data set########
all<- rbind(train,test)

#####Extracts only the measurements on the mean and standard deviation for each measurement.####
indx_mean<-grep('mean()',features$V2)
indx_std<-grep('std()',features$V2)

meanstd<-all[,c(indx_mean,indx_std)]


######Uses descriptive activity names to name the activities in the data set######
labelt<-c(label_train$V1)
for (i in 1:6){
  labelt<-gsub(activity$V1[i],activity$V2[i],labelt)
}

labeltest<-c(label_test$V1)
for (i in 1:6){
  labeltest<-gsub(activity$V1[i],activity$V2[i],labeltest)
}

label<-c(labelt,labeltest)

all_with_label<-cbind(all,label)


#######Appropriately labels the data set with descriptive variable names.######
names(all)<-features$V2
all_with_name<-cbind(all,label)



##### creates a second, independent tidy data set with the #######
#####average of each variable for each activity and each subject.#######
subject<-c(subject_train$V1, subject_test$V1)

all_with_subject <- cbind(subject, all_with_label)

name<-names(all_with_subject)[c(-1,-563)]

library(dplyr)

final<-all_with_subject %>% group_by(subject,label) %>% 
                     summarise_if(is.numeric,mean,na.rm = TRUE)

