require(sqldf)

if (!file.exists("household_power_consumption.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", method = "curl")
  unzip("household_power_consumption.zip")
}

if (!exists("elData")) {
  elData <- read.csv.sql("household_power_consumption.txt", sep = ";", sql = 'select * from file where Date="1/2/2007" or Date="2/2/2007"')
  # convert date to useful
  elData$Date <- strptime(paste(elData$Date, elData$Time), "%m/%d/%Y %H:%M:%S")
  elData$Time <- NULL # get rid of useless column
}

# plot 1
png(file = "plot1.png", width = 480, height = 480)
hist(elData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()