#-------------------------------------------------First R function--------------------------------------------#
add2  <- function (x,y)
{
  x+y
} 

aboveN  <- function (x, n = 10) {  
  use  <- x > n 
  x[use]
} 

ColumnMean  <- function (y, removeNA = TRUE) {
  nc  <- ncol(y)
  means  <- numeric(nc)
  for(i in 1: nc)
  {
      means[i]  <- mean(y[,i], na.rm = removeNA)
  }
  means
} 

#Setting up the data for testing
filePath  <- "D://Karundeep's Files//Data Science//Coursera//R Programming//Week 1//rprog-data-quiz1_data//hw1_data.csv"
myData  <-  read.csv(filePath,header=TRUE)
#-------------------------------------------------------------------------------------------------------------# 