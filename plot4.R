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
dat$Sub_metering_1 <- as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2 <- as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3 <- as.numeric(dat$Sub_metering_3)
dat$Voltage <- as.numeric(dat$Voltage)

# Plot 4
#   Open png file
#   Plot
#   Close png file
png(filename = "./plot4.png", height = 480, width = 480)
par(mfrow = c(2,2))
#plot 1 of 4
plot(dat$DateTime, dat$Global_active_power, type = "l",ylab = "Global Active Power (kilowatts)", frame.plot = TRUE, xlab = "")

#plot 2 of 4
plot(dat$DateTime, dat$Voltage, type="l", xlab="datetime", ylab="Voltage", frame.plot=T)

#plot 3 of 4
plot(dat$DateTime,  dat$Sub_metering_1, type = "l", ylab = "Energy sub metering", frame.plot = TRUE, xlab = "", col = "black")
lines(dat$DateTime, dat$Sub_metering_2, col = "red")
lines(dat$DateTime, dat$Sub_metering_3, col = "blue")
legend(x="topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd=c(1,1,1), bty = "n")

#plot 4 of 4
plot(dat$DateTime,  dat$Global_reactive_power, type = "l", ylab = "Global_reactive_power", frame.plot = TRUE, xlab = "datetime")


dev.off()
