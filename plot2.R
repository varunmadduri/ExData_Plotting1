rm(list=ls())
library("data.table")
library("ggplot2")

#Read All Data (treat all columns as character)
dat <- fread("./household_power_consumption.txt", sep=";", colClasses = rep("character", 9))

#Subset the Data
dat <- subset(dat, Date %in% c("1/2/2007", "2/2/2007"))

# Convert to Date Type
dat[, DateTime := as.POSIXct(paste(dat$Date, dat$Time), format = "%d/%m/%Y %H:%M:%S")]
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")

# Convert to numeric types
dat$Global_active_power <- as.numeric(dat$Global_active_power)

# Plot 2
#   Open png file
#   Plot
#   Close png file
png(filename = "./plot2.png", height = 480, width = 480)
plot(dat$DateTime, type = "l", dat$Global_active_power, ylab = "Global Active Power (kilowatts)", frame.plot = TRUE, xlab = "")
dev.off()
