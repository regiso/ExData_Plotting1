################################################################################
##
##                     Coursera Exploratory Analysis - Week 1 Assignment
##                     Plot 1 Code
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
##                      Plot 1 Global Active Power ~ Frequency
##
######################################################################################

png(file="plot1.png")
hist(feb1_2$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()

