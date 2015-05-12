#
# BIVARIATE PLOTS
#
# examining the relationship between variables

# Bag plot 
# A bagplot is a 2D extension of a boxplot. 
# The bag contains 50% of all points. 
# The bivariate median is approximated. 
# The fence separates points in the fence 
# from points outside. 
# Outliers are displayed. Taken from Quick-R.
library(aplpack)
attach(mtcars)
bagplot(wt,mpg,
        xlab="Car Weight", 
        ylab="Miles Per Gallon",
        main="Bagplot Example")

# base R's plot() function is a generic function
# which means it is context sensitive
# actually, technically, it is overloaded
# this makes it very versatile
# the type of graph plotted is determined by the form of the data
# as shown in the following examples
help(faithful)
data(faithful)
attach(faithful)
names(faithful)
plot(faithful)
plot(waiting,eruptions,pch=19,col="darkblue") #numeric, numeric = scatterplot
abline(lm(formula=eruptions~waiting,
          data=faithful),col='blue',lwd=3)
detach(faithful)
rm(faithful)

help(ToothGrowth)
data(ToothGrowth)
attach(ToothGrowth)
names(ToothGrowth)
head(ToothGrowth,25)
plot(supp,len) # factor, numeric = boxplot
boxplot(len~supp,col="blue")
boxplot(len~supp,col="blue",notch=TRUE)
plot(dose,len)
plot(factor(dose), len) # coercing dose to a factor
boxplot(len~factor(dose),notch=T)
detach(ToothGrowth)
rm(ToothGrowth)

help(sunspots)

data(sunspots)
head(sunspots)
class(sunspots)
par(cex.axis = 1.5, cex.lab=1.5,mar=c(6,5,2,2))
plot(sunspots, col=rgb(0.3,0.3,0.3))
# time series = time-series plot
rm(sunspots)                

help(UCBAdmissions)
data(UCBAdmissions)
class(UCBAdmissions)

plot(UCBAdmissions,col="blue")  # table = mosaic plot
rm(UCBAdmissions)

help(mtcars)
data(mtcars)
head(mtcars)
str(mtcars)
plot(mtcars) # dataframe of numerics = scatterplot matrix
rm(mtcars)

help(chickwts)                  
data(chickwts)
str(chickwts)
attach(chickwts)
plot(feed, weight,col="blue",xaxt='n')
axis(1,c(1:6),labels=c("A","B","C","D","E","F"))
plot(feed, weight,col="red",notch=T)
detach(chickwts)

data(mammals, package="MASS")
str(mammals)
attach(mammals)
plot(body,brain,col=rgb(0,0,0,0.5),
     pch=16,cex=1.2,
     main="Relationship between body mass and brain mass for 62 mammals",
     xlab="Body mass (kg)",
     ylab="Brain mass(g)")
plot(log(body), log(brain))
scatter.smooth(log(body), log(brain))
detach(mammals)


### slightly more advanced plotting

# 4 figures arranged in 2 rows and 2 columns
attach(mtcars)
par(mfrow=c(2,2))
plot(wt,mpg, col=as.numeric(am)+1,
     main="Scatterplot of wt vs mpg",
     pch=19)
colList <- ifelse(am==0,"black","blue")
plot(wt,mpg, col=colList,main="Scatterplot of wt vs mpg",pch=19)
text(4.5,20,"Text1",cex=0.8)
text(4.5,30,"Text2",cex=1.8,col="blue")
mtext("margin text", side=2, line=2)
mtext("subheading example",3,line=0.75)
plot(wt,disp, main="Scatterplot of wt vs disp")
hist(wt, main="Histogram of wt")
# boxplot(wt, main="Boxplot of wt")

# 3 figures arranged in 3 rows and 1 column
par(mfrow=c(3,1)) 
hist(wt)
hist(mpg)
hist(disp)

# One figure in row 1 and two figures in row 2
layout(matrix(c(1,1,2,3),nrow=2,ncol=2,byrow=TRUE))
hist(wt)
hist(mpg)
hist(disp)

# One figure in row 1 and two figures in row 2
# row 1 is 1/3 the height of row 2
# column 2 is 1/4 the width of the column 1 
attach(mtcars)
layout(matrix(c(1,1,2,3),2,2,byrow=TRUE),
       widths=c(3,1),heights=c(1,2))
hist(wt)
hist(mpg)
hist(disp)

# Add boxplots to a scatterplot
par(fig=c(0,0.8,0,0.8),new=TRUE)
plot(mtcars$wt,mtcars$mpg,xlab="Miles Per Gallon",
     ylab="Car Weight")
