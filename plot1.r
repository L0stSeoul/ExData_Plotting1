#read the data
data <- read.table("../household_power_consumption.txt", na.strings="?",
                   sep=";", header=TRUE,stringsAsFactors=FALSE)
#set Date format 
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#subsetting the data that we want to focus on
data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#converting the date format
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

#plot the data
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

#save the file 
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()