#read the  data
data <- read.table("../household_power_consumption.txt", na.strings="?",
                   sep=";", header=TRUE,stringsAsFactors=FALSE)
#set the Date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#subsetting the data that we want to focus on 
data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#converting the date format
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

# #plot
plot(data$Global_active_power~data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

#save the file to plot2.png
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()