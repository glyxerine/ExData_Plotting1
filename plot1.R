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

## Function that generate plot1 png file.
plot1 <- function() {
        graphdata <- loadData()
        
        ## Device set to png file.
        png(file = "plot1.png")
        
        ## Plot histogram.
        hist(graphdata$Global_active_power, col = "red", ann = FALSE)
        title(main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
        
        ## Close Device.
        dev.off()
}