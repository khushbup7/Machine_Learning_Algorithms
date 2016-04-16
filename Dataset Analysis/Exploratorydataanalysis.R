pima <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indians-diabetes.data",header = TRUE,sep=",")
colnames(pima) <- c("NPG","PGL","DBP","TSF","INS","BMI","DPF","AGE","Diabetes")

hist(pima$NPG,main="Histogram for No of times pregnant",xlab="No of times pregnant",las=1,breaks=10)
barplot(xtabs(~pima$NPG),xlab="No of times pregnant",main="Barplot of No of times pregnant",ylim=c(0,170))
hist(pima$PGL,main="Histogram for Plasma Glucose Concentration",xlab=" Plasma Glucose Concentration",las=1,breaks=10)
barplot(xtabs(~pima$PGL),xlab=" Plasma Glucose Concentration",main="Barplot of  Plasma Glucose Concentration",ylim=c(0,170))
hist(pima$DBP,main="Histogram for Diastolic Blood Pressure",xlab=" Diastolic Blood Pressure",las=1,breaks=10)
barplot(xtabs(~pima$DBP),xlab=" Diastolic Blood Pressure",main="Barplot of  Diastolic Blood Pressure",ylim=c(0,170))
hist(pima$TSF,main="Histogram for Triceps Skin Fold Thickness",xlab=" Triceps Skin Fold Thickness",las=1,breaks=10)
barplot(xtabs(~pima$TSF),xlab=" Triceps Skin Fold Thickness",main="Barplot of  Triceps Skin Fold Thickness",ylim=c(0,170))
hist(pima$INS,main="Histogram for 2-Hour serum insulin",xlab="2-Hour serum insulin",las=1,breaks=10)
barplot(xtabs(~pima$INS),xlab="2-Hour serum insulin",main="Barplot of  2-Hour serum insulin",ylim=c(0,170))
hist(pima$BMI,main="Histogram for Body Mass Index",xlab="Body Mass Index",las=1,breaks=10)
barplot(xtabs(~pima$BMI),xlab="Body Mass Index",main="Barplot of  Body Mass Index",ylim=c(0,170))
hist(pima$DPF,main="Histogram for Diabetes Pedigree Function",xlab="Diabetes Pedigree Function",las=1,breaks=10)
barplot(xtabs(~pima$DPF),xlab="Diabetes Pedigree Function",main="Barplot of  Diabetes Pedigree Function",ylim=c(0,170))
hist(pima$AGE,main="Histogram for Age",xlab="Age",las=1,breaks=10)
barplot(xtabs(~pima$AGE),xlab="Age",main="Barplot of Age",ylim=c(0,170))

#Correlation between No_of_Pregnancies and Class Value:
cor(pima[,"NPG"],pima[,"Diabetes"])
#Correlation between Plasma Glucose Concentration and Class Value:
cor(pima[,"PGL"],pima[,"Diabetes"])
#Correlation between Diagnostic Blood Pressure and Class Value:
cor(pima[,"DBP"],pima[,"Diabetes"])
#Correlation between Triceps Skin Fold Thickness and Class Value:
cor(pima[,"TSF"],pima[,"Diabetes"])
#Correlation between serum insulin and Class Value:
cor(pima[,"INS"],pima[,"Diabetes"])
#Correlation between Diabetes Pedigree Function and Class Value:
cor(pima[,"DPF"],pima[,"Diabetes"])
#Correlation between Body Mass Index and Class Value:
cor(pima[,"BMI"],pima[,"Diabetes"])
#Correlation between Age and Class Value:
cor(pima[,"AGE"],pima[,"Diabetes"])
#Comparing the correlations of all the non-class variables, PGC(Plasma Glucose Concentration) has strongest correlation with class variable(Correlation=0.4665814) 

max<-0
maxattribute1<-0
maxattribute2<-0

for(i in 1:7)
{
  for(j in i:7)
  {
    correlation = cor(pima[,i],pima[,j+1])
    if(abs(correlation) > max)
    {
      max = correlation
      maxattribute1 = names(pima)[i]
      maxattribute2 = names(pima)[j+1]
    }
  }
}

cat(sprintf("The highest mutually correlated attributes are %s and %s with mutual correlation %s",maxattribute1, maxattribute2,max))


