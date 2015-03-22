library(dplyr)


setwd("C:/Users/Joanna/Desktop/coursera tidy data/assessment")
testData <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"")
testData_act <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"")
testData_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
trainData  <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"")
trainData_act <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainData_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

features <- read.table("./UCI HAR Dataset/features.txt", quote="\"")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"", colClasses="character")

##########1

testData2<-cbind(testData, testData_act, testData_sub)
trainData2<-cbind(trainData, trainData_act, trainData_sub)

complete<-rbind(testData, trainData)
complete2<-rbind(testData2, trainData2)


features[,2]<-as.character(features[,2])
colnames(complete)<-features[,2]

##########2

set1<-select(complete, contains("mean()"))
set2<-select(complete, contains("std()"))
set<-cbind(set1,set2)
dim(set)
dim(set1)
dim(set2)
dim(complete)

# by_cyl <- group_by(data.frame(mtcars), cyl, am)
# by_cyl %>% do(my_mean = mean(.$mpg))
# by_cyl %>% summarise(my_mean = mean(mpg))
################3
testData_act$V1 <- factor(testData_act$V1,levels=activity_labels$V1,labels=activity_labels$V2)
trainData_act$V1 <- factor(trainData_act$V1,levels=activity_labels$V1,labels=activity_labels$V2)
head(testData_act)


################4
head(features)
colnames(testData)<-colnames(trainData)<-colnames(complete)<-features[,2]
colnames(testData_act)<-colnames(trainData_act)<-c("Activity")
colnames(testData_sub)<-colnames(trainData_sub)<-c("Subject")

################5
head(complete2)
r1<-group_by(complete2, Activity, Subject) %>% do(my.mean=apply(.,2, mean, na.rm = TRUE))
r2<-group_by(complete2, Activity) %>% do(my.mean1=apply(.,2, function(x) mean(as.numeric(x), na.rm = TRUE)))
r3<-group_by(complete2, Subject) %>% do(my.mean1=apply(.,2, mean))

write.csv(complete2, "complete2.csv")
head(complete2)