# module 6 activity
# k-NN classifier

# read data and import library
data <- read.csv("data/iris.csv", header=TRUE, sep=",")
install.packages("class")
library(class)

# shuffle the dataset
set.seed(5105)
rand <- runif(nrow(data)) #generate n random numbers
data <- data[order(rand), ] #reorder data by random numbers

# normalize variables (min-max technique)
# scales values to a range between 0-1 respective to min & max values
normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))}

iris_n <- as.data.frame(lapply(data[,c(1,2,3,4)], normalize))

# create training dataset (80-90% of original dataset)
iris_train <- iris_n[1:129, ] #1-129 to train
iris_test <- iris_n[130:150, ] #130-150 to test
iris_train_target <- data[1:129, 5] #select 5th column 'Species' as target to train
iris_test_target <- data[130:150, 5] #select 5th column 'Species' as target to test

# k-NN classification
# find k-value = sqrt(n), then closest odd number
sqrt(150) #12.25 = ~13

# create model
# cl = class label or target variable
model <- knn(train=iris_train, test=iris_test, cl=iris_train_target, k=13)

# model results
table(iris_test_target, model)
