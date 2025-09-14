install.packages('ROCR')

library(caTools)
library(tree)
library(ROCR)

getwd()
setwd("C:\\Users\\nikhi\\Desktop\\MSc DS\\2-Statistical Machine learning\\project")

df <- read.csv("Rice_Osmancik_Cammeo_Dataset.csv",header = TRUE)

sample_data = sample.split(df, SplitRatio = 0.8)
train <- subset(df, sample_data == TRUE)
test <- subset(df, sample_data == FALSE)

library(caret)
# control parameters Cross-Validated (10 fold) 
cv <- trainControl(method = "cv", classProbs = TRUE)

set.seed(2345)
# fitting decision tree classification model
model <- train(CLASS ~ ., 
                 data = train, 
                 method = "rpart",
                 metric = "Accuracy",
                 parms  = list(split = "gini"), 
                 trControl = cv)

# model summary
model

model1 <- train(CLASS ~ ., 
                 data = train, 
                 method = "rpart",
                 metric = "Accuracy",
                 parms  = list(split = "entropy"), 
                 trControl = cv)

# model summary
model1

library(rpart.plot)
prp(model$finalModel, box.palette = "Reds", tweak = 1.2, varlen = 20)


# plotting variable importance
plot(varImp(model))

# predicting the model on test data set
pred <- predict(model,test, type = "prob")
dim(pred)
# plot of probabilities

plot(pred$Cammeo, 
     main = "Scatterplot of Probabilities of CLASS (test data)", 
     ylab = "Predicted Probability of CLASS")


# taking the cut-off probability 50%
pred.DT <- ifelse(pred$Cammeo > 0.50, "Cammeo", "Osmancik")
# saving predicted vector as factor 
Pred <- as.factor(pred.DT)

# ordering the vectors
Predicted <- ordered(Pred, levels = c("Cammeo", "Osmancik"))
Actual <- ordered(test$CLASS,levels = c("Cammeo", "Osmancik"))

# making confusion matrix
cm <-confusionMatrix(table(Predicted,Actual))
cm



# loading the package
library(ROCR)

DTPrediction <- predict(model, test,type = "prob")
Prediction <- prediction(DTPrediction[2],test$CLASS)
performance <- performance(Prediction, "tpr","fpr")
# plotting ROC curve
plot(performance,main = "ROC Curve",col = 2,lwd = 2)
abline(a = 0,b = 1,lwd = 2,lty = 3,col = "black")

DTPrediction <- predict(model, test,type = "prob")
Prediction <- prediction(DTPrediction[2],test$CLASS)
aucDT <- performance(Prediction, measure = "auc")
aucDT <- aucDT@y.values[[1]]
aucDT


