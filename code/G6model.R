
# read parameters
args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  stop("USAGE: Rscript hw2_yourID.R --target male|female --input file1 file2 ... filen --output out.csv", call.=FALSE)
}

# parse parameters
i<-1 
while(i < length(args))
{
  if(args[i] == "--input"){
    file<-args[i+1]
    i<-i+1
  }else if(args[i] == "--output"){
    out_f<-args[i+1]
    i<-i+1
  }else{
    stop(paste("Unknown flag", args[i]), call.=FALSE)
  }
  i<-i+1
}

print("PROCESS")
print(paste("output file:", out_f))
print(paste("files      :", file))


#SVM--------------------------------------------------------------------------------
#train1<-read.csv('C:\\Users\\user\\Desktop\\NCCU\\10702\\Data Science\\final_present\\fishing web\\train_phishing_website_data.csv',header=T)
#val<-read.csv('C:\\Users\\user\\Desktop\\NCCU\\10702\\Data Science\\final_present\\fishing web\\validate_phishing_website_data.csv',header=T)
#tet<-read.csv('C:\\Users\\user\\Desktop\\NCCU\\10702\\Data Science\\final_present\\fishing web\\test_phishing_website_data.csv',header=T)

#having_IP_Address Prefix_Suffix having_Sub_Domain SSLfinal_State Domain_registeration_length Favicon HTTPS_token Request_URL URL_of_Anchor Links_in_tags SFH Abnormal_URL on_mouseover popUpWidnow Iframe age_of_domain DNSRecord web_traffic Page_Rank Google_Index Links_pointing_to_page Statistical_report Result

#train=train1+val
train<-read.csv(file,header=T)

train_factor <- apply(train, 2, as.factor)
summary(train_factor)

#tet_factor <- apply(tet, 2, as.factor)
#summary(tet_factor)
#Result<-factor(train$Result)
#tet_Result<-factor(tet$Result)
#factor
#factor(train[ ,1:23])
#summary(train)

# 檢查 NA ???數??? 
sapply(train,function(x) sum(is.na(x)))

#k fold
k <-10
split <- split(1:nrow(train),sample(cut(seq(1,nrow(train)),breaks=k,right = F,labels=F)))
#train_test<-train[split[[1]],]
train_val<-train[split[[1]],]
train_train<-train[-rbind(as.matrix(split[[1]])), ]
Accuracy1.1<- c()
Accuracy1.2<- c()
Accuracy1.3<- c()
Accuracy1.4<- c()
F1.1<- c()
F1.2<- c()
F1.3<- c()
F1.4<- c()

for (i in 1:k){
  train_test<-train[split[[i]],]
  train_test.Result<-train_test$Result
  train_train_val<-train[split[[ifelse((i+1)%%k==0,k,(i+1)%%k)]],]
  train_val.Result<-train_val$Result
  train_train<-train[-rbind(as.matrix(split[[i]]),as.matrix(split[[ifelse((i+1)%%k==0,k,(i+1)%%k)]])),]
  train_train.Result<-train_train$Result
}


##########################################################model-SVM
library(e1071)
library(DMwR)
model <-  svm(formula =as.factor(Result) ~.,data = train)
resultframe1.1<-table(data.frame(train_val.Result=train_val.Result,pred=predict(model,newdata =train_val)))
TP1.1<-resultframe1.1[1,1]+resultframe1.1[2,2]
all1.1<- dim(train_val)[1]
Accuracy1.1<-round(TP1.1/all1.1,digit = 4 )
sen1.1<-round(resultframe1.1[2,2]/(resultframe1.1[2,2]+resultframe1.1[2,1]) ,digit = 2) #sen=TP/(TP+FN)
pre1.1<-round(resultframe1.1[2,2]/(resultframe1.1[2,2]+resultframe1.1[1,2]) ,digit = 2) #pre=TP/(TP+FP)
F1.1<-round(2*pre1.1*sen1.1/(pre1.1+sen1.1),digit = 2) 

