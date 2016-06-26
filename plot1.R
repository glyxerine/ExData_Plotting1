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

plot1 <- function() {
        graphdata <- loadData()
        
        png(file = "plot1.png")
        hist(graphdata$Global_active_power, col = "red", ann = FALSE)
        title(main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
        dev.off()
}