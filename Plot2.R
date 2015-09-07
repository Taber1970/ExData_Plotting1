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

#Get date-time field
date = info$Date
date = gsub("2/2/2007","02/02/2007", date)
date = gsub("1/2/2007","02/01/2007", date)

date_time = paste(date, info$Time)

info$POSIX = strptime(date_time, "%m/%d/%Y %H:%M:%S")

#Turn on PNG device
png(filename = "plot2.png")

#Make Plot
par(op)   #Set to standard plotting settings
plot(info$POSIX, info$Global_active_power, main = "Global Active Power", ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")

#Shut down PNG device
dev.off()