#Create directory for data. Download and unzip raw data

if (!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/run_analysis.zip")
unzip("./data/run_analysis.zip")

#Read in raw data

x_data <- rbind(read.table("UCI HAR Dataset/test/X_test.txt"), read.table("UCI HAR Dataset/train/X_train.txt"))
y_data <- rbind(read.table("UCI HAR Dataset/test/y_test.txt"), read.table("UCI HAR Dataset/train/y_train.txt"))
subject_data <- rbind(read.table("UCI HAR Dataset/test/subject_test.txt"), read.table("UCI HAR Dataset/train/subject_train.txt"))

#combine raw data into one data frame

run_analysis_data <- cbind(x_data, subject_data, y_data)

#Read in variable names and create subset vectors

var_names <- read.table("UCI HAR Dataset/features.txt", header=FALSE, col.names=c("rowid", "feature"))
feature_means <- grep("mean()",var_names$feature)
feature_stds <- grep("std()", var_names$feature)

#Create vector of tidy variable names

var_names <- as.character(var_names$feature[c(feature_means, feature_stds, 562, 563)])
var_names[80:81] <- c("subject", "activity")
var_names<-gsub("-","",var_names)
var_names<-gsub("\\(","",var_names)
var_names<-gsub("\\)","",var_names) 
var_names<-tolower(var_names) 

#Subset raw data

run_analysis_data <- run_analysis_data[c(feature_means, feature_stds, 562, 563)]

#Rename variables with tidy names

names(run_analysis_data) <- var_names

#Create vector of descriptive activity data

activities <- c("walking", "walkingupstairs", "walkingdownstairs", "sitting", "standing", "laying")

#Change numeric activity data to descriprive activity data

for(i in 1:6){
  run_analysis_data[which(run_analysis_data$activity==i),81]<-activities[i]
}

#Create summary table

agg_data <- aggregate(run_analysis_data[,c(-80, -81)], by = list(run_analysis_data$subject, run_analysis_data$activity),FUN = mean)
colnames(agg_data)[c(1, 2)] <- c("subject", "activity")
write.table(agg_data, file = "agg_data.txt", sep = ",", row.names = FALSE)