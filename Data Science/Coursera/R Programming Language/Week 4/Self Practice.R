outcome  <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
ncol(outcome)
nrow(outcome)

# Prints the name of each Column.
names(outcome)


outcome[,11]  <- as.numeric(outcome[,11])
hist(outcome[,11])