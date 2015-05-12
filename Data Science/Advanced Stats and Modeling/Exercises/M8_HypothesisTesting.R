############### HYPOTHESIS TESTING, PARAMETRIC AND NONPARAMETRIC TESTS
library(BSDA)
# Test of proportions
# In a sample of 100, 45 answer yes. H0 is p = 0.5, Ha is p != 0.5
prop.test(45,100,p=0.5) # high p-value: accept null hypothesis

# How do we interpret the p-value?
# The probability that the observed result, or one more extreme, occurred
# entirely due to chance
# How do we set the cutoff?

prop.test(450,1000,p=0.5)

# same proportion (0.45), but different result
# why is this?

# Test of means: t-tests and z-tests
# When to use the z-test?
# data points should be independent from each other
# z-test is preferable when n is greater than 30.
# the distributions should be normal if n is low,
# if however n>30 the distribution of the data does not have to be normal
# the variances of the samples should be known and equal (F-test)
# all individuals must be selected at random from the population
# sample sizes should be as equal as possible but some differences are allowed
# 
# When to use the t-test?
# data sets should be independent from each other 
# except in the case of the paired-sample t-test
# where n<30 the t-tests should be used
# the distributions should be normal for the equal and 
# unequal variance t-test (K-S test or Shapiro-Wilke)
# the variances of the samples should be the same (F-test)
# for the equal variance t-test
# all individuals must be selected at random from the population
# sample sizes should be as equal as possible but some differences are allowed
x <- rnorm(12)
z.test(x,sigma.x=1)
# Two-sided one-sample z-test where the assumed value for
# sigma.x is one. The null hypothesis is that the population
# mean for 'x' is zero. The alternative hypothesis states
# that it is either greater or less than zero. A confidence
# interval for the population mean will be computed.

x <- c(7.8, 6.6, 6.5, 7.4, 7.3, 7., 6.4, 7.1, 6.7, 7.6, 6.8)
y <- c(4.5, 5.4, 6.1, 6.1, 5.4, 5., 4.1, 5.5)
z.test(x, sigma.x=0.5, y, sigma.y=0.5, mu=2)
# Two-sided standard two-sample z-test 
# where both sigma.x
# and sigma.y are both assumed to equal 0.5. The null hypothesis
# is that the population mean for 'x' less that for 'y' is 2.
# The alternative hypothesis is that this difference is not 2.
# A confidence interval for the true difference will be computed.

z.test(x, sigma.x=0.5, y, sigma.y=0.5, conf.level=0.90)
# Two-sided standard two-sample z-test where both sigma.x and
# sigma.y are both assumed to equal 0.5. The null hypothesis
# is that the population mean for 'x' less that for 'y' is zero.
# The alternative hypothesis is that this difference is not
# zero.  A 90% confidence interval for the true difference will
# be computed.

data(ToothGrowth)
head(ToothGrowth)
trt1 <- ToothGrowth$len[which(ToothGrowth$supp == "VC")]
trt2 <- ToothGrowth$len[which(ToothGrowth$supp == "OJ")]
mean(trt1)
mean(trt2)
boxplot(ToothGrowth$len ~ ToothGrowth$supp, col="blue") # formula Y ~ X

# generally formula dependent (response) var ~ independent (predcitor) variable(s)

boxplot(ToothGrowth$len ~ ToothGrowth$supp, notch=TRUE, col=c("blue","green"))

# alternative formulations of the same test
t.test(trt1,trt2)

res <- t.test(ToothGrowth$len ~ ToothGrowth$supp)

if (res$p.value < 0.001) {
  sig <- "***"
} else if (res$p.value < 0.01){
  sig <- "**"
} else if (res$p.value < 0.05) {
  sig <- "*"
} else if (res$p.value < 0.1) {
  sig <- "."
} else {
  sig <- ""
}

sig.text <- paste("p-value = ", round(res$p.value,3))
text(1.5,32,sig,cex=3)
text(1.5,28,sig.text)

