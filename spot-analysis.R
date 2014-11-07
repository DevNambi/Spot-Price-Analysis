library(ggplot2)
library(stats)


theme_clean <- theme(
  panel.background = element_rect(fill="white"),
  axis.ticks = element_line(colour=NA),
  panel.grid = element_line(colour="white"),
  axis.text.y = element_text(colour=NA),
  axis.text.x = element_text(colour="white")
)
theme_set(theme_bw())

setwd('Documents/Spot-Price-Analysis/raw-data/')
prices.df <- read.csv("us-west-2_history.csv", header = FALSE)

str(prices.df)
names(prices.df) <- c('region','az','time','instance','price')
summary(prices.df)


#Order of operations
# 1) Look at the data visually
# 2) Look at the correlations. Make sure to use non-normal correlations. Use qqplots to look for data distribution
# 3) Identify correlations to investigate further
# 4) Random forest. Use it to predict the data.
#Histograms, KDEs of various columns

general_instances <- c('t1.micro',)
cpu_instances <- c()
ram_instances <- c('r3.2xlarge','r3.4xlarge','r3.8xlarge','r3.large','r3.xlarge')
special_instances <- c()

qplot(price, instance, data=prices.df, geom=c('boxplot', 'jitter'),
      main="Price Per Instance", xlab="Dollars Per Hour", ylab="Instance Type", alpha=I(0.2))

qplot(price, instance, data=subset(prices.df,instance %in% ram_instances),
      geom=c('boxplot', 'jitter'),
      main="Price Per Instance", xlab="Dollars Per Hour", ylab="Instance Type", alpha=I(0.2))

qplot(instance, price, data=subset(prices.df,instance %in% ram_instances),
      geom=c('boxplot', 'jitter'),
      main="Price Per Instance", ylab="Dollars Per Hour", xlab="Instance Type", alpha=I(0.2))

qplot(x=c(''), y=price, data=subset(prices.df,instance %in% ram_instances),
      facets=instance~az, size=I(3),
      main="Price Per Instance", ylab="Dollars Per Hour", xlab="Instance Type", alpha=I(0.2))

qplot()

qplot(hp, mpg, data=mtcars, shape=am, color=am, 
      facets=gear~cyl, size=I(3),
      xlab="Horsepower", ylab="Miles per Gallon") 





