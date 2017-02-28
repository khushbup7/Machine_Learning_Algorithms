args <- commandArgs(TRUE)
options(warn=-1)
#get dataURL
dataURL<-as.character(args[1])
#header true or false
header<-as.logical(args[2])
#read data
d<-read.csv(dataURL,header = header,na.strings = c("?"))
d <- na.omit(d)
# which one is the class attribute
colnumber <- as.integer(args[3])
#get name of the class variable
colname <- colnames(d)[colnumber]
# change the class variable data type to factor
d[,colname]=factor(as.factor(d[,colname]), labels = c("0","1"))
levels(d[,colnumber]) <- c(0,1)

install.packages("rpart")
install.packages(stats)
install.packages("adabag")
install.packages("mlbench")
install.packages("nnet")
install.packages("ggplot2")
install.packages("caret")
install.packages("e1071")
install.packages("randomForest")
install.packages("class")

library(adabag)
library(randomForest)

set.seed(123)

avgdt <- 0
avgsvm <- 0
avgnb <- 0
avgknn <- 0
avgboost <- 0
avgrf <- 0
avgn <- 0
avgbag <- 0
avglr <- 0 

# create 10 samples
for(i in 1:10) {
cat("Running sample ",i,"\n")
sampleInstances<-sample(1:nrow(d),size = 0.9*nrow(d))
trainingData<-d[sampleInstances,]
testData<-d[-sampleInstances,]

# now create all the classifiers and output accuracy values:

# create formula for classifiers
frml <-  as.formula(paste(colname,"~.",sep=""))

# Decision Tree
library(rpart)
# build model
dt <- rpart(frml, data = trainingData, minbucket =5, method="class")
# predict on test data
preddt <- predict(dt,testData, type="class")
# calculate accuracy 
accudt <- (mean(preddt == testData[ , colnumber])) * 100
avgdt <- avgdt + accudt
method="Decision Tree" 
cat("Method = ", method,", Accuracy = ", accudt,"\n")

# Naive Bayesian
library("e1071")
# build model
naivebayes <- naiveBayes(frml, data = trainingData)
# predict on test data
prednb <- predict(naivebayes, testData, type = "class")
# calculate accuracy
accunb <- (mean(prednb == testData[ , colnumber])) * 100
avgnb <- avgnb + accunb
method="Naive Bayesian" 
cat("Method = ", method,", Accuracy = ", accunb,"\n")

# Support Vector Machine
# build model
svm <- svm(frml, kernel="linear", data = trainingData)
# predict on test data
predsvm <- predict(svm,testData, type="class")
# calculate accuracy
accusvm <- (mean(predsvm == testData[ , colnumber])) * 100
avgsvm <- avgsvm + accusvm
method="Support Vector Machine" 
cat("Method = ", method,", Accuracy = ", accusvm,"\n")


# kNN
library("class")
#build model
knn <- knn(train = trainingData[,-colnumber], test = testData[,-colnumber], 
           trainingData[, colname], k=60, prob=FALSE)
#calculate accuracy
accuknn <- (mean(knn == testData[ , colnumber])) * 100
avgknn <- avgknn + accuknn
method="kNN" 
cat("Method = ", method,", Accuracy = ", accuknn,"\n")

# Logistic Regression
library(stats)
# build model
logreg <- glm(frml,family = "binomial", trainingData)
# predict on test data
predlr <- predict(logreg,testData, type="response")
# use a threshold value and anything above that, you can assign to class=1 others to class=0
threshold = 0.65
prediction <- sapply(predlr, FUN=function(x) if (x>threshold) 1 else 0)
# calculate accuracy
acculr <- mean(prediction == testData[ ,colnumber])*100
avglr <- avglr + acculr
method="Logistic Regression" 
cat("Method = ", method,", Accuracy = ", acculr,"\n")


# Neural Network
library(nnet)
# build model
neural <- nnet(frml, trainingData,size=4,maxit=1000,decay=0.001,trace = FALSE)
# predict on test data
predn <- predict(neural,testData,type="class")
# calculate accuracy
accun <- mean(predn == testData[ ,colnumber])*100
avgn <- avgn + accun
method="Neural Network" 
cat("Method = ", method,", Accuracy = ", accun,"\n")

# Bagging
# build model
bag <- bagging(frml,data=trainingData,mfinal=20,control=rpart.control(maxdepth=3))
# predict on test data
predbag <- predict.bagging(bag,testData)
# calculate accuracy
accubag<-mean(predbag$class == testData[ ,colnumber])*100
avgbag <- avgbag + accubag
method="Bagging" 
cat("Method = ", method,", Accuracy = ", accubag,"\n")


# Random Forest
# build model
randf <- randomForest(frml, data=trainingData)
# predict on test data
predrf <- predict(randf, testData)
# calculate accuracy
accurf<-mean(predrf == testData[ ,colnumber])*100
avgrf <- avgrf + accurf
method="Random Forest" 
cat("Method = ", method,", Accuracy = ", accurf,"\n")



# Boosting
boost <- boosting(frml,trainingData,mfinal=20, coeflearn="Freund",boos=FALSE , 
                  control=rpart.control(maxdepth=3))
predboost <- predict.boosting(boost,newdata=testData)
accuboost<-mean(predboost$class == testData[ ,colnumber])*100
avgboost <- avgboost + accuboost
method="Boosting" 
cat("Method = ", method,", Accuracy = ", accuboost,"\n")
}
cat("\n\n")
cat("Method\t\t\tAverage Accuracy\n")
cat("Decision Tree\t\t\t",avgdt/10,"\n" )
cat("Naive Bayesian\t\t\t",avgnb/10,"\n" )
cat("Support Vector Machines\t\t",avgsvm/10,"\n" )
cat("kNN\t\t\t\t",avgknn/10,"\n" )
cat("Logistic Regression\t\t",avglr/10,"\n" )
cat("Neural Network\t\t\t",avgn/10,"\n" )
cat("Bagging\t\t\t\t",avgbag/10,"\n" )
cat("Random Forest\t\t\t",avgrf/10,"\n" )
cat("Boosting\t\t\t",avgboost/10,"\n" )