resultframe1.2<-table(data.frame(train_train.Result=train_train.Result,pred=predict(model,newdata = train_train)))
TP1.2<-resultframe1.2[1,1]+resultframe1.2[2,2]
all1.2<- dim(train_train)[1]
Accuracy1.2<-round(TP1.2/all1.2,digit = 4 )
sen1.2<-round(resultframe1.2[2,2]/(resultframe1.2[2,2]+resultframe1.2[2,1]) ,digit = 2) #sen=TP/(TP+FN)
pre1.2<-round(resultframe1.2[2,2]/(resultframe1.2[2,2]+resultframe1.2[1,2]) ,digit = 2) #pre=TP/(TP+FP)
F1.2<-round(2*pre1.2*sen1.2/(pre1.2+sen1.2),digit = 2) 

#resultframe1.3<-table(data.frame(train_test.Result=train_test.Result,pred=predict(model,newdata = train_test)))
#TP1.3<-resultframe1.3[1,1]+resultframe1.3[2,2]
#all1.3<- dim(train_test)[1]
#Accuracy1.3<-round(TP1.3/all1.3,digit = 4 )
#sen1.3<-round(resultframe1.3[2,2]/(resultframe1.3[2,2]+resultframe1.3[2,1]) ,digit = 2) #sen=TP/(TP+FN)
#pre1.3<-round(resultframe1.3[2,2]/(resultframe1.3[2,2]+resultframe1.3[1,2]) ,digit = 2) #pre=TP/(TP+FP)
#F1.3<-round(2*pre1.3*sen1.3/(pre1.3+sen1.3),digit = 2) 

#Re<-tet$Result
#resultframe1.4<-table(data.frame(Re=Re,pred=predict(model,newdata = tet)))
#TP1.4<-resultframe1.4[1,1]+resultframe1.4[2,2]
#all1.4<- dim(tet)[1]
#Accuracy1.4<-round(TP1.4/all1.4,digit = 4 )
#Accuracy1.4
#sen1.4<-round(resultframe1.4[2,2]/(resultframe1.4[2,2]+resultframe1.4[2,1]) ,digit = 2) #sen=TP/(TP+FN)
#pre1.4<-round(resultframe1.4[2,2]/(resultframe1.4[2,2]+resultframe1.4[1,2]) ,digit = 2) #pre=TP/(TP+FP)
#F1.4<-round(2*pre1.4*sen1.4/(pre1.4+sen1.4),digit = 2) 

training1<-round(mean(Accuracy1.2),digits=4)
#test1<-round(mean(Accuracy1.3),digits=4)
validation1<-round(mean(Accuracy1.1),digits=4)
#test2<-round(mean(Accuracy1.4),digits=4)
F1.1<-round(2*pre1.1*sen1.1/(pre1.1+sen1.1),digit = 4) 
F1.2<-round(2*pre1.2*sen1.2/(pre1.2+sen1.2),digit = 4) 
#F1.3<-round(2*pre1.3*sen1.3/(pre1.3+sen1.3),digit = 2) 
#F1.4<-round(2*pre1.4*sen1.4/(pre1.4+sen1.4),digit = 2) 
method<-c('SVM')
set<-c('training','validation')
Accuracy1<-c(training1,validation1)
F1a<-c(F1.1,F1.2)
output1<- data.frame(method=method,set=set,Accuracy_SVM=Accuracy1,F1=F1a)
output1


#NB--------------------------------------------------------------------------------------------------
Train<-read.csv(file,header=T)

for(i in 1:ncol(Train)){
  Train[,i]<-as.factor(Train[,i])
}
library("klaR")
library("caret")
library(e1071)
library(rpart)

