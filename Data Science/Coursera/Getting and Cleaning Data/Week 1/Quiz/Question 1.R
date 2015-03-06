if (!file.exists("data")) {dir.create("data")} 

fileUrl  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

destFiles  <- ".\\data\\housingData.csv"

download.file(fileUrl, destFiles)

data  <- read.csv(destFiles)

head(data)

propertyValues  <- data[!is.na(data$VAL),]

propertiesWithValueGreaterThan1000000  <- propertyValues[propertyValues$VAL >= 24,"VAL"]

count  <- length(propertiesWithValueGreaterThan1000000)