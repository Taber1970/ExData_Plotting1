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

#Turn on PNG device
png(filename = "plot1.png")

#Make Plot
par(op)   #Set to standard plotting settings
hist(info$Global_active_power, main = "Global Active Power", col = "Red", xlab = "Global Active Power (kilowatts)")


#Shut down PNG device
dev.off()