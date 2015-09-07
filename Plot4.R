#Download data
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "household_power_consumption.zip")

#unzip data
unzip("household_power_consumption.zip")

#Load data
data = read.delim2("household_power_consumption.txt", sep = ";", comment.char = "", strip.white = TRUE)

#Only look at the dates in question
info = data[grep("^1/2/2007|^2/2/2007", data$Date),]

#Polish values
info$Global_active_power = as.numeric(as.character(info$Global_active_power))
info$Global_reactive_power = as.numeric(as.character(info$Global_reactive_power))
info$Voltage = as.numeric(as.character(info$Voltage))
info$Sub_metering_1 = as.numeric(as.character(info$Sub_metering_1))
info$Sub_metering_2 = as.numeric(as.character(info$Sub_metering_2))
info$Sub_metering_3 = as.numeric(as.character(info$Sub_metering_3))

#Get date-time field
date = info$Date
date = gsub("2/2/2007","02/02/2007", date)
date = gsub("1/2/2007","02/01/2007", date)

date_time = paste(date, info$Time)

info$POSIX = strptime(date_time, "%m/%d/%Y %H:%M:%S")

#Turn on PNG device
png(filename = "plot4.png")

#Make Plot
par(mfrow = c(2,2))

#1
plot(info$POSIX, info$Global_active_power, main = "Global Active Power", ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")

#2
plot(info$POSIX, info$Voltage, main = "", ylab = "Voltage", xlab = "datetime", type = "l")

#3
plot(info$POSIX, info$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(info$POSIX, info$Sub_metering_2, type = "l", col = "Red")
lines(info$POSIX, info$Sub_metering_3, type = "l", col = "Blue")
legend("topright", lty = 1, col = c("Black", "BLue", "Red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#4
plot(info$POSIX, info$Global_reactive_power, main = "", ylab = "Global_reactive_power", xlab = "datetime", type = "l")

#Shut down PNG device
dev.off()