install.packages("dplyr")
install.packages("data.table")
library(dplyr)
library(data.table)

trainingset <- read.table("train/X_train.txt")
traininglabels <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")
testset <- read.table("test/X_test.txt")
testlabels <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")
features <- read.table("features.txt")

#rename columns in training and test to labels in 'features'
names(trainingset) <- features$V2
names(testset) <- features$V2

## Question 3 answer
#rename label column to 'Activity' as well as defining activity
traininglabels <- traininglabels %>% rename(Activity = V1)
traininglabels$Activity <- recode(traininglabels$Activity, "1" = "Walking", 
                                  "2" = "Walking_Upstairs", 
                                  "3" = "Walking_Downstairs",
                                  "4" = "Sitting", 
                                  "5" = "Standing", 
                                  "6" = "Laying")
testlabels <- testlabels %>% rename(Activity = V1)
testlabels$Activity <- recode(testlabels$Activity, "1" = "Walking", 
                                  "2" = "Walking_Upstairs", 
                                  "3" = "Walking_Downstairs",
                                  "4" = "Sitting", 
                                  "5" = "Standing", 
                                  "6" = "Laying")

#rename subject to 'person' and define if 'test' or 'training
subject_train <- subject_train %>% rename(person = V1)
subject_train <- subject_train %>% mutate(subject_train, "test_training" = "training")
subject_test <- subject_test %>% rename(person = V1)
subject_test <- subject_test %>% mutate(subject_test, "test_training" = "test")

#combine training datasets
training <- mutate(subject_train,traininglabels)
training <- mutate(training, trainingset)

#combine test datasets
test <- mutate(subject_test,testlabels)
test <- mutate(test, testset)

## Question 1 answer
#combine training and test datasets
dataset <- bind_rows(training,test)

## Question 2 answer
columnsToKeep <- grepl("person|test_training|Activity|mean|std", colnames(dataset))
dataset <- dataset[,columnsToKeep]

## Question 4 answer
# remove special characters
removespecialcharacters <- gsub(pattern = "[\\(\\)\\-]", replacement = "", colnames(dataset))
names(dataset) <- removespecialcharacters

# expand abbreviations and clean up names
replacef <- gsub("^f", "frequencyDomain", colnames(dataset))
names(dataset) <- replacef
replacet <- gsub("^t", "timeDomain", colnames(dataset))
names(dataset) <- replacet
replaceAcc <- gsub("Acc", "Accelerometer", colnames(dataset))
names(dataset) <- replaceAcc
replaceGyro <- gsub("Gyro", "Gyroscope", colnames(dataset))
names(dataset) <- replaceGyro
replaceMag <- gsub("Mag", "Magnitude", colnames(dataset))
names(dataset) <- replaceMag
replaceFreq <- gsub("Freq", "Frequency", colnames(dataset))
names(dataset) <- replaceFreq
replacemean <- gsub("mean", "Mean", colnames(dataset))
names(dataset) <- replacemean
replacestd <- gsub("std", "StandardDeviation", colnames(dataset))
names(dataset) <- replacestd
replaceBodyBody <- gsub("BodyBody", "Body", colnames(dataset))
names(dataset) <- replaceBodyBody

#write to csv
write.csv(dataset,"dataset.csv")

