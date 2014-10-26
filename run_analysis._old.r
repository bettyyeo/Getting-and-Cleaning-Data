run_analysis <- function(){
    
  ## Merges THE TRAINING and the test sets 
  xtrain <- read.table("train/X_train.txt")
  xtest  <- read.table("test/X_test.txt")
  combinedData <- rbind(xtrain, xtest)
  
  
  ##Extracts only the measurements on the mean 
  ## and standard deviation for each measurement.
  features <- read.table("features.txt")
  extractedIndex <- grep(".*mean.*|.*std.*", features[,2]) ## return the indexes
  extractedData <- combinedData[extractedIndex]
  extractedColNames <- features[extractedIndex,2]
  names(extractedData) <- extractedColNames
  
  ## this is for step 5
  withSubjectTrain <- read.table("train/subject_train.txt")
  withSubjectTest <- read.table("test/subject_test.txt")
  withSubjects <- rbind(withSubjectTrain,withSubjectTest)
  names(withSubjects) <- "SubjectID"
  DataWithSubject <- cbind(withSubjects, extractedData)
  
    ##Uses descriptive activity names 
  ##to name the activities in the data set
  activitylabel <- read.table("activity_labels.txt")
  names(activitylabel) <- c("ActivityID","ActivityDesc")

  ytrain <-read.table("train/y_train.txt")
  ytest <- read.table("test/y_test.txt")
  combinedActivity <- rbind(ytrain,ytest)
  names(combinedActivity) <- "ActivityID"
    
  ## add activities in the data set with the appropriate abel
  
  combActWithNames <- merge(combinedActivity,activitylabel, by="ActivityID")
  extractedDataWithActivities <- cbind(DataWithSubject,combinedActivity)
  write.table(extractedDataWithActivities, "extractedDataWithActivities", sep="\t")
  
  
}

