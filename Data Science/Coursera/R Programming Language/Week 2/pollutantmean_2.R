pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        
        All.files  <- list.files(directory,full.names = TRUE)
        
        Alldata  <- data.frame()
        
        for (i in 1:id) {
                Alldata  <- rbind(Alldata, read.csv(All.files[i]))
        }
        
        TotalMean  <- numeric(0)
        
        if (pollutant == "sulfate")
        {
                TotalMean  <- mean(Alldata$sulfate, na.rm = TRUE)
        }
        else if (pollutant == "nitrate")
        {
                TotalMean  <- mean(Alldata$nitrate, na.rm = TRUE)
        }             
        
        TotalMean       
        
}


