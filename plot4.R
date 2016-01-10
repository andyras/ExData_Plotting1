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

# plot 4
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2)) # 2 x 2 plot

# GAP over time
plot(elData$Date, elData$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")

# Voltage over time
with(elData, plot(Date, Voltage, type = "l", xlab = "datetime"))

# sub metering
plot(elData$Date, elData$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
lines(elData$Date, elData$Sub_metering_2, type="l", col = "red")
lines(elData$Date, elData$Sub_metering_3, type="l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

# GRP over time
with(elData, plot(Date, Global_reactive_power, type = "l", xlab = "datetime"))

dev.off()