par(fig=c(0,0.8,0.55,1),new=TRUE)
boxplot(mtcars$wt,horizontal=TRUE,axes=FALSE)
par(fig=c(0.65,1,0,0.8),new=TRUE)
boxplot(mtcars$mpg,axes=FALSE)
mtext("Enhanced Scatterplot",side=3,outer=TRUE,
      line=-3)

# To understand this graph, think of the full graph area as going from (0,0) 
# in the lower left corner to (1,1) in the upper right corner. 
# The "fig = " parameter is a numerical vector of the form 
# c(x1, x2, y1, y2). The first fig = sets up the scatterplot going from 
# 0 to 0.8 on the x axis and 0 to 0.8 on the y axis. The top boxplot goes 
# from 0 to 0.8 on the x axis and 0.55 to 1 on the y axis. I chose 0.55 
# rather than 0.8 so that the top figure will be pulled closer to the 
# scatter plot. The right hand boxplot goes from 0.65 to 1 on the x axis 
# and 0 to 0.8 on the y axis. Again, I chose a value to pull the right hand 
# boxplot closer to the scatterplot. You have to experiment to get it just right.

plot.new()
par(fig=c(0,0.8,0,0.8),new=TRUE)
hist(mtcars$mpg,xlab="Miles Per Gallon")
par(fig=c(0,0.8,0.55,1),new=TRUE)
boxplot(mtcars$mpg,horizontal=TRUE)
par(fig=c(0.65,1,0,0.8),new=TRUE)
boxplot(mtcars$wt)


# plots using the lattice package
# Lattice Examples 
library(lattice) 
attach(mtcars)
# create factors with value labels
gear.f<-factor(gear,levels=c(3,4,5),labels=c("3gears","4gears","5gears"))
cyl.f<-factor(cyl,levels=c(4,6,8),labels=c("4cyl","6cyl","8cyl"))
# kernel density plot
densityplot(~mpg,main="Density Plot",xlab="Miles per gallon")
# kernel density plots by factor level
densityplot(~mpg|cyl.f,main="Density Plot by Number of Cylinders",
            xlab="Miles per Gallon")
# kernel density plots by factor level (alternate layout)
densityplot(~mpg|cyl.f,main="Density Plot by Numer of Cylinders",
            xlab="Miles per Gallon",layout=c(1,3))
# boxplots for each combination of two factors
bwplot(cyl.f~mpg|gear.f,ylab="Cylinders",
       xlab="Miles per Gallon",main="Mileage by cylinders and gears",layout=(c(1,3)))
# scatterplots for each combination of two factors
xyplot(mpg~wt|cyl.f*gear.f, main="Scatterplots by cylinders and gears", ylab="Miles per gallon", xlab="Car Weight")
# 3d scatterplot by factor level
cloud(mpg~wt*qsec|cyl.f,main="3D scatterplot by cylinders") 
# dotplot for each combination of two factors
dotplot(cyl.f~mpg|gear.f, main="Dotplot by number of gears and cylinders",xlab="Miles per gallon")
# scatterplot matrix
splom(mtcars[c(1,3,4,5,6)],main="MTCARS Data")

# Correlograms
library(corrgram)
corrgram(mtcars, order=TRUE,lower.panel=panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt,
         main="Car Milage Data in PC2/PC1 Order")

# More ways of representing the same information
corrgram(mtcars, order=TRUE, lower.panel=panel.ellipse,
         upper.panel=panel.pts, text.panel=panel.txt,
         diag.panel=panel.minmax, 
         main="Car Milage Data in PC2/PC1 Order")

# Too much info! Let's make life a little simpler:
corrgram(mtcars, order=NULL, lower.panel=panel.shade,
         upper.panel=NULL, text.panel=panel.txt,
         main="Car Milage Data (unsorted)")

# Changing colours
col.corrgram <- function(ncol){   
  colorRampPalette(c("darkgoldenrod4", "burlywood1",
                     "darkkhaki", "darkgreen"))(ncol)
} 
corrgram(mtcars, order=TRUE, lower.panel=panel.shade, 
         upper.panel=panel.pie, text.panel=panel.txt, 
         main="Correlogram of Car Mileage Data (PC2/PC1 Order)",
         col=col.corrgram)

corrgram(mtcars)
plot(mtcars)

# ggplot2 examples
# Grammar of graphics

library(ggplot2)
library(mgcv)
data(diamonds)
dsmall <- diamonds[sample(nrow(diamonds),100),]
dmed <- diamonds[sample(nrow(diamonds),5000),]
dmed <- dmed[dmed$color %in% c("D","E","F","G"),]
qplot(carat,price,data=dsmall,
      geom=c("point","smooth"))
