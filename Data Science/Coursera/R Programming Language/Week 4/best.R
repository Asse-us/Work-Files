best <- function(state, outcome) {
  ## Read outcome data
  data  <- read.csv("outcome-of-care-measures.csv")
  
  ## Check that state and outcome are valid
  is.valid.state  <- validateValue("State", state,data)
  if (is.valid.state == FALSE) 
  {
    return stop("Invalid State") 
  }
  
  
  Column.name  <- getColumnName(outcome)  
  # Find whether this value is valid or not
  if (Column.name == "Invalid Column") 
  {
    return stop("Invalid Outcome")  
  }
  
  ## Return hospital name in that state with lowest 30-day death
  Column.Data  <- data[[Column.name]]
  
  min.Mortaility  <- min(data[[Column.name]])
  
  All.Hospitals.With.Min.Mortaility  <- data[data[[Column.name]] == min.Mortaility,"Hospital.Name"]
  
  return sort(All.Hospitals.With.Min.Mortaility)[1]
  
}

function validateColumn (variable) 
{
  # Get the variable Column name
  Column.name  <- getColumnName(variable)
  
  # Find whether this value is valid or not
  if (Column.name == "Invalid Column")
  {
    return FALSE
  }
} 

function getColumnName(variable) 
{
  lower.Mortality  <- "Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from."
  
  if (grepl(variable, "Pneumonia")) 
  {
    return (paste(lower.Mortality, variable))
  }  
  else if (grepl(variable, "Attack"))
  {  
    return (paste(lower.Mortality, "Heart.Attack")
  }
  else if (grepl(variable, "Failure"))
  {
    return (paste(lower.Mortality, "Heart.Failure")
  }
  else
  {
    return ("Invalid Column")
  }  
  
  return ("Invalid Column")
}

function validateValue( Column.name, variable.Value, data) 
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