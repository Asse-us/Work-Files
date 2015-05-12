setwd("")
#############################################
# Example 1: Credit card default data       #
# This data set is part of the ISLR package #
#############################################
##########################################################
# Logistic Regression
# Data: Credit card default, 10000 obs, 4 variables
# This data set is part of the ISLR package
#########################################################
library(ISLR)
library(MASS)
attach(Default)
write.csv(Default,"default.csv")
?Default
summary(Default)
# Build a simple logistic regression model
# What hypothesis are we testing here?

model.1 <- glm(default ~ income, data=Default,
               family=binomial())

summary(model.1)
model.1.pred.prob <- predict(model.1,type="response")
plot(model.1.pred.prob,default)
plot(model.1.pred.prob,jitter(as.numeric(default)))
plot(model.1.pred.prob,jitter(as.numeric(default)),xlim=c(0,1))

# Split data
# We set the seed for the pseudo-RNG so we get the same result every time

set.seed(123123)
sub <- sample(nrow(Default), floor(nrow(Default) * 0.6))

# We have created a 60:40 split between training:validation
# try this out with different sized splits to see how it affects the results

training_data <- Default[sub,]
validation_data <- Default[-sub,]

# Build a multiple regression model

model.stock <- glm(default ~ .,data=training_data,
                   family=binomial())

summary(model.stock)

model.stock.pred.prob <- 
  predict(model.stock,
          type="response")
plot(model.stock.pred.prob,jitter(as.numeric(training_data$default)))

model.stock.pred.prob1 <- 
  predict(model.stock)
          

model.step <- stepAIC(model.stock)
summary(model.step)

# Predict on training and validation files
training_data$pred.prob <- 
  predict(model.step,type="response") 
validation_data$pred.prob <- 
  predict(model.step,type="response",
          newdata=validation_data) 
library(plyr)
training_data <- arrange(training_data,-pred.prob)
par(mfrow=c(2,1))
plot(training_data$pred.prob,jitter(as.numeric(training_data$default)))
plot(validation_data$pred.prob,jitter(as.numeric(validation_data$default)))

# Confusion matrix a.k.a. error matrix a.k.a. contingency table

training_data$class <- 
  ifelse(training_data$pred.prob>0.2,1,0)
validation_data$class <- 
  ifelse(validation_data$pred.prob>0.2,1,0)
table(training_data$default,training_data$class)
table(validation_data$default,validation_data$class)
# why choose 0.05? Try other values...

# Receiver Operator Characteristic (ROC)
# Area under the ROC curve is a measure of how well the model fits
# The closer the area is to unity, the better the model fits
# Area = 1 means the model is a perfect classifier
# Area = 0.5 means that the model does no better than random(e.g. coin toss)
# The curve should rapidly approach and asymptote at 1

library(ROCR)
train_pred <- prediction(training_data$pred.prob, training_data$default)
train_perf <- performance(train_pred, measure = "tpr", x.measure = "fpr") 
plot(train_perf, col=rainbow(5))
val_pred <- prediction(validation_data$pred.prob, validation_data$default)
val_perf <- performance(val_pred, measure = "tpr", x.measure = "fpr") 
plot(val_perf, col=rainbow(10))

# Another way to check error
# bootstrapping method
# Leave-one-out cross validation

library(boot)
cv.err <- cv.glm(validation_data, model.step)
err <- cv.err[[3]][2]
err <- round(err*100,2)
# prederr <- paste(c("Prediction error (cross-validation): ",as.character(err),"%"),collapse="")
# mtext(prederr,1,line=4,cex=0.9,col="blue")

#########################################################################
# Example 2: Cedegren data on final 's' deletion in Panamaniana Spanish #
#########################################################################
library(dplyr)
library(vcd)
ced <- read.csv("cedegren.txt")
head(ced)
str(ced)
cat.t <- ced %>% 
  group_by(cat) %>%
  summarize("sDel"=sum(sDel),"sNoDel"=sum(sNoDel))
cat.t$propsDel <- with(cat.t, sDel/(sDel+sNoDel))
# OR
# cat.t <- aggregate(ced[,c("sDel","sNoDel")], by=list(cat=ced$cat), FUN=sum)
# Test of association
chisq.test(cat.t[,c('sDel','sNoDel')])
# tells us that sDel is not independent of cat

follows.t <- ced %>% 
  group_by(follows) %>%
  summarize("sDel"=sum(sDel),"sNoDel"=sum(sNoDel))
follows.t$propsDel <- with(follows.t, sDel/(sDel+sNoDel))
chisq.test(follows.t[,c('sDel','sNoDel')])

class.t <- ced %>% 
  group_by(class) %>%
  summarize("sDel"=sum(sDel),"sNoDel"=sum(sNoDel))
class.t$propsDel <- with(class.t, sDel/(sDel+sNoDel))
chisq.test(class.t[,c('sDel','sNoDel')])

attach(ced)
cdel <- cbind(sDel,sNoDel) 
# can use this matrix as the "response variable"
# the first column represents the case response var = 1
# the second column represents the case response var = 0

cl1 <- glm(cdel ~ cat + follows + factor(class), family="binomial")
summary(cl1)

########## alternatively we can use the long form data

cedl <- read.table("cedegren-long.txt",header=T)
head(cedl)
str(cedl)

cedl$sDel <- factor(cedl$sDel)
cedl$class <- factor(cedl$class)

cat.t <- with(cedl, table(sDel, cat))
assocstats(cat.t)

follows.t <- with(cedl, table(sDel, follows))
assocstats(follows.t)

class.t <- with(cedl, table(sDel, class))
assocstats(class.t)

gm1 <- glm(sDel ~ ., data=cedl, family="binomial")
summary(gm1)
hist(gm1$residuals)

# Based on the table, levels a and d for var cat can be clubbed
cedl$cat <- as.character(cedl$cat)
cedl$cat[cedl$cat %in% c("a","d")] <- "ad"
cedl$cat <- factor(cedl$cat)
str(cedl)

gm2 <- glm(sDel ~ ., data=cedl, family="binomial")
summary(gm2)

pm2 <- predict(gm2) # log odds
pm2 <- predict(gm2,type="response") #probabilities
cedl$pred <- predict(gm2,type="response") #probabilities
plot(cedl$pred,jitter(as.numeric(cedl$sDel)))
str(cedl)

# checking model fit
# Somer's D
somers2(y=as.integer(as.character(cedl$sDel)),x=pm2)

# Somer’s D is a Proportional Reduction in Error (PRE) 
# measure so it is interpreted as the improvemen-t in 
# predicting the dependent variable that can be attributed 
# to knowing a case’s value for the independent variable.
