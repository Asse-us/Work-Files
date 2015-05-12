# 
# UNIVARIATE PLOTS
#
##################################################################33
# Examining your data visually
# simple visual summaries of the data are often very informative

# use univariate plots to examine the distribution of one variable at a time

# dotplots
# The dot plot is a simple but effective 
# way of communicating information. It is essentially a 1D plot 
# that displays quantitative values along a (usually) continuous 
# scale with a label for each data point.
head(mtcars)
str(mtcars)
summary(mtcars)

dotchart(mtcars$mpg,labels=row.names(mtcars),
         cex=0.7,main="Gas Milage for Car Models",
         xlab="Miles Per Gallon")

# The data can be sorted by the continuous variable to make comparisons easier:
x <- mtcars[order(mtcars$mpg),] # sort by mpg
dotchart(x$mpg,labels=row.names(x),cex=.7,
         main="Gas Milage for Car Models", 
         xlab="Miles Per Gallon")

# Further, the data can be grouped according to 
# some factor (here cylinder, cyl) and the different 
# groups assigned different colours:
x <- mtcars[order(mtcars$mpg),] # sort by mpg
x$cyl <- as.factor(x$cyl)
x$color[x$cyl==4] <- "red"
x$color[x$cyl==6] <- "blue"
x$color[x$cyl==8] <- "darkgreen"  
x$shape[x$cyl==4] <- 16
x$shape[x$cyl==6] <- 18
x$shape[x$cyl==8] <- 20

dotchart(x$mpg,labels=row.names(x),cex=0.7,
         pch=x$shape,
         groups= x$cyl,
         main="Gas Milage for Car Models\ngrouped by cylinder",
         xlab="Miles Per Gallon", 
         gcolor="pink", color=x$color)


# stripcharts
# A more basic variant of the dotplot is the stripchart.
# It simply plots all the data points along a single axis 
# according to their value.
stripchart(mtcars$mpg,pch=19,cex=0.8)

# As such, there is no way to know how many points are overlaid 
# at any given position along the axis. We can use the “jitter” 
# function to get an idea of this. This adds some random artificial 
# noise along the (non-existent) vertical axis:
stripchart(mtcars$mpg,pch=19,
           cex=0.8,method="jitter")

# Neither very pretty, nor very pleasing in terms of information 
# content. A better alternative is method=“stack”:
stripchart(mtcars$mpg,
           pch=19,cex=0.8,method="stack")

# boxplots and variants
#A simple univariate plot of tooth length for the whole data set
attach(ToothGrowth)
summary(ToothGrowth)
boxplot(len)

# Tooth length by supplement (a factor with two levels)
boxplot(len~supp)

# Adding notches and some colour. If the notches do not overlap 
# (as in this case), it is “strong evidence” that the medians 
# of the two groups differ (this is not a formal statistical test).
boxplot(len~supp,col=c("green","blue"),
        notch=TRUE,xlab="Supplement",ylab="Length (mm)")
plot(supp,len,col=c("orange","yellow"),
        notch=TRUE,xlab="Supplement",ylab="Length (mm)")

# interpreting a boxplot
# D:\Training\BasicR\boxplot.png

library(gplots)
boxplot2(len~supp,col=c("green","blue"),
         notch=TRUE) 

library(robustbase)
adjbox(len~supp)
# deals with skewed distributions better than boxplot
# accounts for skewness and kurtosis when computing the whiskers
# the box (Q1-Q2-Q3) is the same as in boxplot()

# Boxplot variations 
# Violin plot 
# A combination of boxplot and a kernel density plot
library(vioplot)
x1 <- ToothGrowth$len[ToothGrowth$supp=="OJ"]
x2 <- ToothGrowth$len[ToothGrowth$supp=="VC"]
vioplot(x1,x2,names=c("OJ","VC"),col="orange")

# Bean plot 
# A combination of a violin plot and a "rug"
library(beanplot)
data(mtcars)
beanplot(mtcars[c(1,5,6,7)])

# Pie charts
# A simple pie chart
slices <- c(24, 16, 13, 21, 18)
lbls <- c("Chennai", "Mumbai", "Delhi", "Bangalore", "Kolkata")
pie(slices, labels = lbls, main="Pie chart for cities")

# Same thing, but with percentages and some colours:
slices <- c(24, 16, 13, 21, 18)
lbls <- c("Chennai", "Mumbai", "Delhi", 
          "Bangalore", "Kolkata")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # add % to labels 
pie(slices,labels = lbls, 
    col=rainbow(length(lbls)),
    main="Pie chart with percentages")

# Appended sample sizes to labels
mytable <- table(iris$Species)
lbls <- paste(names(mytable), "\n", 
              mytable, sep="")