c<-createFolds(Train[,30], k = 10, list = TRUE, returnTrain = FALSE)
train_accuracy<-c()
validation_accuracy<-c()
train_F1<-c()
validation_F1<-c()
for(i in 1:length(c)){
  validation<-c[[i]]
  validation_data<-Train[validation,]
  train_data<-Train[-(c(validation)),]
  NBclassfier<-naiveBayes(Result ~ ., data=train_data,laplace=6)
  predict.prob<- predict( NBclassfier,newdata=train_data,type = "class")
  t<-table(train_data$Result,predict.prob)
  recall<-sensitivity<-t[2,2]/sum(t[2,])
  specificity<-t[1,1]/sum(t[1,])
  precision<-t[2,2]/sum(t[,2])
  train_F1[i]<-2*precision*recall/(precision+recall)
  train_accuracy[i]<-(t[1,1]+t[2,2])/sum(t)
  predict.prob<- predict( NBclassfier,newdata=validation_data,type = "class")
  t<-table(validation_data$Result,predict.prob)
  recall<-sensitivity<-t[2,2]/sum(t[2,])
  specificity<-t[1,1]/sum(t[1,])
  precision<-t[2,2]/sum(t[,2])
  validation_F1[i]<-2*precision*recall/(precision+recall)
  validation_accuracy[i]<-(t[1,1]+t[2,2])/sum(t)
}
mean(train_F1)
mean(train_accuracy)
mean(validation_accuracy)
mean(validation_F1)
output4<-data.frame(method=c("Naive Bayes","Naive Bayes"),set=c("training","validation"),accuracy=c(mean(train_accuracy),mean(validation_accuracy)),F1=c(mean(train_F1),mean(validation_F1)))
output4

c<-createFolds(Train[,30], k = 10, list = TRUE, returnTrain = FALSE)
train_accuracy<-c()
validation_accuracy<-c()
train_F1<-c()
validation_F1<-c()
for(i in 1:length(c)){
  validation<-c[[i]]
  validation_data<-Train[validation,]
  train_data<-Train[-(c(validation)),]
  dt<-rpart(Result ~ ., data=train_data)
  predict.prob<-predict(dt,newdata=train_data,type = "class")
  t<-table(train_data$Result,predict.prob)
  recall<-sensitivity<-t[2,2]/sum(t[2,])
  specificity<-t[1,1]/sum(t[1,])
  precision<-t[2,2]/sum(t[,2])
  train_F1[i]<-2*precision*recall/(precision+recall)
  train_accuracy[i]<-(t[1,1]+t[2,2])/sum(t)
  predict.prob<-predict(dt,newdata=validation_data,control=rpart.control(cp=0,maxdepth=3),type = "class")
  t<-table(validation_data$Result,predict.prob)
  recall<-sensitivity<-t[2,2]/sum(t[2,])
  specificity<-t[1,1]/sum(t[1,])
  precision<-t[2,2]/sum(t[,2])
  validation_F1[i]<-2*precision*recall/(precision+recall)
  validation_accuracy[i]<-(t[1,1]+t[2,2])/sum(t)
}
mean(train_F1)
mean(train_accuracy)
mean(validation_accuracy)
mean(validation_F1)
output5<-data.frame(method=c("Decision Tree","Decision Tree"),set=c("training","validation"),accuracy=c(mean(train_accuracy),mean(validation_accuracy)),F1=c(mean(train_F1),mean(validation_F1)))
output5

#RF&XGB-------------------------------------------------------------------------------
library(dplyr)
library(ggplot2)
library(caret)
library(randomForest)
library(adabag)
library(dummies)
library(xgboost)

#setwd("C:/Users/zlsh0/Desktop/107_2/datascience/final/PhishingWebsites/")
#load("my_work_space.RDATA")

#read dataset####
#train <- read.csv("train_phishing_website_data.csv")
#validation <- read.csv("validate_phishing_website_data.csv")
#train_validation <- train %>% rbind(., validation)
#test <- read.csv("test_phishing_website_data.csv")

train_validation <- read.csv(file, header = T)

#data process####
train_factor <- apply(train_validation, 2, as.factor)
#test_factor <- apply(test, 2, as.factor)

