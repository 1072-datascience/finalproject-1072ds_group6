train1<-read.csv('C:\\Users\\user\\Desktop\\NCCU\\10702\\Data Science\\final_present\\fishing web\\train_phishing_website_data.csv',header=T)
val<-read.csv('C:\\Users\\user\\Desktop\\NCCU\\10702\\Data Science\\final_present\\fishing web\\validate_phishing_website_data.csv',header=T)
tet<-read.csv('C:\\Users\\user\\Desktop\\NCCU\\10702\\Data Science\\final_present\\fishing web\\test_phishing_website_data.csv',header=T)

#having_IP_Address Prefix_Suffix having_Sub_Domain SSLfinal_State Domain_registeration_length Favicon HTTPS_token Request_URL URL_of_Anchor Links_in_tags SFH Abnormal_URL on_mouseover popUpWidnow Iframe age_of_domain DNSRecord web_traffic Page_Rank Google_Index Links_pointing_to_page Statistical_report Result

#train=train1+val
train<-rbind(train1,val)

train_factor <- apply(train, 2, as.factor)
summary(train_factor)

tet_factor <- apply(tet, 2, as.factor)
summary(tet_factor)
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
train_test<-train[split[[1]],]
train_val<-train[split[[2]],]
train_train<-train[-rbind(as.matrix(split[[1]]),as.matrix(split[[2]])), ]
Accuracy1.1<- c()
Accuracy1.2<- c()
Accuracy1.3<- c()
Accuracy1.4<- c()


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

resultframe1.2<-table(data.frame(train_train.Result=train_train.Result,pred=predict(model,newdata = train_train)))
TP1.2<-resultframe1.2[1,1]+resultframe1.2[2,2]
all1.2<- dim(train_train)[1]
Accuracy1.2<-round(TP1.2/all1.2,digit = 4 )


resultframe1.3<-table(data.frame(train_test.Result=train_test.Result,pred=predict(model,newdata = train_test)))
TP1.3<-resultframe1.3[1,1]+resultframe1.3[2,2]
all1.3<- dim(train_test)[1]
Accuracy1.3<-round(TP1.3/all1.3,digit = 4 )

Re<-tet$Result
resultframe1.4<-table(data.frame(Re=Re,pred=predict(model,newdata = tet)))
TP1.4<-resultframe1.4[1,1]+resultframe1.4[2,2]
all1.4<- dim(tet)[1]
Accuracy1.4<-round(TP1.4/all1.4,digit = 4 )
Accuracy1.4

training1<-round(mean(Accuracy1.2),digits=4)
test1<-round(mean(Accuracy1.3),digits=4)
validation1<-round(mean(Accuracy1.1),digits=4)
test2<-round(mean(Accuracy1.4),digits=4)
set<-c('train-training','train-validation','train-test','test')
Accuracy1<-c(training1,validation1,test1,test2)
output1<- data.frame(set=set,
                     Accuracy_SVM=Accuracy1)
output1