# < Prediction of Phishing Websites>

### Groups
* < 張庭禎, 107354013 >
* < 蔣宛蓉, 107354021 >
* < 蔡伶婕, 107352007 >
* < 呂學翰, 107352033 >
* < 楊明翰, 108753203 >

### Goal
A breif introduction about your project, i.e., what is your goal?  
預測該網頁是否為釣魚網站


### Demo 
You should provide an example commend to reproduce your result
```R
Rscript code/your_script.R --input data/training --output results/performance.tsv
```
* any on-line visualization

## Folder organization and its related information

### docs
* Your presentation, 1072_datascience_FP_<yourID|groupName>.ppt/pptx/pdf, by **Jun. 25**
* Any related document for the final project
  * papers
  * software user guide

### data

* Source  
  * 資料來自OpenML網站  
  * [https://www.openml.org/d/4534?fbclid=IwAR1YnS4O3MzI0NXfOJFvGAwGCcRmDIiQEoTBas7s5F4lFSRWkfe8DUiVpLw](https://www.openml.org/d/4534?fbclid=IwAR1YnS4O3MzI0NXfOJFvGAwGCcRmDIiQEoTBas7s5F4lFSRWkfe8DUiVpLw)  

* Input format  
  
id | having_IP_Address | URL_Length | Shortining_Service| having_At_Symbol | double_slash_redirecting|...|Result
-------------: | -------------:|-------------: | -------------:|-------------: | -------------:|--------:|--------:
1|-1|1|1|1|-1|...|-1
2|1|1|1|1|1|...|-1
...|...|...|...|...|...|...|...
11055|-1|-1|1|1|1|...|-1
  
  * variables  
"having_IP_Address"           "URL_Length"                  "Shortining_Service"          
"having_At_Symbol"            "double_slash_redirecting"    "Prefix_Suffix"              
"having_Sub_Domain"           "SSLfinal_State"              "Domain_registeration_length"  
"Favicon"                     "port"                        "HTTPS_token"                
"Request_URL"                 "URL_of_Anchor"               "Links_in_tags"              
"SFH"                         "Submitting_to_email"         "Abnormal_URL"               
"Redirect"                    "on_mouseover"                "RightClick"                 
"popUpWidnow"                 "Iframe"                      "age_of_domain"              
"DNSRecord"                   "web_traffic"                 "Page_Rank"                  
"Google_Index"                "Links_pointing_to_page"  

  * [Data_description](/docs/Phishing_Websites_Features.docx)

* Any preprocessing?  
  
  * 該筆資料已依據各別變數的特性整理為類別型資料，且資料完美無缺失值，只對資料另做分析。  
![plot](/plots/var_result/result_SSL_final.png)  
![plot](/plots/corrplot/corrplot_python.png)

### code

* Which method do you use?  
  
  * Decision Tree,Naive Bayes,SVM,Random Forest,Xgboost  

```R
svm <-  svm(formula =as.factor(Result) ~.,data = train)
NBclassfier<-naiveBayes(Result ~ ., data=train_data,laplace=6)
dt<-rpart(Result ~ ., data=train_data)
xgb_cvmodel <- xgb.cv(data = dtrain, params = xgb.params, nfold = 10, nrounds = 1000, early_stopping_rounds = 20, print_every_n = 20)


```
* What is a null model for comparison?  
  
  * 由於在數據集上是平衡問題，我們利用先驗機率分佈，做出一個Null Model 理論上需要用輪盤法按照機率分配去產生Null Model分類器實作上，可以直接抽訓練數據打散之後去算準確率，就知道Null Model的準確率。  
* How do your perform evaluation?  
  
  * 先取出10%的test data,剩下90%的data使用10 cross-validation找出Accuracy最高的模型，之後將最佳的模型xgboost放入test data做預測  
### results

* Which metric do you use ?  
  
  * **Accuracy**  

method	set|	**accuracy**|	F1
------|-------------|-----
SVM	training|	0.9578|	0.9596
SVM	validation|	**0.9568**|	0.9599
randomforest	training|	0.9901|	0.9911
randomforest	validation|	**0.9709**|	0.9739
xgboost	training|	0.9889|	0.9901
xgboost	validation|	**0.9732**|	0.976
Naive Bayes	training|	0.9299|	0.9378
Naive Bayes	validation|	**0.9302**|	0.9382
Decision Tree	training|	0.9067|	0.9154
Decision Tree	validation|	**0.9067**|	0.9154
  
* Is your improvement significant?  
  
  * 使用xgboost模型,明顯比起null model,以及其他model來得好  
* What is the challenge part of your project? 
  
  * 在這份報告中，一開始遇到的挑戰是找適合的資料，有些資料雖然是我們有興趣的，但是這份資料是unbalenced，且這份預測結果其實沒有什麼意義，於是我們又另外再找了一份資料。在訓練的過程當中，變數選取的判斷也是一個很大的難題  
## Reference
* Code/implementation which you include/reference (__You should indicate in your presentation if you use code for others. Otherwise, cheating will result in 0 score for final project.__)  
  * [https://www.rdocumentation.org/packages/caret/versions/4.47/topics/train](https://www.rdocumentation.org/packages/caret/versions/4.47/topics/train)
  * [https://www.rdocumentation.org/packages/caret/versions/6.0-84/topics/trainControl](https://www.rdocumentation.org/packages/caret/versions/6.0-84/topics/trainControl)
  * [https://www.rdocumentation.org/packages/DMwR/versions/0.4.1/topics/kNN](https://www.rdocumentation.org/packages/DMwR/versions/0.4.1/topics/kNN)
  * [https://www.rdocumentation.org/packages/e1071/versions/1.7-1/topics/svm](https://www.rdocumentation.org/packages/e1071/versions/1.7-1/topics/svm)
  * [https://xgboost.readthedocs.io/en/latest/R-package/xgboostPresentation.html](https://xgboost.readthedocs.io/en/latest/R-package/xgboostPresentation.html)
  * [https://machinelearningmastery.com/how-to-estimate-model-accuracy-in-r-using-the-caret-package/](https://machinelearningmastery.com/how-to-estimate-model-accuracy-in-r-using-the-caret-package/)

* Packages you use  
    
Model|Packages
----|----
SVM|e1071、DMwR
Random Forest|caret、randomForest
XGboost|xgboost
naive bayes|caret、e1071
Decision Tree |caret、rpart
  

* Related publications  

  * [1]Mofleh Al-diabat, “Detection and Prediction of Phishing Websites using Classification Mining Techniques ”, International Journal of Computer Applications (0975 – 8887) Volume 147 – No.5, August 2016  
  * [2]A.Martin, Na.Ba.Anutthamaa, M.Sathyavathy, Marie Manjari Saint Francois,  Dr.Prasanna Venkatesan, “A Framework for Predicting Phishing Websites Using Neural Networks ”, IJCSI International Journal of Computer Science Issues, Vol. 8, Issue 2, March 2011  
  * [3]Mustafa KAYTAN, Davut HANBAY, “Effective Classification of Phishing Web Pages Based on New Rules by Using Extreme Learning Machines ”, Anatolian Journal of Computer Sciences, Volume 2, No 1, 2017, P15-36  
  * [4]Santhana Lakshmi V, Vijaya MS, “Efficient  prediction of phishing websites using supervised learning algorithms ”, Procedia Engineering 30 (2012) 798 – 805  
  * [5]Rami M. Mohammad • Fadi Thabtah , “Predicting phishing websites based on self-structuring neural network”, Neural Comput & Applic (2014) 25:443–458  
  * [6]Jiao Mao, Jingdong Bian, Wenqian Tian, Shishi Zhu, Tao Wei, Aili Li,  Zhenkai Liang, “Detecting Phishing Websites via Aggregation Analysis of Page Layouts”, Procedia Computer Science 129 (2018) 224–230  

