## Generated derived attributes 

# Loading train dataset
train <- read.csv("train_aWnotuB.csv")

# Loading test dataset
test <- read.csv("test_BdBKkAj.csv")

# Fixing datatypes
train$Vehicles <- as.character(train$Vehicles)
train$Vehicles <- as.numeric(train$Vehicles)

train$Junction <- as.character(train$Junction)
train$Junction <- as.numeric(train$Junction)

test$Junction <- as.character(test$Junction)
test$Junction <- as.numeric(test$Junction)

library(lubridate)
train$DateTime <- ymd_hms(train$DateTime)
test$DateTime <- ymd_hms(test$DateTime)

# Quarter feature 
train$quarter <- quarter(train$DateTime)
test$quarter <- quarter(test$DateTime)

#adding weekday feature
train$wday<- as.POSIXlt(train$DateTime)$wday
test$wday<- as.POSIXlt(test$DateTime)$wday
train$wday <- as.numeric(train$wday)
test$wday <- as.numeric(test$wday)

#adding weekend feature
test$weekend<- 0
test$weekend[test$wday==0]<- 1
test$weekend[test$wday==6]<- 1
train$weekend<- 0
train$weekend[train$wday==0]<- 1
train$weekend[train$wday==6]<- 1

#Breaking date time into features of year, month, hour, minute, second
library(tidyr)
train <- train %>% separate(DateTime, c("date", "time"), " ")
train <- train %>% separate(time, c("hour", "minute", "second"), ":")
train <- train %>% separate(date, c("year", "month", "day"), "-")

test <- test %>% separate(DateTime, c("date", "time"), " ")
test <- test %>% separate(time, c("hour", "minute", "second"), ":")
test <- test %>% separate(date, c("year", "month", "day"), "-")

# fixing data types
train$month <- as.numeric(as.character(train$month))
train$day <- as.numeric(as.character(train$day))
train$hour <- as.numeric(as.character(train$hour))

test$month <- as.numeric(as.character(test$month))
test$day <- as.numeric(as.character(test$day))
test$hour <- as.numeric(as.character(test$hour))

# fixing data type of year and scaling to lower range for convience
train$year <- as.numeric(train$year)
test$year <- as.numeric(test$year)
train$year <- train$year-2015
test$year <- test$year-2015