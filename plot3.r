#read the data
data <- read.table("../household_power_consumption.txt", na.strings="?",
                   sep=";", header=TRUE,stringsAsFactors=FALSE)
#set the Date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#subsetting the data that we want to focus on
data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#converting the date format
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime) 

#plot
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#save the file 
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()