qplot(carat,price,data=diamonds,geom=c("point","smooth"),
      method="gam",formula=y~s(x))
qplot(color,price/carat,
      data=diamonds,geom="point")
qplot(color,price/carat,
      data=diamonds,geom="jitter")
qplot(color,price/carat,
      data=diamonds,geom="jitter",
      alpha=I(1/25)) #transparency      
qplot(color,price/carat,
      data=diamonds,geom="boxplot")
qplot(carat,data=diamonds,
      geom="histogram",fill=color)

qplot(date,unemploy/pop,
      data=economics,geom="line")
qplot(date,uempmed,
      data=economics,geom="line")
year <- function(x)as.POSIXlt(x)$year+1900
qplot(unemploy/pop,uempmed,
      data=economics,
      geom=c("point"))
qplot(unemploy/pop,uempmed,
      data=economics,
      geom=c("point","line"))
qplot(unemploy/pop,uempmed,
      data=economics,geom="path",
      colour=year(date))+scale_size_area()

p <- ggplot(diamonds$carat,data=diamonds,
      facets=color~.,geom="histogram",
      binwidth=0.1)
qplot(carat,..density..,data=diamonds,
      facets=color~.,geom="histogram",
      binwidth=0.1,xlim=c(0,3))
p <- ggplot(diamonds,aes(carat,price,colour=cut))

# create factors with value labels 
data(mtcars)
mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5),labels=c("3gears","4gears","5gears")) 
mtcars$am <- factor(mtcars$am,levels=c(0,1),labels=c("Automatic","Manual")) 
mtcars$cyl <- factor(mtcars$cyl,levels=c(4,6,8),labels=c("4cyl","6cyl","8cyl")) 

# Kernel density plots for mpg
# grouped by number of gears (indicated by color)
qplot(mpg, data=mtcars, geom="density", 
      fill=gear, alpha=I(.5), 
      main="Distribution of Gas Milage", xlab="Miles Per Gallon", 
      ylab="Density")

qplot(mpg,data=mtcars,geom="density",fill=cyl)
# Scatterplot of mpg vs. hp for each combination of gears and cylinders
# in each facet, transmittion type is represented by shape and color
qplot(hp, mpg, data=mtcars, shape=am, 
      color=am, 
      facets=gear~cyl, 
      size=I(3),xlab="Horsepower", 
      ylab="Miles per Gallon") 

# Separate regressions of mpg on weight for each number of cylinders
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), 
      method="lm", formula=y~x, color=cyl, 
      main="Regression of MPG on Weight", xlab="Weight", 
      ylab="Miles per Gallon")

# Boxplots of mpg by number of gears 
# observations (points) are overlaid and jittered
qplot(gear, mpg, data=mtcars, geom=c("boxplot", "jitter"),
      fill=gear, main="Mileage by Gear Number",xlab="", 
      ylab="Miles per Gallon")

retail <- read.csv("retail_sales.csv")
str(retail)
head(retail)

#qplot histogram
theme_set(theme_bw())
qplot(Cost,data=retail)

#qplot scatter plot
qplot(x = Cost, y = Revenue, data =retail,ylim = c(0,150000))

#qplot scatter plot with color
qplot(x = Cost, y = Revenue, data =retail,
      color = Item_Category,
      ylim = c(0,150000))

#qplot scatter plot with color and size
qplot(x = Cost, y = Revenue, data =retail,
      color = Item_Category, size = Units_Sold,
      ylim = c(0,150000))

#qplot with facets
qplot(x = Cost, y = Revenue, data =retail,
      color = Item_Category, size = Units_Sold,facets = .~ Item_Category,
      ylim = c(0,150000))

#ggplot 

ggplot(data=retail, aes(x=Cost, y=Revenue)) + geom_point() +ylim(0,150000)

ggplot(retail, aes(x=Cost, y=Revenue)) +
  geom_line()+ylim(0,150000)

ggplot(retail, aes(x=Item_Category, y=Cost)) +geom_boxplot()

ggplot(retail, aes(x=Cost, y=Revenue,group=Item_Category)) +
  geom_point(aes(color=Item_Category))+ylim(0,150000)

ggplot(retail, aes(x=Cost, y=Revenue,group=Item_Category)) +
  geom_point(aes(color=Item_Category,size=Units_Available))+ylim(0,150000)

ggplot(retail, aes(x=Cost, y=Revenue)) +geom_point()+ylim(0,150000) 
+ facet_grid(. ~ Item_Category)

ggplot(retail, aes(x=Cost, y=Revenue)) +geom_point()+ facet_grid(. ~ Item_Category)


# Google charts API for R
library(googleVis)
demo(googleVis)



