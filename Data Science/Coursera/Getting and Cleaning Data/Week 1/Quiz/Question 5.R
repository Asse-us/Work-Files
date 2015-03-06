install.packages("data.table") 

library(data.table) 

fileUrl  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

destFile  <- ".\\data\\communities.csv" 

download.file(fileUrl, destFile)


system.time(fread(destFile)) 

DT  <- fread(destFile)

system.time(DT[,mean(pwgtp15),by=SEX]) 
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)) 
system.time(mean(DT$pwgtp15,by=DT$SEX)) 

system.time(mean(DT[DT$SEX==1,]$pwgtp15)) 
system.time(mean(DT[DT$SEX==2,]$pwgtp15)) 

system.time(tapply(DT$pwgtp15,DT$SEX,mean)) 

system.time(rowMeans(DT)[DT$SEX==1]) 
system.time(rowMeans(DT)[DT$SEX==2]) 


DT[,list(mean(x),sum(z))]

