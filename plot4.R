#############
# plot4.R
#############

# Download the .zip file and put it in the "data" folder
if (!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip", method = "curl")

# Unzip the file
unzip(zipfile = "./data/household_power_consumption.zip", exdir = "./data")

# Read the data
data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Subset the data
data_sub <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]

#write.table(data_sub, file = "./data/household_power_consumption_sub.txt", row.names = FALSE)
#data_sub <- read.table("./data/household_power_consumption_sub.txt", header = TRUE)

# Save as a .png file
png("plot4.png", 
    width  = 480, 
    height = 480, 
    units  = "px")

# Convert the Date and Time variables into Date/Time classes in R
time <- with(data_sub, paste(Date, Time, sep = " "))
time <- strptime(time, "%d/%m/%Y %H:%M:%S")
     
#install.packages("dplyr")
library(dplyr)
sub_meeterings <- select(data_sub, starts_with("Sub_metering_"))

# Make a 2x2 plot
par(mfrow = c(2, 2))

# Plot [1, 1]
with(data_sub, plot(time, Global_active_power, 
                    type = "l", 
                    ylab = "Global Active Power", 
                    xlab = "")) 
# Plot [1, 2]
with(data_sub, plot(time, Voltage, 
                    type = "l", 
                    ylab = "Voltage", 
                    xlab = "datetime")) 
# Plot [2, 1]
with(data_sub, plot(time, sub_meeterings[, 1], 
                    type = "n", # no data points
                    ylab = "Energy sub metering", 
                    xlab = "")) 
# Sub_metering_1
points(time, sub_meeterings[, 1], 
       type = "l", 
       col = "black")
# Sub_metering_2
points(time, sub_meeterings[, 2], 
       type = "l", 
       col = "red")
# Sub_metering_3
points(time, sub_meeterings[, 3], 
       type = "l", 
       col = "blue")

# Add a legend
legend("topright", 
       bty = "n", # no box
       lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

# Plot [2, 2]
with(data_sub, plot(time, Global_reactive_power, 
                    type = "l", 
                    ylab = "Global_reactive_power", 
                    xlab = "datetime")) 

# Turn off the graphics device
dev.off()
