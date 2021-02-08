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


plot(x = data$Time, y = as.numeric(as.character(data$Global_active_power)), 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     main = "Global Active Power vs Time")
