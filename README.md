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
Predicting whether the websites is phishing website or legitimate

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
資料來自OpenML網站  
* Input format 
[1] "having_IP_Address"           "URL_Length"                  "Shortining_Service"          
[4] "having_At_Symbol"            "double_slash_redirecting"    "Prefix_Suffix"              
[7] "having_Sub_Domain"           "SSLfinal_State"              "Domain_registeration_length"  
[10] "Favicon"                     "port"                        "HTTPS_token"                
[13] "Request_URL"                 "URL_of_Anchor"               "Links_in_tags"              
[16] "SFH"                         "Submitting_to_email"         "Abnormal_URL"               
[19] "Redirect"                    "on_mouseover"                "RightClick"                 
[22] "popUpWidnow"                 "Iframe"                      "age_of_domain"              
[25] "DNSRecord"                   "web_traffic"                 "Page_Rank"                  
[28] "Google_Index"                "Links_pointing_to_page"  

* Any preprocessing? 
該筆資料已依據各別變數的特性整理為類別型資料，且資料完美無缺失值，因此沒對資料另外做處理。  

### code

* Which method do you use? 
Decision Tree,Naive Bayes,SVM,Random Forest,Xgboost  
* What is a null model for comparison? 
* How do your perform evaluation? 
先取出10%的test data,剩下90%的data使用10 cross-validation找出Accuracy最高的模型，之後將最佳的模型xgboost放入test data做預測  
### results

* Which metric do you use ? 
Accuracy  
* Is your improvement significant? 
使用xgboost模型,明顯比起null model,以及其他model來得好  
* What is the challenge part of your project? 
在這份報告中，一開始遇到的挑戰是找適合的資料，有些資料雖然是我們有興趣的，但這份預測結果其實沒有什麼意義，於是我們又另外再找了一份資料。在訓練的過程當中，變數選取的判斷也是一個很大的難題  
## Reference
* Code/implementation which you include/reference (__You should indicate in your presentation if you use code for others. Otherwise, cheating will result in 0 score for final project.__) 
[1]Mofleh Al-diabat, “Detection and Prediction of Phishing Websites using Classification Mining Techniques ”, International Journal of Computer Applications (0975 – 8887) Volume 147 – No.5, August 2016  
[2]A.Martin, Na.Ba.Anutthamaa, M.Sathyavathy, Marie Manjari Saint Francois,  Dr.Prasanna Venkatesan, “A Framework for Predicting Phishing Websites Using Neural Networks ”, IJCSI International Journal of Computer Science Issues, Vol. 8, Issue 2, March 2011  
[3]Mustafa KAYTAN, Davut HANBAY, “Effective Classification of Phishing Web Pages Based on New Rules by Using Extreme Learning Machines ”, Anatolian Journal of Computer Sciences, Volume 2, No 1, 2017, P15-36  
[4]Santhana Lakshmi V, Vijaya MS, “Efficient  prediction of phishing websites using supervised learning algorithms ”, Procedia Engineering 30 (2012) 798 – 805  
[5]Rami M. Mohammad • Fadi Thabtah , “Predicting phishing websites based on self-structuring neural network”, Neural Comput & Applic (2014) 25:443–458  
[6]Jiao Mao, Jingdong Bian, Wenqian Tian, Shishi Zhu, Tao Wei, Aili Li,  Zhenkai Liang, “Detecting Phishing Websites via Aggregation Analysis of Page Layouts”, Procedia Computer Science 129 (2018) 224–230  

* Packages you use 
caret,e1071,DMwR,randomForest,xgboost.rpart  
* Related publications 


