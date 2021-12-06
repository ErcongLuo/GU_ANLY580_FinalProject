library(httpuv)
library(rtweet)

#Create Token
api_key <- 
api_secret <-
access_token <- 
access_token_secret <- 

token <- create_token(
  app = "Your_app_name",
  consumer_key = api_key,
  consumer_secret = api_secret,
  access_token = access_token,
  access_secret = access_token_secret)

#Collect Tweets
data = search_tweets("#COVIDVaccine", n=50000)
#Convert time to date
data$created_day = substr(data$created_at, 1, 10)
table(data$created_day)

# Unlist hashtags to str
for (i in 1:length(data$hashtags)){
  data$tag[i] = toString(unlist(data$hashtags[i]))
}
data$tag[1]


table(data$name)
(maxid = min(data$status_id))

dataDF = subset(data, select = c(user_id, created_at, created_day, country, location, text, tag))
write.csv(dataDF, "MyTweets.csv")

# Due to the rate limit, collect data the second time 
# (maxid records the status id of the last collection)
data2 = search_tweets("#COVIDVaccine", n=10000, max_id = maxid)
data2$created_day = substr(data2$created_at, 1, 10)
table(data2$created_day)
(maxid2 = min(data2$status_id))
data2$tag = data2$hashtags
for (i in 1:length(data2$hashtags)){
  data2$tag[i] = toString(unlist(data2$hashtags[i]))
}
dataDF2 = subset(data, select = c(user_id, created_at, created_day, country, location, text, tag))
datadfff = rbind(dataDF, dataDF2)
datadfff
write.csv(datadfff, "MyTweets1.csv", fileEncoding = "utf-8")

# Select popular tweets
data1 = search_tweets("#COVIDVaccine", n=18000, type="popular")
data1$tag = 0
for (i in 1:length(data1$hashtags)){
  data1$tag[i] = toString(unlist(data1$hashtags[i]))
}
data1$created_day = substr(data1$created_at, 1, 10)
dataDF1 = subset(data1, select = c(user_id, created_at, created_day, country, location, text, tag))
write.csv(dataDF1, "MyPopularTweets1.csv", fileEncoding = "utf-8")
str(dataDF1)

data4 = search_tweets(q = "#COVIDVaccine", lang = "en", n=18000)
view(data4)
data4$tag = 0
maxid4 = min(data4$status_id)
for (i in 1:length(data1$hashtags)){
  data4$tag[i] = toString(unlist(data4$hashtags[i]))
}
data4$created_day = substr(data4$created_at, 1, 10)
dataDF4 = subset(data4, select = c(user_id, created_at, created_day, country, location, text, tag))
write.csv(dataDF4, "MyPopularTweetsen.csv", fileEncoding = "utf-8")

data5 = search_tweets(q = "#COVIDVaccine", lang = "en", n=18000, max_id = maxid4)
data5$tag = 0
#maxid4 = min(data4$status_id)
for (i in 1:length(data1$hashtags)){
  data5$tag[i] = toString(unlist(data5$hashtags[i]))
}
data5$created_day = substr(data5$created_at, 1, 10)
dataDF5 = subset(data5, select = c(user_id, created_at, created_day, country, location, text, tag))
dataDF45en = rbind(dataDF4, dataDF5)
write.csv(dataDF45en, "MyTweetsen1.csv", fileEncoding = "utf-8")
