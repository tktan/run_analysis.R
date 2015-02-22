library(reshape2)

uciHARDataset <- "UCI HAR Dataset"
uciHARDatasetZip <- paste0(uciHARDataset, ".zip")

# download the compressed data, if necessary
if (!file.exists(uciHARDatasetZip)) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, destfile=uciHARDatasetZip, method="curl")
}

# unzip the compressed data, if necessary
if (!file.exists(uciHARDataset)) {
    unzip(uciHARDatasetZip) 
}

train <- "train"
test <- "test"

feature.file <- file.path(uciHARDataset, "features.txt")
activity.file <- file.path(uciHARDataset, "activity_labels.txt")

# filePaths
#   input: either "test" or "train"
#   output: a list of file paths for the dataset, the subject, and the activity
filePaths <- function(type) {
    dataset <- file.path(uciHARDataset, type, paste0("X_", type, ".txt"))
    subject <- file.path(uciHARDataset, type, paste0("subject_", type, ".txt"))
    activity <- file.path(uciHARDataset, type, paste0("y_", type, ".txt"))
    list(dataset=dataset, subject=subject, activity=activity)
}

# createTable
#   input: a list of file paths
#   output: a table of properly labeled subject, activity, and other readings
createTable <- function(filePaths) {
    dataset <- read.table(filePaths$dataset)
    feature.labels <- read.table(feature.file)
    colnames(dataset) <- feature.labels[,2]

    subject <- read.table(filePaths$subject)
    colnames(subject) <- "subject"

    activity <- read.table(filePaths$activity)
    activity.labels <- read.table(activity.file)
    activity <- as.data.frame(merge(activity, activity.labels, by=1)[,2])
    colnames(activity) <- "activity"

    dataset <- cbind(subject, activity, dataset)
}

# prj
#   input: a table, and a regular expression
#   output: extract only those columns whose name match the regular expression
prj <- function(tab, regex) {
    cols <- grep(regex, colnames(tab), perl=TRUE)
    tab <- tab[,c(1, 2, cols)]
}

training <- createTable(filePaths(train))   # get training data
testing <- createTable(filePaths(test))     # get testing data
dataset <- rbind(training, testing)         # combine both sets of data

# extract only those columns whose names have either the word
# (*not* substring) "mean" or "std"
#
# e.g., fBodyAccMag-mean(), fBodyBodyAccJerkMag-std() will be 
# extracted, but fBodyGyro-meanFreq()-X will not
dataset <- prj(dataset, "\\b(mean|std)\\b") 

# compute the means, grouped by subject-activity
datasetL <- melt(dataset, id.var=c("subject", "activity"))
datasetW <- dcast(datasetL, subject + activity ~ variable, mean)

# write the result to means.txt
write.table(datasetW, file="means.txt", row.name=FALSE)
