## This script downloads the raw data files of the UCI HAR Dataset and then sets to
## create a tidy data set
## The 1st section gets the working directory, downloads the file
## and loads the required R library and sets the working directory for the datafiles
  gwd <- getwd()  
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url,"./UCI_HAR_Dataset.zip")
  unzip("./UCI_HAR_Dataset.zip")
  library(dplyr)
  fpath <- paste(gwd,"/UCI HAR Dataset",sep="")
  setwd(fpath)
## The following section will read the various files & create dataframes
  trg_data <- read.table("./train/X_train.txt",colClasses="numeric")
  trg_act_id <- read.table("./train/y_train.txt")
  trg_subj_id <- read.table("./train/subject_train.txt")
  test_data <- read.table("./test/X_test.txt",colClasses="numeric")
  test_act_id <- read.table("./test/y_test.txt")
  test_subj_id <- read.table("./test/subject_test.txt")
  act_labels <- read.table("./activity_labels.txt")
  var_features <- read.table("./features.txt")
## This section will select the required mean & std columns from the datasets
## It also applies column headers to the various datasets
  mean_cols <- grep("mean\\()",var_features$V2)
  std_cols <-  grep("std\\()",var_features$V2)
  ord_cols <- sort(c(mean_cols,std_cols))
  tmp_trg_set <- trg_data[,ord_cols]
  tmp_test_set <- test_data[,ord_cols]
  colheads <- var_features[ord_cols,"V2"]
  colnames(tmp_test_set) <- make.names(colheads)
  colnames(tmp_trg_set) <- make.names(colheads)
  colnames(test_subj_id) <- "subject_id"
  colnames(trg_subj_id) <- "subject_id"
  colnames(test_act_id) <- "activity_id"
  colnames(trg_act_id) <- "activity_id"
  colnames(act_labels) <- c("activity_id","activity_desc")
## The following section merges the subject, activity & measurement datasets
## and then creates a single data set with both training & test data
  trg_set <- cbind(trg_subj_id,trg_act_id,tmp_trg_set)
  test_set <- cbind(test_subj_id,test_act_id,tmp_test_set)
  all_set <- rbind_list(trg_set,test_set)
## This section sets descriptive names for the Activity IDs
## It ends by renaming the column with activities as "activity_desc"
  set_with_act_lbl <- left_join(all_set,act_labels,by="activity_id")
  set_with_act_lbl <- mutate(set_with_act_lbl,activity_id = activity_desc)
  final_set <- select(set_with_act_lbl,-activity_desc)
  names(final_set)[names(final_set) == "activity_id"] <- "activity_desc" 
## This section creates a tidy dataset with the average of each variable for each activity
## and each subject
  by_act_subject <- group_by(final_set, activity_desc, subject_id)
  tidy_set <- summarise_each(by_act_subject,funs(mean))
  write.table(tidy_set, "./tidyset.txt",sep=",", row.names=FALSE)

  