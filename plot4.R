## Course Project 1 Plot 4

## Create Download url
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Download data
download.file(url, destfile = "./Project1")

## read data in to working directory
library(sqldf)
data <- read.csv2.sql("household_power_consumption.txt")

## subset data
data$Date <- as.Date(data$Date, "%d/%m/%Y")
date1 <-as.Date("2007-02-01")
date2 <-as.Date("2007-02-02")
data <- data[(data$Date >= date1 & data$Date<=date2), ]

## Paste date & time columns together
Date_Time <- cbind(paste(data$Date,data$Time))

## coerce from character to POSIXct, POSIXlt
Date_Time <- strptime(Date_Time, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")

## Get day of the week labels
library(lubridate)
Day_of_Week <- wday(Date_Time, label = TRUE)

## create new dataframe
data <- cbind(Date_Time, Day_of_Week, data[3:9])

## Open device to create plot
png(filename = "plot4.png", width = 480, height = 480)

## Create plot
par(mfrow = c(2,2))

## First Plot
plot(data$Date_Time, data$Global_active_power,type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Second Plot
plot(data$Date_Time, data$Voltage,type = "l", xlab = "datetime", ylab = "Voltage")

## Third Plot 
with(data, plot(Date_Time, Global_active_power, type = "n", xlab = " ", ylab = "Energy sub metering", ylim = c(0, 40)))
with(data, lines(Date_Time, Sub_metering_1))
with(data, lines(Date_Time, Sub_metering_2, col = "red"))
with(data, lines(Date_Time, Sub_metering_3, col = "blue"))
legend("topright", pch = "____", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Fourth Plot
plot(data$Date_Time, data$Global_reactive_power,type = "l", xlab = "datetime", ylab = "Global_reactive_power")

## Close device
dev.off()