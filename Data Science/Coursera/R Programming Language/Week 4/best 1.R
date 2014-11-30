best <- function(state, outcome) {
  ## Read outcome data
  data  <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available")
  
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
  
  # Cleaning Data
  state.Data  <- data[(data["State"] == state),]
  
  final.Data  <- state.Data[!(state.Data[Column.name] == "Not Available"),]
  
  final.Data  <- final.Data[!is.na(final.Data[Column.name]),]
  
  Column.Data  <- final.Data[,Column.name]
  
  # Caculating minimum mortaility
  min.Mortaility  <- sort(Column.Data)[1]  
  
  # Finding all hospitals with this mortaility
  All.Hospitals.With.Min.Mortaility  <- final.Data[final.Data[Column.name] == as.character(min.Mortaility),"Hospital.Name"]
  
  # Returing the first hospital after sorting the list of all hospitals
  sort(All.Hospitals.With.Min.Mortaility)[1]
  
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

# Another interesting ways to get the answer of above problem
https://github.com/muntasir2165/R-Programming-Assignments-1--2--and-3-/blob/master/Programming%20Assignment%203%20-%20Hospital%20Quality/best.R
