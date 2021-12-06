##### ERCONG LUO #####
##### Documentation: https://cran.r-project.org/web/packages/rtweet/rtweet.pdf ######
library(tidyverse)
library(tokenizers, stopwords)
library(rtweet)


# api_key <- "R2dCtISitUaZYUGpROOcgu332"
# api_secret <- "X2BxEdR3poedDnS8QAT0N81NVmeiRMaTjCv40iX10FXAIZPSCm"
# access_token <- "1448468830989299714-2puu3oxD9IiTlywTPx6i4b3koI2xpl"
# access_token_secret <- "VCYy2ojFVY7bDJU8aHwBckZmFLzGLT6ZyhV24YTh9Aglu"

df = search_tweets(q = "Pfizer vaccine lang:en", n = 300, type = "popular", include_rts = F)
df1 = search_tweets(q = "Moderna vaccine lang:en", n = 300, type = "popular", include_rts = F)
df2 = search_tweets(q = "J&J vaccine lang:en", n = 300, type = "popular", include_rts = F)
df3 = search_tweets(q = "COVID vaccine lang:en", n = 300, type = "popular", include_rts = F)
df4 = search_tweets(q = "COVID19 vaccine lang:en", n = 300, type = "popular", include_rts = F)
df5 = search_tweets(q = "vaccine lang:en", n = 300, type = "popular", include_rts = F)
df6 = search_tweets(q = "corona vaccine lang:en", n = 300, type = "popular", include_rts = F)
df7 = search_tweets(q = "booster shot lang:en", n = 300, type = "popular", include_rts = F)

DF = rbind(df, df1, df2, df3, df4, df5, df6, df7)
DF = DF %>% unique() %>% apply( 2, as.character)

# make sure output encoding is UTF-8
# documentation: https://stackoverflow.com/questions/3792846/how-to-export-a-csv-in-utf-8-format
write.csv(DF, "validation_dset.csv")

##### end of file #####