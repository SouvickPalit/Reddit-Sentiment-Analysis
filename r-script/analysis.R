install.packages("tidytext")
install.packages(c("RedditExtractoR", "tm", "syuzhet", "dplyr", "lubridate"))
install.packages("corrplot")

library(lubridate)
library(syuzhet)
library(tm)
library(tidyverse)
library(rmarkdown)
library(tidytext)



#Cleaning Phase

comment17 = na.omit(read_csv("Reddit Comments/2017.csv"))
comment18 = na.omit(read_csv("Reddit Comments/2018.csv"))
comment19 = na.omit(read_csv("Reddit Comments/2019.csv"))
comment20 = na.omit(read_csv("Reddit Comments/2020.csv"))

View(comment17)
View(comment18)
View(comment19)
View(comment20)

comment17$comment = gsub("[^[:alnum:]]", " ", as.character(comment17$comment))
comment17$comment = gsub("[^a-zA-Z0-9]", " ", as.character(comment17$comment))

comment18$comment = gsub("[^[:alnum:]]", " ", as.character(comment18$comment))
comment18$comment = gsub("[^a-zA-Z0-9]", " ", as.character(comment18$comment))

comment19$comment = gsub("[^[:alnum:]]", " ", as.character(comment19$comment))
comment19$comment = gsub("[^a-zA-Z0-9]", " ", as.character(comment19$comment))

comment20$comment = gsub("[^[:alnum:]]", " ", as.character(comment20$comment))
comment20$comment = gsub("[^a-zA-Z0-9]", " ", as.character(comment20$comment))

comment17$comment = tolower(comment17$comment)
comment18$comment = tolower(comment18$comment)
comment19$comment = tolower(comment19$comment)
comment20$comment = tolower(comment20$comment)

#Sentiment Analysis

comment17$created = strptime(comment17$created, format = "%Y-%m-%d %H:%M")
comment18$created = strptime(comment18$created, format = "%Y-%m-%d %H:%M")
comment19$created = strptime(comment19$created, format = "%Y-%m-%d %H:%M")
comment20$created = strptime(comment20$created, format = "%Y-%m-%d %H:%M")

comment17$month = months(comment17$created)
comment18$month = months(comment18$created)
comment19$month = months(comment19$created)
comment20$month = months(comment20$created)

comment17$year = year(comment17$created)
comment18$year = year(comment18$created)
comment19$year = year(comment19$created)
comment20$year = year(comment20$created)

comment17$month = ordered(comment17$month,
                            levels = c("January", "February",
                                       "March", "April",
                                       "May", "June",
                                       "July", "August",
                                       "September", "October",
                                       "November", "December"))

comment18$month = ordered(comment18$month,
                            levels = c("January", "February",
                                       "March", "April",
                                       "May", "June",
                                       "July", "August",
                                       "September", "October",
                                       "November", "December"))

comment19$month = ordered(comment19$month,
                             levels = c("January", "February",
                                        "March", "April",
                                        "May", "June",
                                        "July", "August",
                                        "September", "October",
                                        "November", "December"))

comment20$month = ordered(comment20$month,
                             levels = c("January", "February",
                                        "March", "April",
                                        "May", "June",
                                        "July", "August",
                                        "September", "October",
                                        "November", "December"))


View(comment17)
############################################################################################

sentiment17 = get_nrc_sentiment(comment17$comment)

View(sentiment17)

data17 = 
  sentiment17 %>%
  select(negative, positive)

sentiment18 = get_nrc_sentiment(comment18$comment)

View(sentiment18)

data18 = 
  sentiment18 %>%
  select(negative, positive)

sentiment19 = get_nrc_sentiment(comment19$comment)

View(sentiment19)

data19 = 
  sentiment19 %>%
  select(negative, positive)

sentiment20 = get_nrc_sentiment(comment20$comment)
View(sentiment20)

data20 = 
  sentiment20 %>%
  select(negative, positive)

analysis17 = cbind(comment17, data17)

analysis18 = cbind(comment18, data18)

analysis19 = cbind(comment19, data19)

analysis20 = cbind(comment20, data20)

############################################################################################

data17V2 =
  analysis17 %>%
  group_by(month, year) %>%
  summarise(negMean = mean(negative), posMean = mean(positive))

data18V2 =
  analysis18 %>%
  group_by(month, year) %>%
  summarise(negMean = mean(negative), posMean = mean(positive))

data19V2 =
  analysis19 %>%
  group_by(month, year) %>%
  summarise(negMean = mean(negative), posMean = mean(positive))

data20V2 =
  analysis20 %>%
  group_by(month, year) %>%
  summarise(negMean = mean(negative),posMean = mean(positive))

############################################################################################

finalData = rbind(data17V2, data18V2 ,data19V2, data20V2)
View(finalData)



ggplot(finalData) +
  geom_col(aes(x = month, y = negMean, fill = year),
           position = "dodge") +
  coord_cartesian(ylim = c(0.6, 1.1)) +
  facet_grid(~year)

ggplot(finalData) +
  geom_smooth(aes(x = negMean, y = posMean), method = lm) +
  labs(x = "Positive Mean",
       y = "Negative Mean")

finalData %>%
  cor(negMean, posMean)


View(finalData)

max(finalData$negMean)

cor(finalData$negMean, finalData$posMean)

write.csv(finalData, file = 'finalData.csv')


drop(comments)
