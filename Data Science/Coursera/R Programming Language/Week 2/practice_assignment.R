dataset_url  <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
download.file (dataset_url, "diet_data.zip")
unzip("diet_data.zip", exdir="diet_data.zip")

#This is how we can choose all files from a folder.
list.files("diet_data")

andy  <- read.csv ("diet_data/Andy.csv")
#Not sure what below function does but it is evident that it print first few rows of a dataframe as shown below:
head(andy)

#Let find out the how many rows are there by getting the length of a particular Column in this case
#we are checking length of day Column 
length(andy$Day)


#Dim functions stands for dimensions function and it is a quick way to get no of rows and no of Column of an obj
dim(andy)

#It describes the overall structure of andy. And it is a quick way to know what Column are accessible via $ notation
str(andy)

#summary function gives a quick snapshot of all the Columns
summary(andy)

#name function used to return names of the Columns and row if any
names(andy)

# dim(), summary() and str() functions can be used with individual variables as well.
dim(andy$Day)
str(andy$Day)
summary(andy$Day)
#names function doesnot work with single Column like below.
#names(andy$Day)

#------------------------------------------------- Get data out of object-------------------------------------#
# it is simply dump the whole object.
andy

# Question : How would we see Andy's starting weight
# Here we are Getting value of first row and weight Column
andy[1,"Weight"]
andy[30,"Weight"]

# You could create a subset of the 'Weight' column where the data where 'Day' is equal to 30.
# Below are the various ways to subset the from a data set
andy[which(andy$Day == 30),"Weight"]
andy[which(andy[,"Day"] == 30),"Weight"]
andy[andy$Day == 30,"Weight"]
andy[andy[,"Day"] == 30,"Weight"]

# Subset function provide a clean way to get some data out of a dataframe
subset(andy$Weight, andy$Day == 30)
subset(andy[,"Weight"], andy$Day == 30)
subset(andy$Weight, andy[,"Day"] == 30)
subset(andy[,"Weight"], andy[,"Day"] == 30)

andy.Start  <- andy[1,"Weight"]
andy.End  <- andy[30,"Weight"]

andy.Weight.Loss  <- andy.Start - andy.End
andy.Weight.Loss
#-------------------------------------------------------------------------------------------------------------# 

# Here we are storing names of all the files stored in directory "diet_data" in an object.
files  <- list.files("diet_data")
files

# Here we are accessing accessing file names using subsetting technique.
files[1]
files[2]
files[3:5]

# Let's take a quick look at John.csv.
head(read.csv(files[3]))
# Well it says it cannot open file 'John.csv': No such file or directory
# This is because we are currently in parent directory not in "diet_data" directory

# Checking for the parameter full.names. We can use it to get a list of files which contains full names rather than relative names
?list.files()

# Using full.names will produce an output like "diet_data/Andy.csv"  "diet_data/David.csv" which contains full name relative to working directory
files.full  <- list.files("diet_data",full.names = TRUE)
files.full

# Pretty cool. Now let's try taking a look at John.csv again:
head(read.csv(files.full[3]))

# So what if we wanted to create one big data frame with everybody's data in it? We'd do that with rbind and a loop. Let's start with rbind:
andy.David  <- rbind(andy, read.csv(files.full[2]))
andy.David
# Wow we are able to combine these. Great let check using head & tail
head(andy.David)
tail(andy.David)

# Let's create a subset of the data frame that shows us just the 25th day for Andy and David.
day_25  <- andy.David[andy.David$Day == 25,]
day_25  <- andy.David[which(andy.David$Day == 25),]
day_25  <- andy.David[andy.David[,"Day"] == 25,]
day_25  <- andy.David[which(andy.David[,"Day"] == 25),]
day_25

# Loops. what's happening in a loop, let's try something:
for (i in 1:5) {print(i)}

# As you can see, for each pass through the loop, i increases by 1 from 1 through 5. Let's apply that concept to our list of files.
for (i in 1:5) {
        dat  <- rbind(dat, read.csv(files.full[i]))
}

#Whoops. Object 'dat' not found. This is because you can't rbind something into a file that doesn't exist yet. So let's create an empty data frame called 'dat' before running the loop.
dat  <- data.frame()

for (i in 1:5) {
        dat  <- rbind(dat, read.csv(files.full[i]))
}
str(dat)

# So what if we wanted to know the median weight for all the data? Let's use the median() function
median(dat$Weight)

# NA? Why did that happen? Type 'dat' into the console and you'll see a print out of all 150 obversations. Scroll back up to row 77, and you'll see that we have some missing data from John, which is recorded as NA by R
dat

# We need to get rid of those NA's for the purposes of calculating the median. There are several approaches. For instance, we could subset the data using complete.cases() or is.na(). But if you look at ?median, you'll see there is an argument called na.rm that will strip the NA values out for us
median(dat$Weight, na.rm=TRUE)

# We can find the median weight of day 30 by taking the median of a subset of the data where Day=30.
dat_30  <- dat[dat$Day == 30,]
dat_30  <- dat[dat[,"Day"] == 30,]
dat_30  <- dat[which(dat[,"Day"] == 30),]
dat_30
median(dat_30$Weight, na.rm=TRUE)
# We've done a lot of manual data manipulation so far. Let's build a function that will return the median weight of a given day.

# Let's start out by defining what the arguments of the function should be. 
# These are the parameters that the user will define. 
# The first parameter the user will need to define is the directory that is holding the data. 
# The second parameter they need to define is the day for which they want to calculate the median.
# So our function is going to start out something like this:
weightMedian.ForADay <- function(directory, day) 
{ 
        All.files  <- list.files(directory,full.names = TRUE)
        
        Alldata  <- data.frame()
        
        for (i in 1:length(All.files)) {
                Alldata  <- rbind(Alldata, read.csv(All.files[i]))
        }
        
        DataForDay  <- Alldata[Alldata$Day == day, ]
        
        median(DataForDay$Weight, na.rm= TRUE)
        
}







