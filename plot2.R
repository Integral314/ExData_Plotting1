## Course Project 1 Plot 2

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
png(filename = "plot2.png", width = 480, height = 480)

## Create plot
plot(data$Date_Time, data$Global_active_power,type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Close device
dev.off()