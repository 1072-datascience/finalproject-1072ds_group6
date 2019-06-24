# All Feature Lists (30):
# id
# having_IP_Address
# URL_Length
# Shortining_Service
# having_At_Symbol
# double_slash_redirecting
# Prefix_Suffix
# having_Sub_Domain
# SSLfinal_State
# Domain_registeration_length
# Favicon
# port
# HTTPS_token
# Request_URL
# URL_of_Anchor
# Links_in_tags
# SFH
# Submitting_to_email
# Abnormal_URL
# Redirect
# on_mouseover
# RightClick
# popUpWidnow
# Iframe
# age_of_domain
# DNSRecord
# web_traffic
# Page_Rank
# Google_Index
# Links_pointing_to_page
# Statistical_report
# Result


import pandas as pd   
import random
from sklearn.tree import DecisionTreeClassifier as DTC, export_graphviz
from sklearn.metrics import accuracy_score

train_size=0.8
validate_size=0.1
test_size=0.1

data = pd.read_csv('original_phishing_website_data.csv') 
r, c = data.shape
id_list = random.sample(range(r), r)
train_spilt = int(train_size * r)
validate_spilt = int(validate_size * r) + train_spilt

# remove useless features (8)

del data['RightClick']
del data['Shortining_Service']
del data['having_At_Symbol']
del data['Submitting_to_email']
del data['port']
del data['Redirect']
del data['double_slash_redirecting']
del data['URL_Length']

# remove id (not feature)

del data['id']

data=data.sample(frac=1)  

data_train=data.iloc[0:train_spilt ,:]
data_validate=data.iloc[train_spilt:validate_spilt ,:]
data_test=data.iloc[validate_spilt:,:]

data_train.to_csv('train_phishing_website_data.csv',index=0) 
data_validate.to_csv('validate_phishing_website_data.csv',index=0) 
data_test.to_csv('test_phishing_website_data.csv',index=0) 

data_train_X= data_train.drop('Result', axis=1)
data_train_Y= data_train[['Result']]


data_test_X= data_test.drop('Result', axis=1)
data_test_Y= data_test[['Result']]

# Build null model by prior probability
data_train_Y_clone= data_train_Y.copy()
data_train_Y_clone=data_train_Y_clone.sample(frac=1)
null_spilt=int(test_size * r)
data_test_Y_null=data_train_Y_clone.iloc[0:null_spilt+1,:]
nullM_ac=accuracy_score(data_test_Y, data_test_Y_null)
print('Null Model Test Data Accuracy', nullM_ac)

tree = DTC(criterion='entropy') 
tree.fit(data_train_X, data_train_Y)

print('Test Data Accuracy ', tree.score(data_test_X, data_test_Y))