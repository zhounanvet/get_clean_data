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
subject <- rbind(subject_train,subject_test)
label<- rbind(label_train,label_test)
measures<- rbind(train, test)
colnames(subject)<-'subject_id'
colnames(label)<- 'activity'
all<- cbind(measures,subject, label)


#####Extracts only the measurements on the mean and standard deviation for each measurement.####
indx<-grep('(mean|std)\\(\\)',features$V2)
featureselected <- as.character(features[indx,'V2'])
selected<- all[,c(indx, 562,563)]
colnames(selected)<- c(featureselected,'subject_id','activity')

######Uses descriptive activity names to name the activities in the data set######
selected_with_label<-merge(selected,activity,by.x = 'activity', by.y='V1')
selected_with_label<- selected_with_label[,!names(selected_with_label)=='activity']
names(selected_with_label)[68]<-'activity'

#######Appropriately labels the data set with descriptive variable names.######
selected_with_label


##### creates a second, independent tidy data set with the #######
#####average of each variable for each activity and each subject.#######
library(dplyr)

final<-selected_with_label %>% 
         group_by(subject_id,activity) %>% 
            summarise_if(is.numeric,mean,na.rm = TRUE)

write.table(final, file='./get_clean_data/clean_data.txt',row.name = FALSE )


