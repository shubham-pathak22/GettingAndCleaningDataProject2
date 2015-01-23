
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#read activity labels
activity_labels <- read.table("UCI\ HAR\ Dataset//activity_labels.txt",header=FALSE,col.names=c("id","activity"),as.is=TRUE,blank.lines.skip=TRUE)

#read features
features <- read.table("UCI\ HAR\ Dataset//features.txt",header=FALSE,col.names=c("id","feature"),blank.lines.skip=TRUE)

#######################################################
#read test set
test_df <- read.table("UCI\ HAR\ Dataset//test//X_test.txt",header=FALSE,col.names=features$feature,blank.lines.skip=TRUE)

#read test subject
test_subject <- read.table("UCI\ HAR\ Dataset//test//subject_test.txt",header=FALSE,col.names=c("subjectId"),blank.lines.skip=TRUE)

#add subject id in test set
test_df$subjectId <- test_subject$subjectId

#read test activity
test_activity <- read.table("UCI\ HAR\ Dataset//test//y_test.txt",header=FALSE,col.names=c("activity"),blank.lines.skip=TRUE)

#add labels in test set
test_df$activity <- test_activity$activity


###################################################

#read train set
train_df <- read.table("UCI\ HAR\ Dataset//train//X_train.txt",header=FALSE,col.names=features$feature,blank.lines.skip=TRUE)

#read train subject
train_subject <- read.table("UCI\ HAR\ Dataset//train//subject_train.txt",header=FALSE,col.names=c("subjectId"),blank.lines.skip=TRUE)

#add subject id in train set
train_df$subjectId <- train_subject$subjectId

#read train activity
train_activity <- read.table("UCI\ HAR\ Dataset//train//y_train.txt",header=FALSE,col.names=c("activity"),blank.lines.skip=TRUE)

#add labels in train set
train_df$activity <- train_activity$activity


##################################################

#combining train and master
master_df <- rbind(train_df,test_df)

#pattern to extract only the measurements on the mean and standard deviation for each measurement
mean_std_pattern <- grep("mean|std",names(master_df))

#data set having only the measurements on the mean and standard deviation for each measurement
master_df_mean_std <- master_df[,mean_std_pattern]
master_df_mean_std$subjectId <- master_df$subjectId
master_df_mean_std$activity <- master_df$activity

#converting subject id and activity to Factor
master_df_mean_std$activity <- as.factor(master_df_mean_std$activity)
levels(master_df_mean_std$activity) <- activity_labels$activity
master_df_mean_std$subjectId <- as.factor(master_df_mean_std$subjectId)

#Create a second, independent tidy data set with the average of each variable for each activity and each subject.
groupByactivityAndSubject <- ddply(master_df_mean_std,.(activity,subjectId),colwise(mean))

#converting names to lowercase and removing dots
names(groupByactivityAndSubject)<- gsub("\\.","",tolower(names(groupByactivityAndSubject)))

#output the tidy data to a file
write.table(groupByactivityAndSubject,row.names=FALSE,file="groupByactivityAndSubject.txt")