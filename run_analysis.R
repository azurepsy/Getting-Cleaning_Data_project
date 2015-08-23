run_analysis <- function() {
#        # dowanload data from web
#        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#        download.file(fileUrl, destfile = "./dataset.zip")
#        unzip("./dataset.zip")
        
        # check and load dplyr library
        print("load dplyr library"); library(dplyr)
        
        # readin test and train data, merge them to a single data set
        dir1 <- "./UCI HAR Dataset/test/"
        dir2 <- "./UCI HAR Dataset/train/"
        dtest <- readin_dat(dir1)
        dtrain <- readin_dat(dir2)
        dat <- rbind(dtest, dtrain)

        # readin the feature names
        fnames <- read.table("./UCI HAR Dataset/features.txt")
        var <- c("sid", "test", as.character(fnames[, 2])); colnames(dat) <- var
        ind <- c(1,2, grep("-mean()", var, ignore.case = FALSE, fixed = TRUE),
                 grep("-std()", var, ignore.case = FALSE, fixed = TRUE))         
        dat <- subset(dat, select = var[ind])

        # put proper activity name for test 
        labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
        labels <- gsub("WALKING_","",labels[,2],fixed = TRUE)
        dat$test <- labels[dat$test]
        
        # remove "()" from each measurement and modified variable names        
        var <-  colnames(dat)
        var <- gsub(pattern = "()", replacement = "", var, fixed = TRUE)
        var <- gsub(pattern = "BodyBody", replacement = "Body", var, fixed = TRUE)
        colnames(dat) <-var
        
        # group by sid and test, compute the mean of each variables
        df <- dat %>% group_by(sid,test) %>% summarise_each(funs(mean))
        
        # output the tidy data set
        write.table(df, file = "./tidy_data.txt", row.names = FALSE)
        print("Please see the output in tidy_data.txt under the working directory.")
}

readin_dat <- function(directory) {
        # this function readin data sets under directory with optimized read.table
        # arrange the order of the files to readin
        # column combined to form a single data set
        
        list <- list.files(directory, pattern = ".txt", full.names = TRUE, ignore.case = TRUE)
        list <- list[c(1,3,2)]
        tmp <- lapply(list, read.table,
                      header = FALSE, sep="", quote="",
                      stringsAsFactors = FALSE, comment.char="",
                      colClasses = "numeric")
        dat <- do.call(cbind, tmp)
        dat
}