# test the hypothesis that mean of trt1 is 17
# alternative is that mean is greater than 17
t.test(trt1,mu=17,alternative=("greater")) # fail to reject null hypothesis


# two sample test - unpaired (default 
# is paired = FALSE)
t.test(trt1,trt2,mu=0,alternative=("two.sided"), 
       paired=FALSE, var.equal=TRUE,conf.level=0.98) #reject null hyp

# t-test for numeric data grouped by factor

x <- mtcars$mpg # mpg data from the mtcars data set: numeric
y <- mtcars$am  # transmission data: binomial factor

# null hypothesis: gas mileage of manual and automatic 
# transmissions are identically distributed

t.test(x ~ y) # reject the null hypothesis
# note that a nonparamteric test may be more appropriate here (see below)

# two-sample test (paired)
# scores given to a set of ten exams by two different scorers
# is there a significant difference in mean score from each scorer?
x = c(3,0,5,2,5,5,5,4,4,5)
y = c(2,1,4,1,4,3,3,2,3,5)
t.test(x,y,paired=TRUE)

# Exercises
# [1]
# Using the iris data set test whether each pair of species differs in 
# each of the four measured variables
# create a boxplot of each variable grouped by species
# indicate significant differences on the plots

# [2]
# Use the data set state.x77
# load it using x <- data.frame(state.x77)
# create a new column (variable) called size
# this should take the value "Large" or "Small"
# depending on the area (you can choose the cutoff 
# after inspecting the distribution of area)
# test for differences between small and large states
# in the various attributes measured

# test of variances (F-test)
# null hypothesis is that variances of equal
# or more specifically that the ratio of variances is one

var.test(trt1,trt2,ratio=1,alternative=("two.sided")) 
#accept the null hypothesis

# test of association
# example taken from R documentation

M <- as.table(rbind(c(762, 327, 468), c(484, 239, 477)))
dimnames(M) <- list(gender = c("M","F"),
                    party = c("Democrat","Independent", "Republican"))
chisq.test(M)
Xsq <- chisq.test(M)  # Prints test summary
Xsq$observed   # observed counts (same as M)
Xsq$expected   # expected counts under the null
Xsq$residuals  # Pearson residuals
Xsq$stdres     # standardized residuals

# The most frequent letters  E,T,N,R,O appear at relative frequencies 
# of approximately  29,21,17,17,16. That is when either E,T,N,R,O appear, 
# on average 29 times out of 100 it is an E 
# on average 21 times out of 100 it is a T etc.
# A given piece text has the letters 100,110,80,55,14 times respectively
# Are the proportions the same as the average for all English text?
x = c(100,110,80,55,14)
probs = c(29, 21, 17, 17, 16)/100
chisq.test(x,p=probs)
# note we are assuming independence of appearance of the letters
# in reality we may want to think about this assumption

# sign test
# or exact test or Fisher's test
# in a survey of 27 people, 7 prefer brand A, the rest brand B
# are the two brands equally popular?
binom.test(7, 27) # reject the hypothesis that both are equally popular
binom.test(70, 270)

############################################################
# Non-parametric hypothesis tests

# Wilcoxon signed-rank test
library(MASS)
head(immer) 

# barley yield: 5 varieties at six locations, two years 1931 and 1932
# do the yields in the two years have the same distribution?
# without assuming anything about the distribution
# null hypothesis: the two sample years are identical populations

wilcox.test(immer$Y1, immer$Y2, paired=TRUE) # reject null hypothesis

# Mann-Whitney-Wilcoxon Test or Mann-Whitney U test
x <- mtcars$mpg # mpg data from the mtcars data set: numeric
y <- mtcars$am  # transmission data: binomial factor
# null hypothesis: gas mileage of manual and automatic 
# transmissions are identically distributed
wilcox.test(x ~ y) # reject the null hypothesis

# Kruskal-Wallis Test
# air quality measurements in New York from May to September 1973
# does the ozone level have an identical distribution from May to September?
# null hypothesis is that they are identically distributed

data(airquality)
head(airquality)
kruskal.test(Ozone ~ Month, data = airquality) # reject the null hypothesis
