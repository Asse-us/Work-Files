corr <- function(directory, threshold = 0) {
        
        All.files  <- list.files(directory,full.names = TRUE)
        
        #head(All.files)        
        final.data  <- numeric()
        
        for (i in 1:length(All.files)) 
        {
                rawData  <- read.csv(All.files[i])
                #head(rawData)        
                All.complete.Cases  <- rawData[complete.cases(rawData),]
                        
                 if (threshold < nrow(All.complete.Cases))
                 {
                         final.data  <- c(final.data, cor(All.complete.Cases$nitrate,All.complete.Cases$sulfate))                                        
                 }
        }            
        
        final.data
}