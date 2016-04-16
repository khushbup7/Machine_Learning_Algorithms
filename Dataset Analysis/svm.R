library("e1071")

pima<-read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indians-diabetes.data",header=FALSE,sep=",")
colnames(pima) <- c("NPG","PGL","DBP","TSF","INS","BMI","DPF","AGE","Diabetes")
#for kernal=linear
accu<-0
avglinear <- 0
for(j in 1:10){
  indexes <- sample(nrow(pima),size = 690)
  train <- pima[indexes, ]
  test <- pima[-indexes, ]
  model <- svm(Diabetes~., kernel="linear", data = train)
  pred <- predict(model,test, type="raw")
  l<-1
  count<-0
  
  for(i in 1:length(pred))
  {
    if(unname(pred[i])>0.5)
    {
      count[l]=1
      l<-l+1
    }
    else
    {
      count[l]=0
      l<-l+1
    }
    
  }
  accu[j]<-(sum(test$Diabetes==count)/length(count))*100
  avglinear <- avglinear + accu[j]
}
avglinear <- avglinear/10

#for kernal=polynomial
avgpoly <- 0
for(j in 1:10){
  indexes <- sample(nrow(pima),size = 690)
  train <- pima[indexes, ]
  test <- pima[-indexes, ]
  model <- svm(Diabetes~., kernel="polynomial", data = train)
  pred <- predict(model,test, type="raw")
  l<-1
  count<-0
  
  for(i in 1:length(pred))
  {
    if(unname(pred[i])>0.5)
    {
      count[l]=1
      l<-l+1
    }
    else
    {
      count[l]=0
      l<-l+1
    }
    
  }
  accu[j]<-(sum(test$Diabetes==count)/length(count))*100
  avgpoly <- avgpoly + accu[j]
}
avgpoly <- avgpoly/10



#for kernal=radial
avgradial <- 0
for(j in 1:10){
  indexes <- sample(1:nrow(pima), size=(0.9*nrow(pima)))
  train <- pima[indexes, ]
  test <- pima[-indexes, ]
  model <- svm(Diabetes~., kernel="radial", data = train)
  pred <- predict(model,test, type="raw")
  l<-1
  count<-0
  
  for(i in 1:length(pred))
  {
    if(unname(pred[i])>0.5)
    {
      count[l]=1
      l<-l+1
    }
    else
    {
      count[l]=0
      l<-l+1
    }
    
  }
  accu[j]<-(sum(test$Diabetes==count)/length(count))*100
  avgradial <- avgradial + accu[j]
}
avgradial <- avgradial/10

#for kernel=sigmoid

avgsig <- 0
for(j in 1:10){
  indexes <- sample(nrow(pima),size = 690)
  train <- pima[indexes, ]
  test <- pima[-indexes, ]
  model <- svm(Diabetes~., kernel="sigmoid", data = train)
  pred <- predict(model,test, type="raw")
  l<-1
  count<-0
  
  for(i in 1:length(pred))
  {
    if(unname(pred[i])>0.5)
    {
      count[l]=1
      l<-l+1
    }
    else
    {
      count[l]=0
      l<-l+1
    }
    
  }
  accu[j]<-(sum(test$Diabetes==count)/length(count))*100
  avgsig <- avgsig + accu[j]
}
avgsig <- avgsig/10

accu <- c(avglinear,avgpoly,avgradial,avgsig)
ker <- c("Linear","Poynomial","Radial","Sigmoid")
svmout <- data.frame(Kernel=ker, Average_Accuracy=accu)
svmout

