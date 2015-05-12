setwd("D:/Training/AdvancedAnalytics")
##################################
# Example 1: Real estate dataset #
##################################
library(car)
library(MASS)
house_prices <- read.csv(file="House_Prices.csv")
names(house_prices)
str(house_prices) 
summary(house_prices)

attach(house_prices)

# First build a simple linear regression model for Price vs Square feet

lm.1 <- lm(Price ~ SqFt, data=house_prices)
summary(lm.1)

plot(SqFt, Price, main="Scatter plot", xlab="Square feet", ylab="Price")
abline(lm.1,col="blue",lwd=3,lty=3) # least squared method

# Prepare data and split
# Create dummy variables
house_prices$brick_d <- ifelse(house_prices$Brick=="Yes",1,0)
house_prices$east <- ifelse(house_prices$Neighborhood=="East",1,0)
house_prices$north <- ifelse(house_prices$Neighborhood=="North",1,0)

# for a factor variable with N levels, we have to create N-1 dummies

# Split your dataset
# Why do we do this?

set.seed(110)
sub <- sample(nrow(house_prices), floor(nrow(house_prices) * 0.6))
training_data <- house_prices[sub,]
validation_data <- house_prices[-sub,]


# Build multiple regression model
# Build model with all variables 

lm.fit1 <- lm(Price ~ SqFt+Bathrooms+Bedrooms+
                Offers+north+east+brick_d, data=training_data)
summary(lm.fit1)

lm.fit2 <- lm(Price ~ SqFt+Bathrooms+Bedrooms+
                Offers+north+east+brick_d+Offer_c+SqFt_c, data=training_data)
summary(lm.fit2)


lm.fit3 <- lm(Price ~ Bathrooms+Bedrooms+
                north+east+brick_d+Offer_c+SqFt_c, data=training_data)
summary(lm.fit3)

# Using stepwise regression , we reduce variables if possible
# AIC = Akaike Information Criterion
# a statistic for comparing models

lm.fit1.step <- stepAIC(lm.fit1)
summary(lm.fit1.step)

# Check for multicollinearity
# Multicollinearity: a high degree of correlation between predictor variables
# Variance Inflation Factor
# General rule of thumb: VIF should be less than 10

vif(lm.fit1)

# Predict values on training and validation data sets
# Predict values on training set

training_data$predict.price <- predict(lm.fit1)
training_data$error <- residuals(lm.fit1)

plot(training_data$predict.price,training_data$error,pch=19)
abline(h=0,lwd=3)
hist(training_data$error)
plot(training_data$Price,training_data$predict.price)
# Predict values on validation set
validation_data$predict.price <- 
  predict(lm.fit1,newdata=validation_data)
validation_data$error <- 
  validation_data$predict.price - validation_data$Price
plot(validation_data$predict.price,validation_data$error)
abline(h=0,lwd=3)
hist(validation_data$error)

# Check residual plots
hist(training_data$error)
hist(validation_data$error)

# Correlation
a <- cor(training_data$Price,training_data$predict.price)
b <- cor(validation_data$Price,validation_data$predict.price)
a*a
b*b
#############################
# Example 2: mtcars dataset #
#############################
library(robustbase)
adjbox(mpg~gear, data=mtcars)
mtcars <- within(mtcars, {
  cyl <- factor(cyl, ordered=T)
  am <- factor(am)
  gear <- factor(gear, ordered=T)
  vs <- factor(vs)
  carb <- factor(carb,ordered=T)
})
str(mtcars)
plot(mpg~disp, data=mtcars)
plot(mtcars)
cor(mtcars$mpg,mtcars$wt) # with(mtcars,cor(mpg,wt))
m1 <- lm(mpg ~ wt, data=mtcars)
summary(m1)
plot(mtcars$wt,mtcars$mpg)
abline(m1)

names(m1)
m1$coefficients
m1$residuals
m1$fitted
summary((mtcars$mpg - m1$fitted)-m1$residuals) # difference is not EXACTLY zero
all.equal((mtcars$mpg - m1$fitted),m1$residuals) # 
m1$assign # 
m1$df.residual # number of DF of the residuals (~ N(obs) - N(parameters estimated))
m1$terms
m1$model

# Null model
m0 <- mean(mtcars$mpg)
m0residuals <- mtcars$mpg - m0
par(mfrow=c(2,1))
hist(m0residuals, xlim=c(-20,20))
hist(m1$residuals,xlim=c(-20,20))
# The F statistic is a formal comparison of these two models
# using the variances of the residuals

m2 <- lm(mpg ~ wt+disp, data=mtcars) 
summary(m2)

m3 <- lm(mpg ~ wt+disp+hp, data=mtcars) 
summary(m3)

m4 <- lm(mpg ~ wt + disp + I(disp^2),data=mtcars) 
# this uses disp^2 as a term
# not giving the I() would treat disp^2 as the interaction term of disp with itself

cor(mtcars[,c("mpg","wt","disp","hp")])

plot(mtcars[,c('mpg','wt','disp','hp')])
df <- data.frame(r1=m1$residuals, mtcars[,c("wt","disp","hp")])
# check if mpg is correlated with disp and hp after 
# taking out the effect of wt
cor(df)
plot(df)

m2 <- lm(mpg ~ wt+disp, data=mtcars)
summary(m2)

m4 <- lm(mpg ~ wt+hp, data=mtcars)
summary(m4)

# comparing two models
anova(m2,m1) 
# tells us significance of the difference
# the one with lower RSS is better
# if difference not significant, 
# use model with fewer parameters (parsimony principle)
anova(m4,m1)
anova(m4,m2) # won't work for two models with same DF
AIC(m4)
AIC(m2)
# gives us an idea but is not a TEST

m4 <- lm(mpg ~ wt + am, data=mtcars)
summary(m4)

mtcars$cyl <- factor(as.character(mtcars$cyl))
m4 <- lm(mpg ~ wt+cyl, data=mtcars)
summary(m4)

anova(m4)
# In this case tells us that cyl is significant
par(mfrow=c(2,2))
plot(m1)
# 1,1: checking if residuals are larger (smaller) as 
# fitted values get larger (smaller)
### non-linear relationship here can indicate heteroscedasticity
# non-constant residuals may be addressed with transformation of dependent var
# 1,2: checking if residuals are normally distributed
# 1,3: basically similar to 1,1 but uses standardized residuals 
# (to have mean 0 & SD 1) and sqrt(abs())
### 1,4: influence of extreme points (leverage points)
# might be addressed with transformation of independent variable
par(mfrow=c(2,2))
plot(m4)

m5 <- lm(mpg ~ wt+cyl+am, data= mtcars)
summary(m5)
par(mfrow=c(2,2))
plot(m5)

m6 <- lm(mpg ~ wt + cyl * am, data= mtcars)
summary(m6)
# * gives each individual effectand the interaction effect
# : gives ONLY the interaction (rarely used)

library(car)
vif(m6)

# Cutoff variously 3,4,6,10
ma <- lm(mpg~.,data=mtcars)
summary(ma)
s.ma <- stepAIC(ma)
summary(s.ma)

