install.packages("ggplot2")
library("ggplot2")
install.packages("lubridate")
library("lubridate")


data <- read.table("household_power_consumption.txt", sep = ";")
names(data) <- as.character(data[1,])
data <- data[-1,]
data <- subset(data,data[,1] == c("1/1/2007","2/1/2007"))
data <- data %>% mutate(Date_Time = paste0(Date, " ", Time))
data <- select(data, -c(,1))
data <- select(data, -c(,1))
data <- data %>% relocate(Date_Time, .before = Global_active_power)
data$Date_Time <- as.Date(data$Date_Time, format = "%m/%d/%Y %H:%M:%S", tz = Sys.timezone())
