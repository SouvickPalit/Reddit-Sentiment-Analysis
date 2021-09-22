############################################################################################

library(syuzhet)
library(tidyverse)
library(lubridate)

############################################################################################

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

############################################################################################

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


############################################################################################

sentiment17 = get_nrc_sentiment(comment17$comment)

data17 = 
  sentiment17 %>%
  select(negative, positive)

sentiment18 = get_nrc_sentiment(comment18$comment)

data18 = 
  sentiment18 %>%
  select(negative, positive)

sentiment19 = get_nrc_sentiment(comment19$comment)

data19 = 
  sentiment19 %>%
  select(negative, positive)

sentiment20 = get_nrc_sentiment(comment20$comment)

data20 = 
  sentiment20 %>%
  select(negative, positive)

analysis17 = cbind(comment17, data17)

analysis18 = cbind(comment18, data18)

analysis19 = cbind(comment19, data19)

analysis20 = cbind(comment20, data20)

View(analysis17)

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

write.csv(finalData, file = 'finalData.csv')

############################################################################################