#accuarcy function####
accuracy <- function(model, data){
  pred <- predict(model, data[,-30])
  label <- data[,30]
  t <- table(real = label, predict = pred)
  acc <- sum(diag(t))/sum(t)
  precision <- t[2,2]/(t[2,2]+t[1,2])
  sensitivity <- t[2,2]/sum(t[2,])
  specificity <- t[1,1]/sum(t[1,])
  F1 <- 2/(1/precision + 1/sensitivity)
  output <- data.frame(accuracy = acc,
                       F1 = F1)
  return(output)
}
accuracyboost <- function(model, data){
  predict_xgb <- predict(model, data.matrix(data))
  predict_xgb_label <- ifelse(predict_xgb >= 0.5, 1, 0)
  t <- table(ifelse(data[,ncol(data)] == 1, 1, 0), predict_xgb_label)
  acc <- sum(diag(t))/sum(t)
  precision <- t[2,2]/(t[2,2]+t[1,2])
  sensitivity <- t[2,2]/sum(t[2,])
  specificity <- t[1,1]/sum(t[1,])
  F1 <- 2/(1/precision + 1/sensitivity)
  output <- data.frame(accuracy = acc,
                       F1 = F1)
  return(output)
}

#random forest####
#search best mtry
#set.seed(99)
#rf.control <- trainControl(method='cv', 
#                           number=10)
#rf.tunegrid <- expand.grid(.mtry = (10:25))
#rf <- train(Result ~ ., 
#            data = train_factor,
#            method = 'rf',
#            metric = 'Accuracy',
#            tuneGrid = rf.finalgrid,
#            trControl = rf.control,
#            ntree = 200)
#rf
#plot(rf)

#10folds CV random forest output####
nfolds <- 10
set.seed(99)
flds <- createFolds(train_factor[,ncol(train_factor)], k = nfolds, list = TRUE, returnTrain = FALSE)
df <- data.frame(set = c(0),training_acc = c(0),training_f1 = c(0) ,validation_acc = c(0), validation_f1 = c(0))
for (i in 1:nfolds) {
  mvalidation <- as.data.frame(train_factor[flds[[i]],])
  mtrain <- as.data.frame(train_factor[-flds[[i]],])
  model <- randomForest(Result ~ .,
                        data = mtrain,
                        ntree = 200,
                        mtry = 15)
  
  df[i,] <- c(paste0('fold', as.character(i)) %>% 
                cbind(., accuracy(model, mtrain)) %>% 
                cbind(., accuracy(model, mvalidation)))
}
df[,2:5] <- as.data.frame(apply(df[,2:5], 2, as.numeric))
output2 <- data.frame(method = c("randomforest", "randomforest"),
                      set = c("training", "validation"),
                      accuracy = c(round(mean(df$training_acc),4),
                                   round(mean(df$validation_acc),4)),
                      F1 = c(round(mean(df$training_f1),4),
                             round(mean(df$validation_f1),4)))
output2

#random forest test accuracy####
#predict_rf <- predict(rf, test_factor[,-30])
#cm_rf <- table(predict_rf, test_factor[,30])
#( sum(diag(cm_rf))/sum(cm_rf) )

#xgboost####------------------------------------------------------------
#data preprocessing
#data <- train_factor[,-30] %>% 
#  rbind(., test_factor[,-30])
#data <- as.data.frame(data)
#data_dummy <- dummy.data.frame(data, sep = ".")
#train_dummy <- data_dummy[1:9949,]
#test_dummy <- data_dummy[9950:11055,]
#train_model <- train_dummy %>% cbind(., train_factor[,30])
#test_model <- test_dummy %>% cbind(., test_factor[,30])

data <- train_factor[,-30]
data <- as.data.frame(data)
data_dummy <- dummy.data.frame(data, sep = ".")
train_dummy <- data_dummy
train_model <- train_dummy %>% cbind(., train_factor[,30])

dtrain = xgb.DMatrix(data = data.matrix(train_dummy),
                     label = data.matrix(ifelse(train_factor[,30]==1, 1, 0)))

#parameter
xgb.params = list(
  booster = "gbtree",
  objective = "binary:logistic",
  eta = 0.3,
  gamma = 0,
  max_depth = 8,
  colsample_bytree = 1,                    
  subsample = 1
)

