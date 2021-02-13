---
title: "Analysis of Personal Movement using activity monitoring devices"
author: "Vernon Lam"
date: "13/02/2021"
output:
  pdf_document: default
  html_document: default
---

The dataset we are using is derived from activity monitoring devices such as Fitbit,
Nike Fuelband, or Jawbone Up. These types of devices are part of the "quantified self"
movement - a group of enthusiasts who take measurements about themselves regularly to
improve their health, to find patterns in their behaviour, or because they are tech geeks.

These devices collect data at 5 minute intervals throughout the day. It consists of two months
of data from an anonymous individual collected during the months of October and November 2012,
and includes the number of steps taken in 5 minute intervals each day.


```r
dataset <- read.csv("activity.csv")
```

Let's have a brief look at the dataset.


```r
dim(dataset)
```

```
## [1] 17568     3
```

```r
head(dataset)
```

```
##   steps       date interval
## 1    NA 2012-10-01        0
## 2    NA 2012-10-01        5
## 3    NA 2012-10-01       10
## 4    NA 2012-10-01       15
## 5    NA 2012-10-01       20
## 6    NA 2012-10-01       25
```

```r
tail(dataset)
```

```
##       steps       date interval
## 17563    NA 2012-11-30     2330
## 17564    NA 2012-11-30     2335
## 17565    NA 2012-11-30     2340
## 17566    NA 2012-11-30     2345
## 17567    NA 2012-11-30     2350
## 17568    NA 2012-11-30     2355
```

So we know that dataset contains 17568 rows, each row representing an interval period of 5-minutes between the dates of 1 October 2012 and 30 November 2012. Let's further investigate
what 'steps' is.


```r
table(dataset$steps)
```

