# Libraries
library(dygraphs)
library(xts) # To make the convertion data-frame / xts format

# Format 3: Several variables for each date
dataDF000 = read.csv("Moderna_predictions.tsv", sep="\t")
dataDF222 = read.csv("covidVax_predictions.tsv", sep="\t")
dataDF333 = read.csv("Pfizer_predictions.tsv", sep="\t")
dataDF111 = rbind(dataDF000, dataDF222, dataDF333)
str(dataDF111)
dataDF111$created_at = as.Date.character(dataDF111$created_at)
dataDF111 = na.omit(dataDF111)
dataDF111$created_day = substr(dataDF111$created_at, 1, 10)
table(dataDF111$created_day)
dataDF111 = subset(dataDF111, select = c(created_day, prediction))
#dataDF111$created_day = as.Date(dataDF111$created_day)


x <<- c(0)
(dateuniq = unique(dataDF111$created_day))
for (day in dateuniq){
  tempdf = dataDF111[dataDF111$created_day==day, ]
  tempcount = as.vector(table(tempdf$prediction))
  x <<- c(x, tempcount)
}
(x = x[-1])
length(x)

(df111 = as.data.frame(matrix(x, ncol=5, byrow=T)))
colnames(df111) = c("Fear", "Anger", "Happy", "Sadness", "Neutral")
df111$Date = seq(from=as.Date("2021-11-27"),to=as.Date("2021-12-5"),by=1)
df111

# Then you can create the xts format:
don=xts(x=subset(df111, select = -c(Date)), order.by=df111$Date)

# Chart
p <- dygraph(don)
p

#pie(t(df111[7,1:5]/sum(df111[7,1:5])), labels = c("Fear", "Anger", "Happy", "Sadness", "Neutral"))

# Load ggplot2
library(ggplot2)
library(dplyr)

# Create Data
for (i in 1:nrow(df111)){
  data <- data.frame(
    group=c("Fear", "Anger", "Happy", "Sadness", "Neutral"),
    value=c(t(df111[i,1:5]/sum(df111[i,1:5])))
  )
  
  # Basic piechart
  g = ggplot(data, aes(x="", y=value, fill=group)) +
    geom_bar(stat="identity", width=1, color="white") +
    coord_polar("y", start=0) +
    theme_void() + # remove background, grid, numeric labels
    ggtitle(paste0("Sentiments of Tweets towards Vaccines on ", df111$Date[i])) + 
    theme(plot.title = element_text(color="black", size=10, face="bold.italic"))
  print(g)
}

x = data.frame(
  Date = rep(seq(from=as.Date("2021-11-27"),to=as.Date("2021-12-5"),by=1), 5),
  Senti = c(rep("Fear", 9), rep("Anger", 9), rep("Happiness", 9), rep("Sadness", 9), rep("Neutral", 9)),
  Value = c(df111$Fear, df111$Anger, df111$Happy, df111$Sadness, df111$Neutral)
)
x$Date = substr(as.character(x$Date),6,10)
ggplot(x, aes(fill=Senti, y=Value, x=Date)) + 
  geom_bar(position="fill", stat="identity") + 
  ggtitle("Sentiments of Tweets towards Vaccines in the Last Week") + 
  theme(plot.title = element_text(color="black", size=10, face="bold.italic"))
