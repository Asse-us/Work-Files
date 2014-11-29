pollutantmean <- function(directory, pollutant, id = 1:332) {
        Alldata  <- data.frame() 
        for (i in id)
        {        
                filepath  <- paste(getwd(), "/", directory,"/", formatC(i, width =3, flag="0"), ".csv",sep="")                                
                Alldata  <- rbind(Alldata, read.csv(filepath))
        }
        
        mean(Alldata[[pollutant]], na.rm = TRUE)
        
        # Checkout below links for different ways of doing 
        # https://rpubs.com/SatoshiLiang/16516
}

