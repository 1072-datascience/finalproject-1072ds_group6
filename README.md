# < Prediction of Phishing Websites>

### Groups
* < 張庭禎, 107354013 >
* < 蔣宛蓉, 107354021 >
* < 蔡伶婕, 107352007 >
* < 呂學翰, 107352033 >
* < 楊明翰, 108753203 >

### Goal
A breif introduction about your project, i.e., what is your goal?
*預測該網頁是否為釣魚網站

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
該筆資料皆已整理為類別型資料,且無缺失值,因此沒對資料另外做處理

### code

* Which method do you use?
Decision Tree,Naive Bayes,SVM,Random Forest,Xgboost
* What is a null model for comparison?
* How do your perform evaluation?
先取出10%的test data,剩下90%的data使用10 cross-validation找出Accuracy最高的模型,之後將最佳的模型xgboost放入test data做預測
### results

* Which metric do you use ?
Accuracy
* Is your improvement significant?
使用xgboost模型,明顯比起null model,以及其他model來得好
* What is the challenge part of your project?
這份報告中,較大的挑戰為找有興趣且適合做分類的資料
## Reference
* Code/implementation which you include/reference (__You should indicate in your presentation if you use code for others. Otherwise, cheating will result in 0 score for final project.__)
* Packages you use
caret,e1071,DMwR,randomForest,xgboost.rpart
* Related publications


