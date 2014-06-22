##read names of columns and activity labels
names<-read.table("UCI HAR Dataset/features.txt")
labels<-read.table("UCI HAR Dataset/activity_labels.txt")
##find a columns to extract
col_to_extraxt<-apply(names[2], 1, function(name) grepl("mean()", name) | grepl("std()", name))
cleared_names<-as.vector(names[2][which(col_to_extraxt),])
cleared_names[80]="activity"
cleared_names[81]="subject"
##read train set
train_set<-read.table("UCI HAR Dataset/train/X_train.txt")
## use onle mean/std columns
train_set<-train_set[,which(col_to_extraxt)]
##merge with subject and activity column
train_label<-read.table("UCI HAR Dataset/train/y_train.txt")
train_subject<-read.table("UCI HAR Dataset/train/subject_train.txt")
train_set<-cbind(train_set, train_label)
train_set<-cbind(train_set, train_subject)

##same for test set
test_set<-read.table("UCI HAR Dataset/test/X_test.txt")
test_set<-test_set[,which(col_to_extraxt)]
test_label<-read.table("UCI HAR Dataset/test/y_test.txt")
test_subject<-read.table("UCI HAR Dataset/test/subject_test.txt")
test_set<-cbind(test_set, test_label)
test_set<-cbind(test_set, test_subject)
## merge sets together
merged_set<-rbind(train_set, test_set)
## add names to the column
names(merged_set)<-cleared_names
##replace activity labels with names
merged_set$activity<-factor(merged_set$activity, levels = 1:6, labels = (labels[[2]]))
##clear workspace from some data
remove(test_set)
remove(train_set)
remove(test_label)
remove(train_label)
remove(test_subject)
remove(train_subject)

##get a set splitted by activities and subject
newSet<-split(merged_set, list(merged_set$activity,merged_set$subject))
##get means for this set
tidySet<-sapply(newSet, function(x) colMeans(x[1:79]))
##save it to file
write.table(tidySet, file="./tidydata.txt", sep="\t")