```
## 
##     0     1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16    17    18    19 
## 11014     7     8     3    25    17    33    87    83    61    46    43    43    42    30    68    65    61    50    51 
##    20    21    22    23    24    25    26    27    28    29    30    31    32    33    34    35    36    37    38    39 
##    53    38    46    40    42    40    34    45    42    36    37    41    44    48    35    46    37    33    45    44 
##    40    41    42    43    44    45    46    47    48    49    50    51    52    53    54    55    56    57    58    59 
##    39    24    31    37    31    22    38    24    24    30    29    27    32    23    18    33    25    28    28    24 
##    60    61    62    63    64    65    66    67    68    69    70    71    72    73    74    75    76    77    78    79 
##    30    21    31    24    27    22    22    17    24    18    20    26    16    13    25    18    18    15    18    18 
##    80    81    82    83    84    85    86    87    88    89    90    91    92    93    94    95    96    97    98    99 
##    19    13    17    10    10    14    14     6    14     9    12     7    14     6    12    13     7    10     8     9 
##   100   101   102   103   104   105   106   107   108   109   110   111   112   113   114   115   116   117   118   119 
##     8    12     7    10     8     9     9     8     7     8     7    11    10     6    10     6     5    10     4    13 
##   120   121   122   123   124   125   126   127   128   129   130   131   132   133   134   135   136   137   138   139 
##     8     6     7     7     8     1     3     6    10     7     3     6     2     3     2    10     6     9     7     7 
##   140   141   142   143   144   145   146   147   148   149   150   151   152   153   154   155   156   157   158   159 
##     2     3     6    10     5     3     9     1     7     6     2     2     6     8     8     2     6     4     5     6 
##   160   161   162   163   164   165   166   167   168   170   171   172   173   174   175   176   177   178   179   180 
##     4     5     1     5     3     2     4     4     8     8     6     7     6     7     3     6     1     4     6     4 
##   181   182   183   184   185   186   187   188   189   190   191   192   193   194   195   196   197   198   199   200 
##     3     3     3     3     3     4     2     4     3     7     1     2     5     3     1     1     5     4     3     2 
##   201   202   203   204   205   206   207   208   209   210   211   212   213   214   216   219   221   223   224   225 
##     3     2     6     3     3     1     3     2     1     1     3     1     1     1     2     2     2     4     1     2 
##   229   230   231   232   235   236   237   238   240   241   242   243   244   245   247   248   249   250   251   252 
##     1     2     2     3     1     1     2     2     1     2     2     3     1     3     3     1     1     2     1     2 
##   253   254   255   256   257   258   259   260   261   262   263   264   265   266   267   269   270   271   272   274 
##     1     1     1     1     3     1     1     7     1     2     2     3     1     4     2     2     1     1     3     2 
##   275   276   277   279   280   281   282   283   284   285   286   287   289   290   291   292   293   294   295   297 
##     3     2     4     3     2     5     2     2     2     3     5     1     1     2     2     2     2     2     1     1 
##   298   299   301   302   303   304   305   306   307   308   309   310   311   312   313   314   315   316   317   318 
##     5     1     2     1     1     1     1     3     1     2     1     4     3     2     1     2     1     2     2     1 
##   319   320   321   322   323   324   325   326   327   328   330   331   332   333   334   335   336   339   340   341 
##     4     1     3     2     2     2     2     2     1     2     2     1     3     1     4     3     1     1     2     1 
##   343   344   345   346   347   349   350   351   353   354   355   356   357   358   359   360   361   362   363   364 
##     2     1     3     1     1     4     1     4     1     1     1     2     1     3     1     1     2     2     1     4 
##   365   366   368   370   371   372   373   374   375   376   377   378   380   384   385   387   388   389   391   392 
##     1     3     1     1     3     1     1     2     1     1     4     1     2     1     1     2     1     3     2     2 
##   393   394   395   396   397   399   400   401   402   403   404   405   406   408   410   411   412   413   414   415 
##     5     1     3     2     2     2     4     2     2     3     3     1     2     2     1     4     2     5     2     3 
##   416   417   418   419   421   422   423   424   425   426   427   428   429   431   432   433   434   435   436   437 
##     3     1     3     1     1     1     1     1     3     1     1     1     2     1     4     3     1     2     1     2 
##   439   440   441   442   443   444   446   449   450   451   453   454   456   457   458   459   461   462   463   464 
##     4     4     2     1     4     4     4     1     2     3     3     2     1     2     1     1     1     2     4     1 
##   465   466   467   468   469   470   471   472   473   474   475   476   477   478   479   480   481   482   483   484 
##     4     2     1     5     2     1     1     2     4     1     4     4     1     1     2     1     1     3     4     1 
##   485   486   487   488   489   490   491   492   493   494   495   496   497   498   499   500   501   503   504   505 
##     4     2     2     3     6     1     2     1     2     3     4     3     2     2     4     3     3     2     6     3 
##   506   507   508   509   510   511   512   513   514   515   516   517   518   519   520   521   522   523   524   526 
##     3     4     4     3     2     6     3     4     1     4     2     3     2     6     2     1     5     4     2     5 
##   527   528   529   530   531   532   533   534   535   536   537   539   540   541   542   544   545   546   547   548 
##     4     3     5     2     1     3     8     3     1     2     1     1     5     2     2     2     1     4     1     1 
##   549   551   553   555   556   559   562   567   568   569   571   573   574   577   581   584   591   592   594   597 
##     2     1     1     2     1     1     1     1     2     1     1     1     1     1     1     1     1     1     1     1 
##   600   602   606   608   611   612   613   614   618   619   625   628   630   634   635   637   638   639   643   652 
##     1     1     1     1     1     1     3     1     1     2     1     1     1     1     1     1     1     1     1     3 
##   655   659   662   665   667   668   679   680   681   682   686   687   690   693   697   698   701   706   708   709 
##     1     2     1     1     1     1     1     2     1     1     1     1     1     1     1     1     1     2     1     1 
##   710   713   714   715   717   718   720   721   725   726   727   729   730   731   732   733   734   735   736   737 
##     1     2     1     2     1     1     1     4     1     2     1     1     1     3     2     4     1     2     1     2 
##   738   739   741   742   743   744   745   746   747   748   749   750   751   752   753   754   755   756   757   758 
##     1     2     1     3     3     2     1     2     4     4     2     3     1     1     2     2     3     2     4     5 
##   759   760   765   766   767   768   769   770   777   781   783   785   786   789   794   802   806 
##     2     2     1     1     1     1     1     3     1     1     1     3     1     1     1     1     1
```

