##### ERCONG LUO #####
##### Documentation: https://cran.r-project.org/web/packages/rtweet/rtweet.pdf ######
library(tidyverse)
library(tokenizers, stopwords)
library(rtweet)


# api_key <- "R2dCtISitUaZYUGpROOcgu332"
# api_secret <- "X2BxEdR3poedDnS8QAT0N81NVmeiRMaTjCv40iX10FXAIZPSCm"
# access_token <- "1448468830989299714-2puu3oxD9IiTlywTPx6i4b3koI2xpl"
# access_token_secret <- "VCYy2ojFVY7bDJU8aHwBckZmFLzGLT6ZyhV24YTh9Aglu"

df = search_tweets(q = "Pfizer vaccine lang:en filter:verified", n = 18000, type = "mixed", include_rts = F)
df1 = search_tweets(q = "Moderna vaccine lang:en filter:verified", n = 18000, type = "mixed", include_rts = F)
df2 = search_tweets(q = "J&J vaccine lang:en filter:verified", n = 18000, type = "mixed", include_rts = F)
df3 = search_tweets(q = "COVID vaccine lang:en filter:verified", n = 18000, type = "mixed", include_rts = F)
df4 = search_tweets(q = "COVID19 vaccine lang:en filter:verified", n = 18000, type = "mixed", include_rts = F)
df5 = search_tweets(q = "vaccine lang:en filter:verified", n = 18000, type = "mixed", include_rts = F) # here
# df6 = search_tweets(q = "corona vaccine lang:en filter:verified", n = 18000, type = "mixed", include_rts = F)
# df7 = search_tweets(q = "booster shot lang:en filter:verified", n = 18000, type = "mixed", include_rts = F)

df = df %>% select(text, created_at)
df1 = df1 %>% select(text, created_at)
df2 = df2 %>% select(text, created_at)
df3 = df3 %>% select(text, created_at)
df4 = df4 %>% select(text, created_at)
df5 = df5 %>% select(text, created_at)

df$label = 0
df1$label = 0
df2$label = 0
df3$label = 0
df4$label = 0
df5$label = 0

covid_vax = rbind(df3, df4, df5)
covid_vax = covid_vax %>% unique() %>% apply( 2, as.character)
covid_vax = covid_vax %>% as.data.frame()

# if want make sure output encoding is UTF-8, look at doc below
# documentation: https://stackoverflow.com/questions/3792846/how-to-export-a-csv-in-utf-8-format
write.csv(df, "Pfizer_tweets.csv")
write.csv(df1, "Moderna_tweets.csv")
write.csv(df2, "J&J_tweets.csv")
write.csv(covid_vax, "covidVax_tweets.csv")

##### end of file #####