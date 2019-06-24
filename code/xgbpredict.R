# read parameters
args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  stop("USAGE: Rscript your_Script.R --input file1 file2 ... filen --output out.csv", call.=FALSE)
}

# parse parameters
i<-1 
while(i < length(args))
{
  if(args[i] == "--input"){
    j<-grep("-", c(args[(i+1):length(args)], "-"))[1]
    files<-args[(i+1):(i+j-1)]
    i<-i+j-1
  }else if(args[i] == "--output"){
    j<-grep("-", c(args[(i+1):length(args)], "-"))[1]
    out_f<-args[(i+1):(i+j-1)]
    i<-i+j-1
  }else{
    stop(paste("Unknown flag", args[i]), call.=FALSE)
  }
  i<-i+1
}

print("PROCESS")
print(paste("output file:", out_f))
print(paste("files      :", files))

print(files[[1]])
print(files[[2]])
print(out_f[[1]])
print(out_f[[2]])

#xgboost####------------------------------------------------------------
library(dplyr)
library(caret)
library(dummies)
library(xgboost)

train_validation <- read.csv(files[[1]], header = T)
test <- read.csv(files[[2]],header = T)

#data process####
train_factor <- apply(train_validation, 2, as.factor)
test_factor <- apply(test, 2, as.factor)

#data preprocessing
data <- train_factor[,-30] %>% 
  rbind(., test_factor[,-30])
data <- as.data.frame(data)
data_dummy <- dummy.data.frame(data, sep = ".")
train_dummy <- data_dummy[1:9949,]
test_dummy <- data_dummy[9950:11055,]
train_model <- train_dummy %>% cbind(., train_factor[,30])
test_model <- test_dummy %>% cbind(., test_factor[,30])

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

#final xgbmodel
xgboost <- xgboost(data = data.matrix(train_model[,-ncol(train_model)]),
                   label = data.matrix(ifelse(train_model[,ncol(train_model)]==1, 1, 0)), 
                   params = xgb.params,
                   nrounds = 81)
xgboost

#xgboost test accuracy####
predict_xgb <- predict(xgboost, data.matrix(test_dummy))
predict_xgb_label <- ifelse(predict_xgb >= 0.5, 1, 0)
predict_xgb_label

predict <- data.frame(predict = predict_xgb_label)

write.csv(predict,out_f[[1]])

cm_xgb <- table(test_factor[,30],ifelse(predict_xgb_label == 1, 1, -1))

write.csv(cm_xgb, out_f[[2]])



