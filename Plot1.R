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

## Create the Plot 1
hist(ip$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
