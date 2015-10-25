library(dplyr)

# This function determines the columns of interest from the file of features
extract_index <- function(feat){
  index1 <- grep("mean",feat[,2])
  index2 <- grep("std",feat[,2])
  c(index1,index2)
}

# reads the table with the code for the features
feat <- read.table("features.txt")
# Determine the columns with the 'mean' and 'std' quantities
index <- extract_index(feat)

# Read the tables with the info of the tests and add some descriptive names
subjects <- read.table("./test/subject_test.txt")
colnames(subjects)[1] <- "subjects"
activities <- read.table("./test/y_test.txt")
colnames(activities)[1] <- "activities"
results <- read.table("./test/X_test.txt")
# Extract only the columns with the 'mean' and 'std' quantities
results <- results[,index]
colnames(results) <- feat[index,2]
# Puts information about the subject, activity, and estimated quantities together
tests <- cbind(subjects,activities,results)

# Read the tables with the info of the train
subjects <- read.table("./train/subject_train.txt")
colnames(subjects)[1] <- "subjects"
activities <- read.table("./train/y_train.txt")
colnames(activities)[1] <- "activities"
results <- read.table("./train/X_train.txt")
# Extract only the columns with the 'mean' and 'std' quantities
results <- results[,index]
colnames(results) <- feat[index,2]
# Puts information about the subject, activity, and estimated quantities together
trains <- cbind(subjects,activities,results)

# And now we combine tests and trains into a single dataset
allinfo <- rbind(tests,trains)

# Let's get the real names of the activities and set them inside the big table
label <- read.table("./activity_labels.txt")
names(label) <- c("activities","activity")
Data <- merge(label,allinfo,all=TRUE)

# Label the data set with descriptive variable names
features <- names(Data)
features <- gsub("-mean()", "_mean", features, fixed=TRUE)
features <- gsub("-std()", "_std", features, fixed=TRUE)
features <- gsub("-meanFreq()", "_meanfreq", features, fixed=TRUE)
features <- gsub("-", ".", features, fixed=TRUE)
features <- gsub("Body", ".body", features, fixed=TRUE)
features <- gsub("Gravity", ".gravity", features, fixed=TRUE)
features <- gsub("Acc", ".acceleration", features, fixed=TRUE)
features <- gsub("Jerk", ".jerk", features, fixed=TRUE)
features <- gsub("Gyro", ".gyroscope", features, fixed=TRUE)
features <- gsub("Mag", ".mag", features, fixed=TRUE)
features <- gsub("t.", "time_", features, fixed=TRUE)
features <- gsub("f.", "freq_", features, fixed=TRUE)
features <- gsub("body.body.", "body.", features, fixed=TRUE)
names(Data) <- c(features)

# Create another tidy data set with the average of each variable
# for each activity and each subject.
New <- group_by(Data, activity, subject)
New <- summarise_each(New, funs(mean))

# Finally we save the tidy dataset
write.table(New,"tidydataset.txt",row.name=FALSE)


