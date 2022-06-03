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

## Figure 2 : Plot
plot(D$Global_active_power~D$DateTime, type="l", ylab = "Global Active Power (kilowatts)", xlab = "DateTime", width =480, height=480)
