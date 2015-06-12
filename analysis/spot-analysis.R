library(ggplot2)
library(stats)
library(forecast)
library(zoo)
library(dplyr)



theme_clean <- theme(
  panel.background = element_rect(fill="white"),
  axis.ticks = element_line(colour=NA),
  panel.grid = element_line(colour="white"),
  axis.text.y = element_text(colour=NA),
  axis.text.x = element_text(colour="white")
)
theme_set(theme_bw())

#setwd('C:/Users/fractals.000/Documents/GitHub/Spot-Price-Analysis/clean-data')
setwd('/Users/devnambi/Documents/GitHub/Spot-Price-Analysis/clean-data/')
prices.df <- read.csv("Price.csv", header = FALSE)

str(prices.df)
names(prices.df) <- c('region','az','time','instance','category','spotprice','demandprice','compute','memory','hdd','ssd','storage')
#prices.df$time <- as.Date(prices.df$time)
str(prices.df)
prices.df$time2 <- strptime(x=prices.df$time, "%Y-%m-%d %H:%M:%OS")

summary(prices.df)


# See which instance has the most variation
prices.df$discount <- prices.df$spotprice / prices.df$demandprice
qplot(y=instance, x=discount, data=prices.df, alpha=I(0.1))
qplot(y=instance, x=discount, data=prices.df, geom=c('boxplot'))


# First, pick just a single region
rm(prices.1.df)
rm(prices.2.df)
rm(prices.3.df)


prices.1.df <- prices.df[prices.df$az %in% c('us-west-2b'), ]
# prices.1.df$time2

prices.2.df <- prices.1.df[prices.1.df$instance %in% c('m2.4xlarge'), ]
# prices.2.df$time2

prices.3.df <- unique(prices.2.df)
# prices.3.df$time2
# index(prices.3.df$time2)

  
  
# Convert the data frame to be a time series
prices.region.zoo <- zoo(prices.3.df$spotprice, order.by=prices.3.df$time2)
region.fit <- auto.arima(prices.region.zoo)
# 

#plot(region.fit)
summary(region.fit)



