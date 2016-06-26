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

plot4 <- function() {
        graphdata <- loadData()
        
        ## Device set to png file.
        png(file = "plot4.png")
        par(mfrow = c(2, 2), mar = c(5, 5, 2, 1), oma = c(0, 0, 0, 0))
        
        ## Plot top left graph.
        with(graphdata, plot(datetime, Global_active_power, type = "o", pch = "", ann = FALSE))
        title(ylab = "Global Active Power")
        
        ## Plot top right graph.
        with(graphdata, plot(datetime, Voltage, type = "o", pch = "", col = "black"))
        
        ## Plot bottom left graph.
        with(graphdata, plot(datetime, Sub_metering_1, type = "o", pch = "", col = "black", ann = FALSE))
        with(graphdata, lines(datetime, Sub_metering_2, pch = "", col = "red"))
        with(graphdata, lines(datetime, Sub_metering_3, pch = "", col = "blue"))
        title(ylab = "Energy sub metering")
        legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               pch = c("","",""), col = c("black","red","blue"), lwd = 1, lty = 1, bty = "n")
        
        ## Plot bottom right graph.
        with(graphdata, plot(datetime, Global_reactive_power, type = "o", pch = "", col = "black"))
        
        ## Close Device.
        dev.off()
}