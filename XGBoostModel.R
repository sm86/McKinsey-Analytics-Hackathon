library(xgboost)

# 2015 year seems to have many disturbances, uncomment to remove it.
# train <- train[ train$year != "2015", ]

# Features are year, month, hour, Junction, Weekday, weekend.
# Converting into xgb.Matrix for XGBoost model
dtrain = xgb.DMatrix(data = as.matrix(train[,c(1,2, 4, 7,11,12)]), label = train$Vehicles)
dtest = xgb.DMatrix(data = as.matrix(test[,c(1,2,4, 7,10,11)]))

# Linear model
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

modelf <- xgb.train(dtrain,params = param,nrounds = 650, verbose = 1, watchlist = list(train=dtrain))

pred <- predict(modelf, dtest)
test$Vehicles <- pred

# CSV output file
write.csv(data.frame("ID"= test$ID, "Vehicles" = round(test$Vehicles)), "sub.csv", row.names = F)