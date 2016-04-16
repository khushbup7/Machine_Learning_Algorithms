library("e1071")

#load data 
pima<-read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indians-diabetes.data",header=FALSE,sep=",")
colnames(pima) <- c("NPG","PGL","DBP","TSF","INS","BMI","DPF","AGE","Diabetes")
#accu prediction for 10 experiments
accu<- 0
avg <- 0
for(j in 1:10){
  indexes <- sample(1:nrow(pima), size=(0.9*nrow(pima)))
  train <- pima[indexes, ]
  test <- pima[-indexes, ]
  
  #generating naiveBayes model for given training data.
  model <- naiveBayes(Diabetes ~ ., data = train)
  prediction<-predict(model, test, type = "raw")
  count<-0
  l<-1
  for(i in 1:nrow(prediction))
  {
    if(prediction[i]>0.5)
    {
      count[l]=0
      l<-l+1
      
    }
    else
    {
      count[l]=1
      l<-l+1
    }
  }
  
  accu[j]<-(sum(test$Diabetes==count)/length(count))*100
  avg <- avg + accu[j]
}
#printing values of all experiments
n <- c("1",2,3,4,5,6,7,8,9,10)
output <- data.frame(Experiment=n, Accuracy=accu)
output
avg <- avg/10
cat(sprintf("The average accuracy of the 10 experiments is %s",avg))

