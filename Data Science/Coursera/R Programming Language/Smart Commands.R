# Here we are searching one variable into other vector
# And below command shows how to do it quickly and correctly
validOutcome = c("heart attack","heart failure","pneumonia")
if (!outcome %in% validOutcome) { stop("invalid outcome")}

# Getting unique values from a Column.
# Here we populating validState from data present in myData dataset
validState = unique(myData[,7])

## convert outcome name into column name
fullColName <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
colName <- fullColName[match(outcome,validOutcome)]

# More flexible ways of subsetting these get the subset of the data with the desired state
new_data <- subset(data, State == state) # new_data  <- data[data$State == state]

# How to update same dataset after changing the values.
new_data[, outcome_column] <- as.numeric(new_data[,outcome_column])

