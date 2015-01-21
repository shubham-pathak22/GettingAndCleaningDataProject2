# GettingAndCleaningDataProject2
Course project 2 for Getting and Cleaning Data course

run_analysis.R 

**Assumptions**

1. All files required for the assignment are present in folder named *UCI HAR Dataset*.
2. Folder *UCI HAR Dataset* is present in the working directory

**The script performs following steps**

1. Reads activity labels and features from activity_labels.txt and features.txt respectively in data frame *activity_labels* and *features* respectively 
2. Generates a data frame *test_df* from test set. test_df contains 561 columns ( 1 for each observation ) , subject , activity . All observations 
  are given labels using features data frame created in step 1.
3. Generates a data frame *train_df* from train set.
4. Generates master data frame *master_df* that has data from both *train_df* and *test_df*
5. Create data frame *master_df_mean_std* that extracts only the measurements on the mean and standard deviation for each measurement
6. Converts subject and activity into factors. Labels activity with description using *activity_labels* 
7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject named *groupByactivityAndSubject*
8. Writes the data set created in step 7 to a file named *groupByactivityAndSubject.txt*