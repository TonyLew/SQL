run_analysis <- function() {
	## source("E:/Coursera/GettingAndCleaningDataProject/run_analysis.r")
	## run_analysis()
	## TrainSubject contains a complete list of subjects from 1 to 30

	ActivityLabels	<- read.table(file="UCIHARDataset/activity_labels.txt", sep=" ")
	colnames(ActivityLabels) <- c("ActivityID","Activity")
	TrainX 		<- read.table(file="UCIHARDataset/train/X_train.txt", sep=",")
	TrainY 		<- read.table(file="UCIHARDataset/train/Y_train.txt", sep=",")
	TrainSubject 	<- read.table(file="UCIHARDataset/train/subject_train.txt", sep=",")
	TrainTable 		<- cbind(TrainX,TrainY,TrainSubject)
	TestX 		<- read.table(file="UCIHARDataset/test/X_test.txt", sep=",")
	TestY 		<- read.table(file="UCIHARDataset/test/Y_test.txt", sep=",")
	TestSubject 	<- read.table(file="UCIHARDataset/test/subject_test.txt", sep=",")
	TestTable 		<- cbind(TestX,TestY,TestSubject)
	AllSubjects		<- rbind(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30)

	colnames(TrainTable)	<- c("TrainX","TrainY","SubjectTrain")
	colnames(TestTable)	<- c("TestX","TestY","SubjectTest")
	colnames(AllSubjects)	<- c("Subject")

	TrainMeanSD			<- aggregate(as.numeric(TrainTable$TrainX), by=list(Subject=TrainTable$SubjectTrain,Activity=TrainTable$TrainY),FUN=mean,na.rm=TRUE)
	colnames(TrainMeanSD)	<- c("SubjectID","ActivityID","Mean")
	TrainMeanSD$SD		<- sapply(as.numeric(TrainMeanSD$Mean),sd)
	TestMeanSD			<- aggregate(as.numeric(TestTable$TestX), by=list(Subject=TestTable$SubjectTest,Activity=TestTable$TestY),FUN=mean,na.rm=TRUE)
	colnames(TestMeanSD)	<- c("SubjectID","ActivityID","Mean")
	TestMeanSD$SD		<- sapply(as.numeric(TestMeanSD$Mean),sd)

	FinalTable 			<- merge( TrainMeanSD, TestMeanSD, by = c("SubjectID","ActivityID"), all.x=TRUE )
	colnames(FinalTable)	<- c("SubjectID","ActivityID","TrainMean","TrainSD","TestMean","TestSD")
	FinalTableWithLabel	<- merge( FinalTable, ActivityLabels )
	write.table(FinalTableWithLabel, row.name=FALSE)

}
