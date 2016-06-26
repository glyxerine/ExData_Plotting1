library(sqldf)
library(plyr)

## Function to load data into data frame.
loadData <- function() {
        dataPath <- "household_power_consumption.txt"
        
        ## Read using SQL to read only the required data. Note: warnings will be generated.
        readData <- read.csv.sql(dataPath, sql = "SELECT * FROM file WHERE Date IN ('1/2/2007','2/2/2007')",
                                 header = TRUE, sep = ";", eol = "\n")
        
        ## Create a time stamp for the data.
        readData <- mutate(readData, datetime = paste(readData$Date, readData$Time, sep = " "))
        readData$datetime <- strptime(readData$datetime, format = "%d/%m/%Y %H:%M:%S")
        
        readData
}

plot2 <- function() {
        graphdata <- loadData()
        
        ## Device set to png file.
        png(file = "plot2.png")
        
        ## Plot line graph.
        with(graphdata, plot(datetime, Global_active_power, type = "o", pch = "", ann = FALSE))
        title(ylab = "Global Active Power (kilowatts)")
        
        ## Close Device.
        dev.off()
}