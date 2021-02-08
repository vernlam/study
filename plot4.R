install.packages("tidyverse")
library(tidyverse)

data <- read.table("household_power_consumption.txt", sep = ";")
names(data) <- as.character(data[1,])
data <- data[-1,]
data <- subset(data,data$Date == "1/2/2007" | data$Date == "2/2/2007")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")

data[1:1440,"Time"] <- format(data[1:1440,"Time"], "2007-02-01 %H:%M:%S")
data[1441:2880,"Time"] <- format(data[1441:2880,"Time"], "2007-02-02 %H:%M:%S")

par(mfrow = c(2,2))

with(data,{
  plot(x = data$Time, y = as.numeric(data$Global_active_power), 
       type = "l",
       xlab = "",
       ylab = "Global Active Power (kilowatts)")
  plot(x = data$Time, y = as.numeric(data$Voltage), 
       type = "l",
       xlab = "datetime",
       ylab = "Voltage")
  plot(x = data$Time, y = as.numeric(data$Sub_metering_1), type = "n", xlab = "",
       ylab = "Energy sub metering", main = "Energy Sub-Metering")
  with(data,lines(Time,as.numeric(Sub_metering_1)))
  with(data,lines(Time,as.numeric(Sub_metering_2), col = "red"))
  with(data,lines(Time,as.numeric(Sub_metering_3), col = "blue"))
  legend("topright", lty = 1, cex = 0.5, col = c("black","red","blue"), 
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) 
  plot(x = data$Time, y = as.numeric(data$Global_reactive_power), 
       type = "l",
       xlab = "datetime",
       ylab = "Global_reactive_power")
})



