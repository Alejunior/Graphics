D <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
## Format date to Type Date
D$Date <- as.Date(D$Date, "%d/%m/%Y")

## Filter data set from the dates 2007-02-01 and 2007-02-02
D <- subset(D,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Combine Date and Time column
DateTime <- paste(D$Date, D$Time)
## Remove Date and Time column
D <- D[ ,!(names(D) %in% c("Date","Time"))]
## Add DateTime column
D <- cbind(DateTime, D)
## Format DateTime(same as strptime format)
D$DateTime <- as.POSIXct(DateTime)
## Figure 4
par(mfrow=c(2,2), mar=c(4,4,2,1))
with(D, {
  plot(Global_active_power~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  
  plot(Voltage~DateTime, type="l",
       ylab="Voltage (volt)", xlab="")
  
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Global_reactive_power~DateTime, type="l",
       ylab="Global Rective Power (kilowatts)",xlab="")
  }, height=15, width=10)
