library(sqldf)
library(plyr)

loadData <- function() {
        dataPath <- "household_power_consumption.txt"
        readData <- read.csv.sql(dataPath, sql = "SELECT * FROM file WHERE Date IN ('1/2/2007','2/2/2007')",
                                 header = TRUE, sep = ";", eol = "\n")
        readData <- mutate(readData, datetime = paste(readData$Date, readData$Time, sep = " "))
        readData$datetime <- strptime(readData$datetime, format = "%d/%m/%Y %H:%M:%S")
        
        readData
}

plot2 <- function() {
        graphdata <- loadData()
        
        png(file = "plot2.png")
        with(graphdata, plot(datetime, Global_active_power, type = "o", pch = "", ann = FALSE))
        title(ylab = "Global Active Power (kilowatts)")
        dev.off()
}