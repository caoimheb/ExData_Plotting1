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

plot1 <- function() {
      data <- getData()
      png(filename="plot1.png", width = 480, height = 480, bg="white")
      hist(data$Global_active_power, breaks=20, ylab="Frequency", xlab="Global Active Power (Kilowatts)", col="red", main="Global Active Power")
      dev.off()
}