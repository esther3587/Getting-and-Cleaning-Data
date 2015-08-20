##reading files

setwd("UCI HAR Dataset")
features<-read.table("features.txt")
subject_test<-read.table("test/subject_test.txt")
X_test<-read.table("test/X_test.txt")
y_test<-read.table("test/y_test.txt")
activity_labels<-read.table("activity_labels.txt")
subject_train<-read.table("train/subject_train.txt")
X_train<-read.table("train/X_train.txt")
y_train<-read.table("train/y_train.txt")

##combine Test data 
Test<-cbind(X_test,y_test,subject_test)

##combine Train data
Train<-cbind(X_train,y_train,subject_train)

##combine train and test(Train data are top 7352 rows, test data are 2947 rows)
ActivityData<-rbind(Train,Test)
##rename columns
colnames(ActivityData)<-features[,2]
colnames(ActivityData)[562]<-"Activity"
colnames(ActivityData)[563]<-"ID"


##Select only mean() and std() data 
stdcoln<-grep("std()",features[,2], fixed=TRUE)
meancoln<-grep("mean()",features[,2], fixed = TRUE)
selectcol <- c(meancoln,stdcoln)
selectcol <- sort(selectcol) ##selectcol contains the column numbers of mean()/std()
TidyData<-ActivityData[c(selectcol,562,563)]

##create second tidy data frame to store the average
Tidy2<-data.frame()

for(i in 1:30){
    for(j in 1:6){
        average<-colMeans(filter(TidyData,ID==i,Activity==j))
        Tidy2<- rbind(Tidy2,average) 
    }
}
##rename the columns
colnames(Tidy2) <- colnames(TidyData)
##rename the activity labels
Tidy2$Activity[Tidy2$Activity==1]<-"WALKING"
Tidy2$Activity[Tidy2$Activity==2]<-"WALKING_UPSTAIRS"
Tidy2$Activity[Tidy2$Activity==3]<-"WALKING_DOWNSTAIRS"
Tidy2$Activity[Tidy2$Activity==4]<-"SITTING"
Tidy2$Activity[Tidy2$Activity==5]<-"STANDING"
Tidy2$Activity[Tidy2$Activity==6]<-"LAYING"


Tidy2 <- Tidy2[c(68,67,1:66)]  ##move id and label columns to the front
setwd("../")
write.table(Tidy2,"tidydata.txt")