#search best nrounds####
#xgb cv
set.seed(99)
xgb_cvmodel <- xgb.cv(data = dtrain,
                      params = xgb.params, 
                      nfold = 10, 
                      nrounds = 1000,
                      early_stopping_rounds = 20, 
                      print_every_n = 20)

#cv test_error
#plot(xgb_cvmodel$evaluation_log[,c(1, 4)])
#cv_error <- xgb_cvmodel$evaluation_log[xgb_cvmodel$best_iteration,4]
#xgbcv_accuracy <- data.frame(niter = xgb_cvmodel$evaluation_log[,1],
#                             accuracy = 1-xgb_cvmodel$evaluation_log[,4]) #10cv_accuracy = 0.9730626
#xgbcv_accuracy[(nrow(xgbcv_accuracy)-10):nrow(xgbcv_accuracy),]

best.nrounds = xgb_cvmodel$best_iteration 

##10folds CV xgboost output####
nfolds <- 10
set.seed(99)
flds <- createFolds(train_factor[,ncol(train_factor)], k = nfolds, list = TRUE, returnTrain = FALSE)
df2 <- data.frame(set = c(0),training_acc = c(0),training_f1 = c(0) ,validation_acc = c(0), validation_f1 = c(0))
for (i in 1:nfolds) {
  mvalidation <- train_model[flds[[i]],]
  mtrain <- train_model[-flds[[i]],]
  model <- xgboost(data = data.matrix(mtrain[,-ncol(mtrain)]),
                   label = data.matrix(ifelse(mtrain[,ncol(mtrain)]==1, 1, 0)), 
                   params = xgb.params,
                   nrounds = best.nrounds,
                   verbose = 0)
  df2[i,] <- c(paste0('fold', as.character(i)) %>% 
                 cbind(., accuracyboost(model, mtrain)) %>% 
                 cbind(., accuracyboost(model, mvalidation)))
}
df2[,2:5] <- as.data.frame(apply(df2[,2:5], 2, as.numeric))
output3 <- data.frame(method = c("xgboost", "xgboost"),
                      set = c("training", "validation"),
                      accuracy = c(round(mean(df2$training_acc),4),
                                   round(mean(df2$validation_acc),4)),
                      F1 = c(round(mean(df2$training_f1),4),
                             round(mean(df2$validation_f1),4)))
output3

#final xgbmodel
#xgboost <- xgboost(data = data.matrix(train_model[,-ncol(train_model)]),
#                   label = data.matrix(ifelse(train_model[,ncol(train_model)]==1, 1, 0)), 
#                   params = xgb.params,
#                   nrounds = best.nrounds)
#xgboost
#xgb.importance(feature_names = colnames(train_dummy), model = xgboost)


#xgboost test accuracy####
#predict_xgb <- predict(xgboost, data.matrix(test_dummy))
#predict_xgb_label <- ifelse(predict_xgb >= 0.5, 1, 0)
#cm_xgb <- table(ifelse(test_factor[,30] == 1, 1, 0),predict_xgb_label)
#( sum(diag(cm_xgb))/sum(cm_xgb) )

#save.image(file = "my_work_space.RDATA")

#performance---------------------------------------------------------------------------
perf <- data.frame(method = c(),set = c(), accuracy = c(), F1 = c())
colnames(output1) <- c("method", "set", "accuracy", "F1")
colnames(output2) <- c("method", "set", "accuracy", "F1")
colnames(output3) <- c("method", "set", "accuracy", "F1")
colnames(output4) <- c("method", "set", "accuracy", "F1")
colnames(output5) <- c("method", "set", "accuracy", "F1")
perf <- perf %>% 
  rbind(., output1) %>% 
  rbind(., output2) %>% 
  rbind(., output3) %>%
  rbind(., output4) %>% 
  rbind(., output5)

perf$accuracy <- round(perf$accuracy,4)
perf$F1 <- round(perf$F1,4)

write.table(perf, file=out_f, quote=FALSE, sep='\t', row.names = F)
