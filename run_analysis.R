subject_test  <- read.table("test/subject_test.txt", quote="\"")
subject_train <- read.table("train/subject_train.txt", quote="\"")

x_test  <- read.table("test/X_test.txt", quote="\"")
x_train <- read.table("train/X_train.txt", quote="\"")

y_test  <- read.table("test/y_test.txt", quote="\"")
y_train <- read.table("train/y_train.txt", quote="\"")

features <- read.table("features.txt", quote="\"")
activity_labels <- read.table("activity_labels.txt", quote="\"")

subject <- rbind(subject_test, subject_train)
colnames(subject) <- "SubjectNumber"

y <- rbind(y_test, y_train)
colnames(y) <- "Label"

x <- rbind(x_test, x_train)
colnames(x) <- features[,2]

data_label <- merge(y, activity_labels, by = 1)
data_label <- data_label[, -1]

data <- cbind(subject, data_label, x)

library("reshape2")

data_melt = melt(data, id.var = c("SubjectNumber", "data_label"))

dataset = dcast(data_melt, SubjectNumber + data_label ~ variable,mean)

write.table(dataset, "dataset.txt" , sep = ";")