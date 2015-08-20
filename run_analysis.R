##reading files


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
colnames(ActivityData)<-c(features[,2],"act_label","id") ##rename column

##Select only mean() and std() data 
stdcoln<-grep("std()",features[,2], fixed=TRUE)
meancoln<-grep("mean()",features[,2], fixed = TRUE)
selectcol <- c(meancoln,stdcoln)
selectcol <- sort(selectcol) ##selectcol contains the col numbers of mean()/std()
TidyData<-ActivityData[c(selectcol,562,563)]

##create second tidy data frame to store the average
Tidy2<-data.frame()

for(i in 1:30){
    for(j in 1:6){
        average<-colMeans(filter(TidyData,id==i,activity_label==j))
        Tidy2<- rbind(Tidy2,average) 
    }
}

colnames(Tidy2) <- colnames(TidyData)
