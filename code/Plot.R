d <- read.csv('Training Dataset.csv')
name <- colnames(d)[2:32]
d[name] <- lapply(d[name], factor)
summary(d)

colnames(d)[2:30]
require(ggplot2)
for (i in colnames(d)[2:31]){
  ggplot(d, aes(i, fill=Result)) + geom_bar(position = 'dodge')
  # print(noquote(i))
}
Sys.time()

ggplot(d, aes(x = Result, fill=having_IP_Address)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=URL_Length)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=Shortining_Service)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=having_At_Symbol)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=double_slash_redirecting)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=Prefix_Suffix)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=having_Sub_Domain)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=SSLfinal_State)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=Domain_registeration_length)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=Favicon)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=port)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=HTTPS_token)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=Request_URL)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=URL_of_Anchor)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=Links_in_tags)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=SFH)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=Submitting_to_email)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=Abnormal_URL)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=Redirect)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=on_mouseover)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=RightClick)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=popUpWidnow)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=Iframe)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=age_of_domain)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=DNSRecord)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=web_traffic)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=Page_Rank)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=Google_Index)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=Links_pointing_to_page)) + geom_bar(position = 'fill')
ggplot(d, aes(x = Result, fill=Statistical_report)) + geom_bar(position = 'fill')

ggplot(d, aes(Result, having_IP_Address)) + geom_point(aes(color=Result), position = 'jitter')
# ggplot(d, aes(x = Statistical_report, fill=Result)) + geom_bar(position = 'dodge')


table(is.na(d))
11055*32
colnames(d)[2:31]

library(corrplot)
library(Hmisc)
corrplot(corrmat$r)
corrmat <- rcorr(as.matrix(d[,2:31]))

# for (i in colnames(d)[2:31]){
#   barplot(table(d$i))
# }
barplot(table(d$having_IP_Address))


lapply(d[,2:31], FUN=hist)


ggplot(data = d) + geom_histogram(aes(x = having_IP_Address), binwidth = 1)


variable <- paste(colnames(d)[2:31], collapse = '+')
variable

library(reshape2)

dd1 <- melt(d[,2:6])
# dd1 <- cbind(dd1, d$Result)
dd2 <- melt(d[,7:11])
# dd2 <- cbind(dd2, d$Result)
dd3 <- melt(d[,12:16])
# dd3 <- cbind(dd3, d$Result)
dd4 <- melt(d[,17:21])
# dd4 <- cbind(dd4, d$Result)
dd5 <- melt(d[,22:26])
# dd5 <- cbind(dd5, d$Result)
dd6 <- melt(d[,27:31])
# dd6 <- cbind(dd6, d$Result)

ggplot(dd1, aes(x=value, fill=variable)) +
  geom_histogram(binwidth=1)+
  facet_grid(variable~.)

ggplot(dd2, aes(x=value, fill=variable)) +
  geom_histogram(binwidth=1)+
  facet_grid(variable~.)

ggplot(dd3, aes(x=value, fill=variable)) +
  geom_histogram(binwidth=1)+
  facet_grid(variable~.)

ggplot(dd4, aes(x=value, fill=variable)) +
  geom_histogram(binwidth=1)+
  facet_grid(variable~.)

ggplot(dd5, aes(x=value, fill=variable)) +
  geom_histogram(binwidth=1)+
  facet_grid(variable~.)

ggplot(dd6, aes(x=value, fill=variable)) +
  geom_histogram(binwidth=1)+
  facet_grid(variable~.)



