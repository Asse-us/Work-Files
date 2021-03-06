rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        data  <- read.csv("outcome-of-care-measures.csv", colClasses = "character",na.strings="Not Available")
        
        ## Check that state and outcome are valid
        is.valid.state  <- validateValue("State", state,data)
        if (is.valid.state == FALSE) 
        {
                stop("Invalid State") 
        }
        
        
        Column.name  <- getColumnName(outcome)  
        # Find whether this value is valid or not
        if (Column.name == "Invalid Column") 
        {
                stop("Invalid Outcome")  
        }        
        
        colName <- Column.name
        
        ## Return hospital name in that state with the given rank 30-day death rate
        data.state <- data[data$State==state,]
        
        # order data by outcome
        sorted.data.state <- data.state[order(as.numeric(data.state[[colName]]),data.state[["Hospital.Name"]],decreasing=FALSE,na.last=NA), ]
        
        #handle num input
        if (num=="best") num = 1
        if (num=='worst') num = nrow(sorted.data.state)
        #will automatically return NA if num > nrow, as well as if it's some other text value
        # if someone passes num < 1, they'll get what's expected
        #if (is.numeric(num) & num > nrwo(sorted.data.state) return(NA)        
        sorted.data.state[num,"Hospital.Name"]
}

getColumnName  <- function (variable) 
{
        lower.Mortality  <- "Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from."
        
        lower.Mortality  <- "Hospital.30.Day.Death..Mortality..Rates.from."
        
        variable  <- tolower(variable)
        
        #print(variable)
        
        if (variable == "pneumonia")
        {
                lower.Mortality  <-  paste(lower.Mortality, "Pneumonia" ,sep = "", collapse = "")
        }  
        else if (variable =="heart attack")
        {  
                lower.Mortality  <-  paste(lower.Mortality, "Heart.Attack",sep = "", collapse = "")
        }
        else if (variable == "heart failure")
        {
                lower.Mortality  <-  paste(lower.Mortality,  "Heart.Failure",sep = "", collapse = "")
        }
        else
        {
                lower.Mortality  <-  "Invalid Column"
        }  
        
        #print(lower.Mortality)
        lower.Mortality
}


validateValue  <- function ( Column.name, variable.Value, data) 
{
        
        is.Valid  <- TRUE
        
        Column.Data  <- data[[Column.name]]
        actual.variable.Value  <- Column.Data[Column.Data == variable.Value]
        
        length.actual.variable.Value  <- length(actual.variable.Value)
        
        if (length.actual.variable.Value < 1) 
        {
                is.Valid  <- FALSE
        }
        
        is.Valid
}
