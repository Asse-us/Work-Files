install.packages("XML")

fileUrl  <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml" 

library(XML) 
library(RCurl)

xData <- getURL(fileUrl)

data  <- xmlTreeParse(fileUrl, useInternal=TRUE) 

rootNode  <- xmlRoot(data)

xmlName(rootNode)

names(rootNode)

rootNode[[1]]

allZips  <- xpathSApply(rootNode, "//zipcode", xmlValue)

requiredZips  <-allZips[allZips == 21231]