##
## Generate Plot1 for the Coursera Exploratory Data Analysis class
## Peer Assessments / Course Project 1
##
## This code generates a histogram of Global Active Power in kilowatts, binned
## in 1/2 unit increments.
##

# for ymd parsing
library(lubridate)

# read the file
household_power_consumption <- read.csv("household_power_consumption.txt", 
                                        stringsAsFactors=FALSE,
                                        sep=";")

household_power_consumption$Date <- dmy(household_power_consumption$Date)
target_interval <- interval(ymd(20070201), ymd(20070202))

relevant_data <- subset(household_power_consumption, Date %within% target_interval)
relevant_data[relevant_data == '?'] <- NA

relevant_data$DateTime <- ymd_hms(paste(relevant_data$Date, relevant_data$Time))
columns_to_convert <- names(relevant_data)[3:9]
for (col in columns_to_convert) relevant_data[[col]] <- as.numeric(relevant_data[[col]])

png(filename="plot1.png", width=480, height=480, bg = "transparent")
hist(relevant_data$Global_active_power, col="red", 
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")

dev.off()
