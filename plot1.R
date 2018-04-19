#############
# plot1.R
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
png("plot1.png", 
    width  = 480, 
    height = 480, 
    units  = "px")

# Make a histogram plot
with(data_sub, hist(Global_active_power, 
                    col = "red", 
                    xlab = "Global Active Power (kilowatts)", 
                    ylab = "Frequency", 
                    main = "Global Active Power"))     

# Turn off the graphics device
dev.off()
