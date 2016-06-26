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

plot3 <- function() {
        graphdata <- loadData()
        
        ## Device set to png file.
        png(file = "plot3.png")
        
        ## Plot Sub_metering_1 line graph.
        with(graphdata, plot(datetime, Sub_metering_1, type = "o", pch = "", col = "black", ann = FALSE))
        
        ## Plot Sub_metering_2 line.
        with(graphdata, lines(datetime, Sub_metering_2, pch = "", col = "red"))
        
        ## Plot Sub_metering_3 line.
        with(graphdata, lines(datetime, Sub_metering_3, pch = "", col = "blue"))
        title(ylab = "Energy sub metering")
        
        ## Set legend.
        legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               pch = c("","",""), col = c("black","red","blue"), lwd = 1, lty = 1)
        
        ## Close Device.
        dev.off()
}