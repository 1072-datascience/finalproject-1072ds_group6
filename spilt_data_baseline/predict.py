import re 
import tldextract as tl

def having_IP_Address(url):
    #regex modify from https://stackoverflow.com/questions/37437890/check-if-url-has-domain-name-and-not-an-ip
    if(re.search("^https?:\/\/([a-z0-9\\.\\-_%]+:([a-z0-9\\.\\-_%])+?@)?((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])?(:[0-9]+)?(\/[^\\s]*)?$", url)) is not None:
        return -1
    else:
        return 1
def Prefix_Suffix(url):
    result=tl.extract(url)
    if "-" in result.domain:
        return -1
    else:
        return 1

print(having_IP_Address('https://stackoverflow.com/questions/37437890/check-if-url-has-domain-name-and-not-an-ip'))
print(having_IP_Address('http://172.10.10.100/test'))
print(Prefix_Suffix('http://forums.news.cnn.com/'))
print(Prefix_Suffix('http://forums.news.cn-n.com/'))
