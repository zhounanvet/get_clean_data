Dataset Description:

The data is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
which contains the human activity recognition using smartphones data sets. There are two sets of data, training and 
test from 30 volunteers. Each volunteer performed six activities which are documented in activity_label.txt. 561 
features are measured for each volunteer. Detailed information about the features can be found in features_info.txt
and features.txt. In the train folder, subject_train.txt identifies the subject who performed the activity for each 
window sample. Its range is from 1 to 30. y_train.txt contains the labels for each of six activities. X_train.txt 
contains the 561 features for each subject for each activity. Each feature vector is a row on the text file. The 
same description applies to the test folder.

Clean and Transformation:

Firstly, I combined the train set X_train.txt and test set X_test.txt into one dataset called all. Then I extracted
only the measurements on the mean and standard deviation for each measurements. There are 79 mean and standard 
deviation related variables in the datasets called meanstd. After that, I combined the y_train.txt and y_text.txt
file, used the activity_label.txt file to name the labels 1, 2, 3, 4, 5, 6 respectively to WALKING, WALKING_UPSTAIRS,
WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING. Also I add the label vector to all dataset as label variable. I used 
the features.txt file to label the data set with variable names and create a new dataset called all_with_label. Finally,
I created a dataset with the average of each variable for each activity and each subject. The dataset is called 
clean_data.csv. 

Tidy dataset description:

There are 180 observations and 81 variables in the data. The first column is subject which identifies the volunteer 
engaged in the study. It ranges from 1 to 30. The second column is label which contains the 6 activities for each 
subject. 3 to 81 variables are mean and standard deviation features that are average for each activity and each subject. 


