rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        data  <- read.csv("outcome-of-care-measures.csv", colClasses = "character",na.strings="Not Available")
        
        ## Check that state and outcome are valid        
        validOutcome = c("heart attack","heart failure","pneumonia")
        if (!outcome %in% validOutcome) { stop("invalid outcome")}
        
        validState = unique(data[,"State"])
        if (!state %in% validState) stop("invalid state")
        
        ## convert outcome name into column name
        fullColName <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
        Column.Name <- fullColName[match(outcome,validOutcome)]
        
        ## Return hospital name in that state with the given rank
        state.data  <- data[data$State == state,]
        
        final.Data  <- state.data[!(state.data[Column.Name] == "Not Available"),]
        
        final.Data  <- final.Data[!is.na(final.Data[Column.Name]),]
        
        column.data  <- final.Data[,Column.Name]
        
        sorted.data  <- sort(column.data)
        
        uniqueValues  <- unique(as.numeric(sorted.data))
        
        rank  <- 1
        
        if (num == "best") rank  <- 1
        else if (num == "worst") rank  <-length(uniqueValues)
        else rank  <- as.integer(num)
        
        mortaility.for.given.rank  <- uniqueValues[rank]
        
        # Finding all hospitals with this mortaility rate
        all.hospitals.with.current.rank  <- final.Data[final.Data[Column.Name] == as.character(mortaility.for.given.rank),"Hospital.Name"]
        
        
        sort(all.hospitals.with.current.rank)[1]
}
