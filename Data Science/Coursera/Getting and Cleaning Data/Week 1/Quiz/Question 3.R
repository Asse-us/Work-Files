## We will be using xlsx package to solve this problem

install.packages("xlsx")


if (!file.exists("data")) {dir.create("data")} 


fileUrl  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx" 

destFile  <- ".\\data\\gas.csv" 

download.file(fileUrl, destFile,mode="wb") 

library(xlsx)

dat  <- read.xlsx(destFile,sheetIndex=1, header=TRUE, rowIndex = 18:23, colIndex = 7:15)  

# It is always a best practice to have a date marker whenever you download a new file from internet.
# as it might be possible that if you later download the file again . It might have different data in it.
dataDownloaded  <- date()

sum(dat$Zip*dat$Ext,na.rm=T)

