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

## Create the Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
  with(ip, {
    plot(Global_active_power~dateTime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~dateTime, type="l", 
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~dateTime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~dateTime,col='Red')
    lines(Sub_metering_3~dateTime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~dateTime, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="")
  })


##Create PNG
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