So there does appear to be data in 'steps' and not just NA figures. We can understand it to be
the number of steps taken within each 5 minute interval. The NA figures must represent those 5 minute intervals where no steps were taken, for example, time when the wearer of the device is asleep, or inactive.  

Okay... let's do some analysis.

Let's first create a histogram of the total number of steps taken on each day.


```r
aggregate <- with(dataset, aggregate(steps, by = list(date), FUN = sum, na.rm = T))
names(aggregate) <- c("Date", "Total Steps")
hist(aggregate$`Total Steps`, breaks = 10, xlab = "Total steps in a day", ylab = "Frequency",
     main = "Total number of steps taken per day")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png)

At a glance, we can see that the most frequent number of steps taken in a day between 1 October and 30 November is just over 10000 steps.

Let's now find the *mean* and *median* number of steps taken each day.


```r
mean(aggregate$`Total Steps`)
```

```
## [1] 9354.23
```

```r
median(aggregate$`Total Steps`)
```

```
## [1] 10395
```

The mean, or average number of steps each day is 9354, while the median is 10395. This makes sense if we compare it to the visual representation in the above *histogram*.

Now let's do some analysis on the interval period, or... time of day. Let's try and answer the question... and what time(s) of day are the most steps taken?

Let's do some tidying up of the "Time" variable first, so it's in the correct format.

```r
interval_aggregate <- with(dataset, aggregate(steps, by = list(interval), FUN = mean, na.rm = T))
names(interval_aggregate) <- c("Time", "Mean")
temp <- mapply(function(x,y) paste0(rep(x,y), collapse = ""), 0,4 - nchar(interval_aggregate$Time))
interval_aggregate$Time <- paste0(temp,interval_aggregate$Time)
interval_aggregate$Time <- format(strptime(interval_aggregate$Time, format = "%H%M"), format = "%H:%M")
head(interval_aggregate)
```

```
##    Time      Mean
## 1 00:00 1.7169811
## 2 00:05 0.3396226
## 3 00:10 0.1320755
## 4 00:15 0.1509434
## 5 00:20 0.0754717
## 6 00:25 2.0943396
```

Now let's chart it as a time series...


```r
library(tidyverse)

plotdata <- data.frame(as.POSIXct(interval_aggregate$Time, format = "%H:%M"),interval_aggregate$Mean)
names(plotdata) <- c("Time", "Mean")

p <- ggplot(plotdata, aes(x=Time,y=Mean)) + geom_line() + xlab("Time")+
  scale_x_datetime(date_breaks = "2 hours", date_labels = "%I:%M %p")
print(p)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png)

We can see that the on average over the 2 month period, the most number of steps is taken between 8am and 9.30am.



Recall that there are lots of NA values within 'steps' in the dataset.

```r
head(dataset)
```

```
##   steps       date interval
## 1    NA 2012-10-01        0
## 2    NA 2012-10-01        5
## 3    NA 2012-10-01       10
## 4    NA 2012-10-01       15
## 5    NA 2012-10-01       20
## 6    NA 2012-10-01       25
```

```r
tail(dataset)
```

```
##       steps       date interval
## 17563    NA 2012-11-30     2330
## 17564    NA 2012-11-30     2335
## 17565    NA 2012-11-30     2340
## 17566    NA 2012-11-30     2345
## 17567    NA 2012-11-30     2350
## 17568    NA 2012-11-30     2355
```
How many are there?

```r
sum(is.na(dataset$steps))
```

```
## [1] 2304
```

Let's replace them with the *mean* number of steps for that interval period. We have already calculated this within the variable 'interval_aggregate'.

```r
head(interval_aggregate)
```