pie(mytable, labels = lbls, main="Pie Chart of Species\n (with sample sizes)")

# 3D exploded pie chart
library(plotrix)
slices <- c(24, 16, 13, 21, 18)
lbls <- c("Chennai", "Mumbai", "Delhi", "Bangalore", "Kolkata")
pie3D(slices,labels=lbls,explode=0.1,main="Exploded 3D pie chart ")

# histograms, density plots and bar plots 
# histograms
# A simple histogram for mpg data from mtcars:
hist(mtcars$mpg)

# We will use the diamonds dataset from the mgcv package. 
# For some examples, we will use dsmall, a smaller subset 
# of diamonds, containing 100 observations, or dmedium, 
# a subset containing 5000 observations.
library(ggplot2)
library(mgcv)
data(diamonds)
dsmall<-diamonds[sample(nrow(diamonds),100),]
dmedium<-diamonds[sample(nrow(diamonds),5000),]

hist(dmedium$carat)

# We can set the number of bins with breaks = :
hist(dmedium$carat,breaks=10)
hist(dmedium$carat,breaks=20)
hist(dmedium$carat,breaks=30)

# This is illustrates a problem with histograms: 
# they can be poor indicators of the shape of the 
# underlying distribution. Here are the same three 
# histograms but this time with a normal distribution 
# (having the same mean and variance as the data) superimposed:
x <- dmedium$carat 
h <- hist(x, col="red", xlab="Carat", main="Histogram with Normal Curve") 
xfit <- seq(min(x),max(x),length=40) 
yfit <- dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="blue", lwd=2)

h <- hist(x, breaks=10, col="red", xlab="Carats", main="Histogram with Normal Curve") 
xfit <- seq(min(x),max(x),length=40) 
yfit <- dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="blue", lwd=2)

h <- hist(x, breaks=20, col="red", xlab="Carats", main="Histogram with Normal Curve") 
xfit <- seq(min(x),max(x),length=40) 
yfit <- dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="blue", lwd=2)

h <- hist(x, breaks=30, col="red", xlab="Carats", main="Histogram with Normal Curve") 
xfit <- seq(min(x),max(x),length=40) 
yfit <- dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="blue", lwd=2)

# A density plot is a better way to display the distribution 
# of the data than a histogram.
plot(density(dmedium$carat),
     main="Density plot for carat")

# We can also add a rug below the density plot, showing each actual data value
plot(density(dmedium$carat),main="Density plot for carat")
rug(dmedium$carat)

# The plot can be filled using polygon()
d <- density(dmedium$carat)
plot(d,main="Density plot for carat")
polygon(d,border="darkblue",col="orange")

# Comparing the distributions of subgroups, 
# using the sm.density funciton from package sm:
library(sm)
# First create value labels for the factor:
cut.f <- factor(dmedium$cut, 
                levels= c("Fair","Good","Very Good","Premium","Ideal"),
                labels = c("Fair","Good","Very Good","Premium","Ideal")) 

# Then plot the densities by cut:
sm.density.compare(dmedium$carat, dmedium$cut, xlab="Carat")
title(main="Carat distribution by cut")
colfill <- c(2:(2+length(levels(cut.f)))) 
legend("topright",levels(cut.f), fill=colfill)

# we can achieve this more easily, and produce a 
# better looking graph, using ggplot2 instead - later

# Bar plots 
# A bar plot is the discrete equivalent of a histogram.
# Here is a simple bar plot of the diamond data, showing 
# the number of diamonds in each category of color.
t1 <- table(dmedium$color)
barplot(t1,main="Distribution of color",xlab="Colour",col="orange")

# We can make it horizontal with horiz = TRUE
t2 <- table(dmedium$cut)
barplot(t2,horiz=TRUE,
        main="Distribution of color",
        xlab="Colour",
        col="lightgreen")

# We can make text vertical to the axis and
# increase the left margin to make it look better
par(las=2,mar=c(5,8,4,2))
barplot(t2,horiz=TRUE,
        main="Distribution of color",
        xlab="Colour",
        col="lightgreen")

# We can break down the observations in each category
# of the grouping variable by a second grouping variable,
# and show the result as a stacked bar plot:
counts <- table(dmedium$cut, dmedium$color)
collist <- rainbow(length(levels(dmedium$cut)))
barplot(counts, main="Diamond distribution by cut and color",
        xlab="Color", 
        col=collist,
        legend = rownames(counts))
# or a grouped bar plot:
barplot(counts, main="Diamond distribution by cut and color",
        xlab="Color",
        col=collist,
        legend = rownames(counts),
        beside=TRUE)

