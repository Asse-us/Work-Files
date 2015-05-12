mydata <- iris

# First steps

str(mydata)
summary(mydata)
names(mydata)
head(mydata)
tail(mydata)

sapply(mydata, mean, na.rm=TRUE)
# Possible functions used in sapply include mean, sd, var, min, 
# max, median, range, and quantile.

# Detour: apply family of functions

summary(mydata)
# for numerics: mean,median,25th and 75th quartiles,min,max, 
# for factors: frequency distribution

str(mydata)
# structure of the data set

# Using the Hmisc package
library(Hmisc)
describe(mydata) 
# n, nmiss, unique, mean, 5,10,25,50,75,90,95th percentiles 
# 5 lowest and 5 highest scores

library(psych)
describe(mydata)
# item name ,item number, nvalid, mean, sd, 
# median, mad, min, max, skew, kurtosis, se

library(pastecs)
stat.desc(mydata)

library(doBy)
data(mtcars)
head(mtcars)
summary(mtcars)
summaryBy(mpg + wt ~ cyl + vs, data = mtcars, 
          FUN = function(x) { c(m = mean(x), s = sd(x)) } )
# creates a summary (mean and SD) for each combination of cyl and vs
# aggregate data frame mtcars by cyl and vs, returning means
# for numeric variables

# we can also aggregate the data
attach(mtcars)
aggdata <- aggregate(mtcars, by=list(cyl,vs), FUN = function(x) { c(m = mean(x), s = sd(x)) })
aggdata$newcolumn <- aggdata$hp + aggdata$wt
aggdata$newcolumn2 <- ifelse(aggdata$wt>3,"Heavy","Light")
print(aggdata)
detach(mtcars)

# cross tabulation is very easy
table(cyl)
table(cyl,gear)
table(cyl,gear,vs==1)

xtabs(~cyl)
xtabs(~cyl+gear)
xtabs(~cyl+gear+vs)

attach(mydata)
mytable <- table(cyl,gear) # A will be rows, B will be columns 

margin.table(mytable, 1) # A frequencies (summed over B) 
margin.table(mytable, 2) # B frequencies (summed over A)
prop.table(mytable) # cell proportions
prop.table(mytable, 1) # row proportions 
prop.table(mytable, 2) # column proportions


