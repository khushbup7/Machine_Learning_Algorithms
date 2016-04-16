library("class")
#load data 
data<-read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indians-diabetes.data",header=FALSE,sep=",")

accu<-0
knn3 <- 0
for(i in 1:10){
  train <- sample(nrow(data),size = 690)
  training <- data[train, ]
  testing <- data[-train, ]
  cl <- as.factor(training[['V9']])
  knnModel<-knn(train=training, test=testing, cl, k=3, prob=TRUE)
  accu[i]<-mean(knnModel == testing[ , "V9"])*100 
  knn3 <- knn3 + accu[i]
}
knn3 <- knn3/10

knn5 <-0
for(i in 1:10){
  train <- sample(nrow(data),size = 690)
  training <- data[train, ]
  testing <- data[-train, ]
  
  cl <- as.factor(training[['V9']])
  knnModel<-knn(train=training, test=testing, cl, k=5, prob=TRUE)
  accu[i]<-mean(knnModel == testing[ , "V9"])*100 
  knn5 <- knn5+ accu[i]
}
knn5 <- knn5/10

knn7 <-0
for(i in 1:10){
  train <- sample(nrow(data),size = 690)
  training <- data[train, ]
  testing <- data[-train, ]
  
  cl <- as.factor(training[['V9']])
  knnModel<-knn(train=training, test=testing, cl, k=7, prob=TRUE)
  accu[i]<-mean(knnModel == testing[ , "V9"])*100 
  knn7 <- knn7 + accu[i]
  
}
knn7 <- knn7/10

knn9 <- 0
for(i in 1:10){
  train <- sample(1:nrow(data), size=(0.9*nrow(data)))
  training <- data[train, ]
  testing <- data[-train, ]
  
  cl <- as.factor(training[['V9']])
  knnModel<-knn(train=training, test=testing, cl, k=9, prob=TRUE)
  accu[i]<-mean(knnModel == testing[ , "V9"])*100
  knn9 <- knn9 + accu[i]
}
knn9 <- knn9/10

knn11<-0
for(i in 1:10){
  train <- sample(nrow(data),size = 690)
  training <- data[train, ]
  testing <- data[-train, ]
  
  cl <- as.factor(training[['V9']])
  knnModel<-knn(train=training, test=testing, cl, k=11, prob=TRUE)
  accu[i]<-mean(knnModel == testing[ , "V9"])*100 
  knn11 <- knn11 + accu[i]
}
knn11 <- knn11/10


accu <- c(knn3,knn5,knn7,knn9,knn11)
k <- c("3",5,7,9,11)
knnOut <- data.frame(K=k, Accuracy=accu)
knnOut