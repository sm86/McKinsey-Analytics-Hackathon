# Seperate model for each Junction

## Junction 1 Model

# Subsetting Junction 1
trainJ1 <- train[train$Junction==1,]
testJ1 <- test[test$Junction==1,]

# Features are year, month, day, hour, Weekday, weekend.
dtrainJ1 = xgb.DMatrix(data = as.matrix(trainJ1[,c(1,2,3, 4,11,12)]), label = trainJ1$Vehicles)
dtestJ1 = xgb.DMatrix(data = as.matrix(testJ1[,c(1,2,3, 4,10,11)]))

param <- list(objective = "reg:linear",
              eval_metric = "rmse",
              max_depth = 5,
              showsd = TRUE,
              eta = 0.1,
              gamma = 0, 
              subsample = 0.8,
              colsample_bytree = 0.8, 
              min_child_weight = 1,
              set.seed = 0)
# Set seed is to save model
set.seed(1)
modelJ1 <- xgb.train(dtrainJ1,params = param,nrounds = 463, verbose = 1, watchlist = list(train=dtrainJ1))

predJ1 <- predict(modelJ1, dtestJ1)
testJ1$Vehicles <- predJ1


# Model for Junction 2 
trainJ2 <- train[train$Junction==2,]
testJ2 <- test[test$Junction==2,]

# Features are year, month, hour, day, Weekday, weekend.
dtrainJ2 = xgb.DMatrix(data = as.matrix(trainJ1[,c(1,2,3, 4,11,12)]), label = trainJ2$Vehicles)
dtestJ2 = xgb.DMatrix(data = as.matrix(testJ1[,c(1,2,3, 4,10,11)]))

param <- list(objective = "reg:linear",
              eval_metric = "rmse",
              max_depth = 5,
              showsd = TRUE,
              eta = 0.1,
              gamma = 0, 
              subsample = 0.8,
              colsample_bytree = 0.8, 
              min_child_weight = 1,
              set.seed = 0)
set.seed(2)
modelJ2 <- xgb.train(dtrainJ2,params = param,nrounds = 463, verbose = 1, watchlist = list(train=dtrainJ2))

predJ2 <- predict(modelJ2, dtestJ2)
testJ2$Vehicles <- predJ2

# Model for Junction 3
trainJ3 <- train[train$Junction==3,]
testJ3 <- test[test$Junction==3,]

# Features are year, month, day, hour
dtrainJ3 = xgb.DMatrix(data = as.matrix(trainJ3[,c(1,2,3, 4)]), label = trainJ3$Vehicles)
dtestJ3= xgb.DMatrix(data = as.matrix(testJ3[,c(1,2,3, 4)]))

param <- list(objective = "reg:linear",
              eval_metric = "rmse",
              max_depth = 5,
              showsd = TRUE,
              eta = 0.01,
              gamma = 0, 
              subsample = 0.8,
              colsample_bytree = 0.8, 
              min_child_weight = 1,
              set.seed = 0)
set.seed(1)

# Train and predicted using XGBoost
modelJ3 <- xgb.train(dtrainJ3,params = param,nrounds = 750, verbose = 1, watchlist = list(train=dtrainJ1))
predJ3 <- predict(modelJ3, dtestJ3)

# Trained and predicted using Linear regression
model <- lm(Vehicles~year*hour*month, data = trainJ3)
predictd <- predict(model, testJ3)


# The performance of XGBoost was not satisfactory, so I have also predicted with Linear models 
## and took average of both the models
# agreegate of both linear and XGBoost model
testJ3$Vehicles <- (predJ3+predictd)/2

# Model for Junction 4
trainJ4 <- train[train$Junction==4,]
testJ4<- test[test$Junction==4,]

# Features are year, month, day, hour, wday, weekend
dtrainJ4 = xgb.DMatrix(data = as.matrix(trainJ4[,c(1,2,3, 4,11,12)]), label = trainJ4$Vehicles)
dtestJ4 = xgb.DMatrix(data = as.matrix(testJ4[,c(1,2,3, 4,10,11)]))

param <- list(objective = "reg:linear",
              eval_metric = "rmse",
              max_depth = 5,
              showsd = TRUE,
              eta = 0.05,
              gamma = 0, 
              subsample = 0.8,
              colsample_bytree = 0.8, 
              min_child_weight = 1,
              set.seed = 0)
set.seed(1)
modelJ4 <- xgb.train(dtrainJ4,params = param,nrounds = 1000, verbose = 1, watchlist = list(train=dtrainJ4))

predJ4 <- predict(modelJ4, dtestJ4)
testJ4$Vehicles <- predJ4

# Combining all the predictions together for submission to csv file.
testF <- rbind(testJ1,testJ2,testJ3,testJ4)
write.csv(data.frame("ID"= testF$ID, "Vehicles" = round(testF$Vehicles)), "sub.csv", row.names = F)

# To stabilize the model for unseen data, I would like to use ensemble of both XGBoost and
## seperate models together to form the predictions.
# NOTE:: Run XGBoost and the above model beore runnning the below code.
test$Vehicles<- (test$Vehicles+testF$Vehicles)/2
write.csv(data.frame("ID"= test$ID, "Vehicles" = round(test$Vehicles)), "sub.csv", row.names = F)