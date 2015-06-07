rm(list=ls())
library("data.table")

#Read All Data (treat all columns as character)
dat <- fread("./household_power_consumption.txt", sep=";", colClasses = rep("character", 9))

#Subset the Data
dat <- subset(dat, Date %in% c("1/2/2007", "2/2/2007"))

# Convert to Date Type
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")

# Convert to numeric types
dat$Global_active_power <- as.numeric(dat$Global_active_power)

# Plot 1
#   Open png file
#   Plot
#   Close png file
png(filename = "./plot1.png", height = 480, width = 480)
hist(dat$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
dev.off()
