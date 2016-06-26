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

plot3 <- function() {
        graphdata <- loadData()
        
        png(file = "plot3.png")
        with(graphdata, plot(datetime, Sub_metering_1, type = "o", pch = "", col = "black", ann = FALSE))
        with(graphdata, lines(datetime, Sub_metering_2, pch = "", col = "red"))
        with(graphdata, lines(datetime, Sub_metering_3, pch = "", col = "blue"))
        title(ylab = "Energy sub metering")
        
        legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               pch = c("","",""), col = c("black","red","blue"), lwd = 1, lty = 1)
        dev.off()
}