```
##    Time      Mean
## 1 00:00 1.7169811
## 2 00:05 0.3396226
## 3 00:10 0.1320755
## 4 00:15 0.1509434
## 5 00:20 0.0754717
## 6 00:25 2.0943396
```

We'll need to change the 'Time' variable in interval_aggregate back to 'interval' so it aligns with dataset before we can match and replace them.

Instead, let's just re-aggregate the dataset variable and call it interval_aggregateV2


```r
interval_aggregateV2 <- with(dataset, aggregate(steps, by = list(interval), FUN = mean, na.rm = T))
names(interval_aggregateV2) <- c("interval", "Mean")
head(interval_aggregateV2)
```

```
##   interval      Mean
## 1        0 1.7169811
## 2        5 0.3396226
## 3       10 0.1320755
## 4       15 0.1509434
## 5       20 0.0754717
## 6       25 2.0943396
```

Okay let's now replace the NA values in dataset with the equivalent mean for that interval period, calculated in interval_aggregateV2.


```r
dataset$steps[is.na(dataset$steps)] <- interval_aggregateV2$Mean[match(dataset$interval, interval_aggregateV2$interval)]
```

```
## Warning in dataset$steps[is.na(dataset$steps)] <- interval_aggregateV2$Mean[match(dataset$interval, : number of items to
## replace is not a multiple of replacement length
```

```r
head(dataset)
```

```
##       steps       date interval
## 1 1.7169811 2012-10-01        0
## 2 0.3396226 2012-10-01        5
## 3 0.1320755 2012-10-01       10
## 4 0.1509434 2012-10-01       15
## 5 0.0754717 2012-10-01       20
## 6 2.0943396 2012-10-01       25
```

Now let's make another histogram!


```r
aggregate <- with(dataset, aggregate(steps, by = list(date), FUN = sum, na.rm = T))
names(aggregate) <- c("Date", "Total Steps")
hist(aggregate$`Total Steps`, breaks = 10, xlab = "Total steps in a day", ylab = "Frequency",
     main = "Total number of steps taken per day")
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13-1.png)

Now that NA values have been replaced with the average number of steps in that given interval, we can observe that the frequency of 0 - 2500 steps are much lower.



Let's figure out whether there are differences in activity patterns between weekdays and weekends.

First, let's create a new dataset so we don't mess up our original, and create a new column which defines the day of the week. Then, create another column which defines whether it is a weekday or weekend.


```r
datasetv1 <- dataset

datasetv1$date <- as.POSIXct(datasetv1$date)
datasetv1 <- datasetv1 %>% mutate(datasetv1, weekdays(datasetv1$date))
datasetv1 <- datasetv1 %>% rename("Day" = "weekdays(datasetv1$date)")
datasetv1 <- datasetv1 %>% mutate(datasetv1, Type = ifelse(Day %in% c("Saturday", "Sunday"),
                                                           "Weekend", "Weekday"))
table(datasetv1$Type)
```

```
## 
## Weekday Weekend 
##   12960    4608
```

Look's like it's done correctly!

Now let's throw in another time series, comparing the averagesteps throughout the day on a weekday vs a weekend.

First we have to aggregate the dataset by interval, then convert the interval into Time.

```r
data_agg <- aggregate(steps~interval + Type, datasetv1, mean)
names(data_agg) <- c("Time","Type", "Mean")

temp <- mapply(function(x,y) paste0(rep(x,y), collapse = ""), 0,4 - nchar(data_agg$Time))
data_agg$Time <- paste0(temp,data_agg$Time)
data_agg$Time <- format(strptime(data_agg$Time, format = "%H%M"), format = "%H:%M")
head(data_agg)
```

```
##    Time    Type       Mean
## 1 00:00 Weekday 2.25115304
## 2 00:05 Weekday 0.44528302
## 3 00:10 Weekday 0.17316562
## 4 00:15 Weekday 0.19790356
## 5 00:20 Weekday 0.09895178
## 6 00:25 Weekday 1.59035639
```

Now let's plot.


```r
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

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-16-1.png)

Thanks for reading!
