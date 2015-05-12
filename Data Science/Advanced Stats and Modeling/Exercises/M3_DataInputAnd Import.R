# data input and import

# read from console
n <- scan() #numeric, no need to specify "what="
t <- scan(what="")

mat <- matrix(scan(), ncol = 3, byrow = TRUE)

# read a list from console
emp <- scan(what=list(name="",age=0,sal=0))

# Data import is quite simple and straightforward for the most part
# Probably the least error-prone route is via CSV 

# CSV and tab-delimited

download.file("http://databank.worldbank.org/data/download/WDI_csv.zip", 
              "WDI_csv.zip")
# will download to the current working directory
# use getwd() and setwd() to see and set this
unzip("WDI_csv.zip")
wdi.stats <- read.csv("/Work/RWA/WB_data/MDG/MDG_Data.csv")
head(wdi.stats,20)

mydata <- read.table("mydata.csv", header=TRUE, sep=",") #default separator is whitespace
mydata <- read.csv("mydata.csv", header=TRUE)

# Excel
library(gdata)  
# uses Perl
# you need to have Perl installed on your system

mydata <- read.xls("Claims_Data_Small.xls", sheet=1) # worksheet by number
mydata2 <- read.xls("Claims_Data_Small.xls", sheet="Second Sheet") # worksheet by name

# XLSX
# uses Java

library(xlsx)
mydata2 <- read.xlsx("Claims_Data_Full.xlsx",sheetName="Data") #sheet by number
mydata2 <- read.xlsx(file.choose(), 1) #sheet by number
write.xlsx(a,file.choose(),sheetName="test")
write.xlsx(a,file.choose(),sheetName="test2",append=TRUE)

# SPSS - export in .por format
library(Hmisc)
mydata <- spss.get("mydata.por", use.value.labels=TRUE) # converts value labels to factors

# SAS
# method 1 - export in .xpt format
library(HMisc)
mydata <- sasxport.get("mydata.xpt")

# method 2
library(foreign)
mydata <- read.ssd("./data", "datafile", sascmd="./Applications/sas.exe")

# method 3 - this requires that typing "sas" at the command prompt invokes SAS
library(Hmisc)
mydata <- sas.get("~/data", "datafile")


# Exploring R's built-in data sets

data()
data(package = .packages(all.available = TRUE))
data(package="MASS")
