getData <- function() {
      url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      zip_file <- "hpc.zip"
      file <- "household_power_consumption.txt"
      download.file(url, zip_file)
      unzip(zip_file)
      rawData <- read.table("household_power_consumption.txt", sep=";", stringsAsFactors=F, header=TRUE, na.strings="?")
      rawData$DateTime <- as.POSIXct(paste(rawData$Date, rawData$Time), format="%d/%m/%Y %H:%M:%S")
      rawData$Date <- as.Date(rawData$Date, "%d/%m/%Y")
      rawData$Time <- as.POSIXct(strptime(rawData$Time, "%H:%M:%S"))
      data <- subset(rawData, Date > as.Date("31/01/2007", "%d/%m/%Y") & Date < as.Date("03/02/2007", "%d/%m/%Y"))
      data
}

plot2 <- function() {
      data <- getCData()
      png(filename="plot2.png", width = 480, height = 480, bg="white")
      plot(Global_active_power ~ DateTime, data, type="l", ylab="Global Active Power (Kilowatts)", xlab="")
      dev.off()
}