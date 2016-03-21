# Read in data and subset
data <- read.table("household_power_consumption.txt", sep = ";")
data <- data[data[,1]=="1/2/2007" | data[,1]=="2/2/2007",]

# Update column names
names(data)[1] <- "Date"
names(data)[2] <- "Time"
names(data)[3] <- "Global_active_power"
names(data)[4] <- "Global_reactive_power"
names(data)[5] <- "Voltage"
names(data)[6] <- "Global_intensity"
names(data)[7] <- "Sub_metering_1"
names(data)[8] <- "Sub_metering_2"
names(data)[9] <- "Sub_metering_3"

# Change column types to numeric where needed.
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# Output format
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# Plot1.R
hist(data$Global_active_power, main="Global Active Power", col = "red", xlab="Global Active Power (kilowatts)")

# Output to file
dev.off()
