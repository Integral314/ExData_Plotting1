## Course Project 1 Plot 1

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

## Open device to create histogram
png(filename = "plot1.png", width = 480, height = 480)

## Create histogram
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power")

## Close device
dev.off()