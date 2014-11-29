complete <- function(directory, id = 1:332) {
        
        final.data  <- data.frame()
        for (i in id)
        {
                file.Path  <- paste(getwd(), "/", directory, "/",formatC(i, width = 3, flag= "0" ), ".csv" ,sep="")
                
                rawData  <- read.csv(file.Path)
                
                complete.Cases  <- rawData[complete.cases(rawData),]
                                
                one.row  <- c(i,nrow(complete.Cases))
                
                final.data  <- rbind(final.data, one.row)
        }
        
        colnames(final.data)  <- c('id', 'nobs')
        final.data
        
        # http://rstudio-pubs-static.s3.amazonaws.com/1938_14f57c0817674c85ac1df70f6ffcf8a3.html
        # https://gist.github.com/timmyshen/6872633 
        # https://rpubs.com/SatoshiLiang/16516
}