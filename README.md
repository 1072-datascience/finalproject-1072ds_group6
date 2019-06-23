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
資料來自OpenML網站
* Input format

* Any preprocessing?
該筆資料皆已整理為類別型資料,且無缺失值,因此沒對資料另外做處理

### code

* Which method do you use?
Decision Tree,Naive Bayes,SVM,Random Forest,Xgboost
* What is a null model for comparison?
* How do your perform evaluation? ie. Cross-validation, or extra separated data
先取出10%的test data,剩下90%的data使用10 cross-validation找出Accuracy最高的模型,之後將最佳的模型xgboost放入test data做預測
### results

* Which metric do you use 
  * precision, recall, R-square
* Is your improvement significant?
使用xgboost模型,明顯比起null model,以及其他model來得好
* What is the challenge part of your project?

## Reference
* Code/implementation which you include/reference (__You should indicate in your presentation if you use code for others. Otherwise, cheating will result in 0 score for final project.__)
* Packages you use
caret,e1071,DMwR,randomForest,xgboost.rpart
* Related publications


