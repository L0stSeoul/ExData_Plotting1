ip <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date type
ip$Date <- as.Date(ip$Date, "%d/%m/%Y")
  
## Subset the data
ip <- subset(ip,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
  
## Remove incomplete observation
ip <- ip[complete.cases(ip),]

## Combine Date and Time columns
dateTime <- paste(ip$Date, ip$Time)
  
## Name the vector
dateTime <- setNames(dateTime, "DateTime")
  
## Remove Date and Time column
ip <- ip[ ,!(names(ip) %in% c("Date","Time"))]
  
## Add DateTime column
ip <- cbind(dateTime, ip)
  
## Format dateTime Column
ip$dateTime <- as.POSIXct(dateTime)

## Create the Plot 3
  with(ip, {
    plot(Sub_metering_1~dateTime, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~dateTime,col='Red')
    lines(Sub_metering_3~dateTime,col='Blue')
  })
  legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


##Create PNG
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
