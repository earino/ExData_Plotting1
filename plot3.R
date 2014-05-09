##
## Generate Plot3 for the Coursera Exploratory Data Analysis class
## Peer Assessments / Course Project 1
##
## This code generates a line chart of date time against energy sub metering.
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

png(filename="plot3.png", width=480, height=480, bg = "transparent")
plot(relevant_data$DateTime, relevant_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(relevant_data$DateTime, relevant_data$Sub_metering_2, col="red")
lines(relevant_data$DateTime, relevant_data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.off()
