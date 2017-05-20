library(dtplyr)

activity_labels<-read.table("activity_labels.txt",col.names=c("Activity_num","Activity"))
feature_labels<-read.table("features.txt",col.names=c("Feature_num","Feature"))

x_test<-read.table("test/X_test.txt")
colnames(x_test)<-t(feature_labels[2])
y_test<-read.table("test/y_test.txt",col.names="Activity")
        for (i in 1:6){
                y_test$Activity[y_test$Activity==i]<-as.character(activity_labels[i,2])
}
subject_test<-read.table("test/subject_test.txt",col.names="Subject")
testmerge<-cbind(x_test,y_test,subject_test)

x_train<-read.table("train/X_train.txt")
colnames(x_train)<-t(feature_labels[2])
y_train<-read.table("train/y_train.txt",col.names="Activity")
        for (i in 1:6){
                y_train$Activity[y_train$Activity==i]<-as.character(activity_labels[i,2])
        }
subject_train<-read.table("train/subject_train.txt",col.names="Subject")
trainmerge<-cbind(x_train,y_train,subject_train)

test_train_data<-rbind(testmerge,trainmerge)

mean_std_data<-(test_train_data[,grepl("mean|std|Activity|Subject",names(test_train_data),ignore.case=TRUE)])

averages<-aggregate(.~Activity+Subject,mean_std_data,FUN=mean)
tidy_data<-write.table(averages,file="tidy_data.txt",row.names=FALSE)