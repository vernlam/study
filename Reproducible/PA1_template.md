---
title: "Analysis of Personal Movement using activity monitoring devices"
author: "Vernon Lam"
date: "13/02/2021"
output: html_document
---

The dataset we are using is derived from activity monitoring devices such as Fitbit,
Nike Fuelband, or Jawbone Up. These types of devices are part of the "quantified self"
movement - a group of enthusiasts who take measurements about themselves regularly to
improve their health, to find patterns in their behaviour, or because they are tech geeks.

These devices collect data at 5 minute intervals throughout the day. It consists of two months
of data from an anonymous individual collected during the months of October and November 2012,
and includes the number of steps taken in 5 minute intervals each day.

```{r, echo = TRUE}
dataset <- read.csv("activity.csv")
```

Let's have a brief look at the dataset.

```{r, echo = TRUE}
dim(dataset)
head(dataset)
tail(dataset)
```

So we know that dataset contains 17568 rows, each row representing an interval period of 5-minutes between the dates of 1 October 2012 and 30 November 2012. Let's further investigate
what 'steps' is.

```{r, echo = TRUE}
table(dataset$steps)
```

So there does appear to be data in 'steps' and not just NA figures. We can understand it to be
the number of steps taken within each 5 minute interval. The NA figures must represent those 5 minute intervals where no steps were taken, for example, time when the wearer of the device is asleep, or inactive.  

Okay... let's do some analysis.

Let's first create a histogram of the total number of steps taken on each day.

```{r, echo = TRUE}
aggregate <- with(dataset, aggregate(steps, by = list(date), FUN = sum, na.rm = T))
names(aggregate) <- c("Date", "Total Steps")
hist(aggregate$`Total Steps`, breaks = 10, xlab = "Total steps in a day", ylab = "Frequency",
     main = "Total number of steps taken per day")
```

At a glance, we can see that the most frequent number of steps taken in a day between 1 October and 30 November is just over 10000 steps.

Let's now find the *mean* and *median* number of steps taken each day.

```{r, echo = TRUE}
mean(aggregate$`Total Steps`)
median(aggregate$`Total Steps`)
```

The mean, or average number of steps each day is 9354, while the median is 10395. This makes sense if we compare it to the visual representation in the above *histogram*.

Now let's do some analysis on the interval period, or... time of day. Let's try and answer the question... and what time(s) of day are the most steps taken?

Let's do some tidying up of the "Time" variable first, so it's in the correct format.
```{r, echo = TRUE}
interval_aggregate <- with(dataset, aggregate(steps, by = list(interval), FUN = mean, na.rm = T))
names(interval_aggregate) <- c("Time", "Mean")
temp <- mapply(function(x,y) paste0(rep(x,y), collapse = ""), 0,4 - nchar(interval_aggregate$Time))
interval_aggregate$Time <- paste0(temp,interval_aggregate$Time)
interval_aggregate$Time <- format(strptime(interval_aggregate$Time, format = "%H%M"), format = "%H:%M")
head(interval_aggregate)
```

Now let's chart it as a time series...

```{r, echo = TRUE, fig.width= 10}
library(tidyverse)

plotdata <- data.frame(as.POSIXct(interval_aggregate$Time, format = "%H:%M"),interval_aggregate$Mean)
names(plotdata) <- c("Time", "Mean")

p <- ggplot(plotdata, aes(x=Time,y=Mean)) + geom_line() + xlab("Time")+
  scale_x_datetime(date_breaks = "2 hours", date_labels = "%I:%M %p")
print(p)
```

We can see that the on average over the 2 month period, the most number of steps is taken between 8am and 9.30am.



Recall that there are lots of NA values within 'steps' in the dataset.
```{r, echo = TRUE}
head(dataset)
tail(dataset)
```
How many are there?
```{r, echo = TRUE}
sum(is.na(dataset$steps))
```

Let's replace them with the *mean* number of steps for that interval period. We have already calculated this within the variable 'interval_aggregate'.
```{r, echo = TRUE}
head(interval_aggregate)
```

We'll need to change the 'Time' variable in interval_aggregate back to 'interval' so it aligns with dataset before we can match and replace them.

Instead, let's just re-aggregate the dataset variable and call it interval_aggregateV2

```{r, echo = TRUE}

interval_aggregateV2 <- with(dataset, aggregate(steps, by = list(interval), FUN = mean, na.rm = T))
names(interval_aggregateV2) <- c("interval", "Mean")
head(interval_aggregateV2)
```

Okay let's now replace the NA values in dataset with the equivalent mean for that interval period, calculated in interval_aggregateV2.

```{r, echo = TRUE}
dataset$steps[is.na(dataset$steps)] <- interval_aggregateV2$Mean[match(dataset$interval, interval_aggregateV2$interval)]
head(dataset)
```

Now let's make another histogram!

```{r, echo = TRUE}
aggregate <- with(dataset, aggregate(steps, by = list(date), FUN = sum, na.rm = T))
names(aggregate) <- c("Date", "Total Steps")
hist(aggregate$`Total Steps`, breaks = 10, xlab = "Total steps in a day", ylab = "Frequency",
     main = "Total number of steps taken per day")
```

Now that NA values have been replaced with the average number of steps in that given interval, we can observe that the frequency of 0 - 2500 steps are much lower.



Let's figure out whether there are differences in activity patterns between weekdays and weekends.

First, let's create a new dataset so we don't mess up our original, and create a new column which defines the day of the week. Then, create another column which defines whether it is a weekday or weekend.

```{r, echo = TRUE}
datasetv1 <- dataset

datasetv1$date <- as.POSIXct(datasetv1$date)
datasetv1 <- datasetv1 %>% mutate(datasetv1, weekdays(datasetv1$date))
datasetv1 <- datasetv1 %>% rename("Day" = "weekdays(datasetv1$date)")
datasetv1 <- datasetv1 %>% mutate(datasetv1, Type = ifelse(Day %in% c("Saturday", "Sunday"),
                                                           "Weekend", "Weekday"))
table(datasetv1$Type)
```

Look's like it's done correctly!

Now let's throw in another time series, comparing the averagesteps throughout the day on a weekday vs a weekend.

First we have to aggregate the dataset by interval, then convert the interval into Time.
```{r, echo = TRUE}
data_agg <- aggregate(steps~interval + Type, datasetv1, mean)
names(data_agg) <- c("Time","Type", "Mean")

temp <- mapply(function(x,y) paste0(rep(x,y), collapse = ""), 0,4 - nchar(data_agg$Time))
data_agg$Time <- paste0(temp,data_agg$Time)
data_agg$Time <- format(strptime(data_agg$Time, format = "%H%M"), format = "%H:%M")
head(data_agg)
```

Now let's plot.

```{r, echo = TRUE, fig.width= 10}

#Convert into Time type variable
plotdata <- data.frame(as.POSIXct(data_agg$Time, format = "%H:%M"),data_agg$Type, data_agg$Mean)
names(plotdata) <- c("Time","Type", "Mean")

# Plot
plot <- ggplot(plotdata, aes(x = Time, y = Mean, color = Type)) +
  geom_line() +
  labs(title = "Average daily steps - Weekday vs Weekend", x = "Time of day", 
       y = "Average number of steps") +
  scale_x_datetime(date_breaks = "2 hours", date_labels = "%I:%M %p") +
  facet_wrap(~Type, ncol = 1, nrow = 2)
print(plot)
```

Thanks for reading!