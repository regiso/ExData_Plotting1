################################################################################
##
##                     Coursera Exploratory Analysis - Week 1 Assignment
##                     Plot 4 Code
################################################################################




##This assignment uses data from the UC Irvine Machine Learning Repository, 
##a popular repository for machine learning datasets. 
##In particular, we will be using the "Individual household electric power 
##consumption Data Set".
##https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

###Review criteria

###Was a valid GitHub URL containing a git repository submitted?
###Does the GitHub repository contain at least one commit beyond the original fork?
###Please examine the plot files in the GitHub repository. 
###Do the plot files appear to be of the correct graphics file format?
###Does each plot appear correct?
###Does each set of R code appear to create the reference plot?



###########################################################################################
#
##This code runs with the assumption that the following data are loaded into 
## the working directory:
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
#
###########################################################################################


library(data.table)
library(dplyr)
library(lubridate)

###########################################################################################
##
##                                 Import data
##
#######################################################################################

data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, nrows=10)
classes <- sapply(data, class)
rm(data)
data <- fread("household_power_consumption.txt", sep=";", 
               header=TRUE, colClasses=classes, na.strings="?")
######################################################################################
##
##                    Extract 01/02/2007 & 02/02/2007 & format time variables
##
######################################################################################
data1<- data
data1$Date <-as.Date(data1$Date, "%d/%m/%Y")
feb1 <- filter(data1, Date=="2007-02-01")
feb2 <- filter(data1, Date=="2007-02-02")
feb1_2 <-rbind(feb1, feb2)
feb1_2$datetime <- paste(feb1_2$Date, feb1_2$Time)
feb1_2$dmyhms <-as.POSIXct(feb1_2$datetime)
feb1_2$day <- format(feb1_2$dmyhms, "%a")


######################################################################################
##
##                      Plot 4 Four plot Assortment
##
######################################################################################

png(file="plot2.png")
par(mfrow=c(2,2))


plot(feb1_2$dmyhms, feb1_2$Global_active_power, type="o", 
     ylab="Global Active Power (kilowatts)", xlab="")


plot(feb1_2$dmyhms, feb1_2$Voltage, type="o",
     ylab="Voltage", xlab="datetime")


plot(feb1_2$dmyhms, feb1_2$Sub_metering_1, type="o", 
     ylab="Energy sub metering", xlab="")
lines(feb1_2$dmyhms,feb1_2$Sub_metering_2, type="o", col="red")
lines(feb1_2$dmyhms, feb1_2$Sub_metering_3, type="o", col="blue")
legend("topright", pch=1, col=c("black", "blue", "red"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(feb1_2$dmyhms, feb1_2$Global_reactive_power, type="o",
     ylab="Global_reactive_power", xlab="datetime")

dev.off()
