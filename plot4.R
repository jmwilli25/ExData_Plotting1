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
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))

# Concat Date and Time columns and cast as POSIXct date time
data$DateTime <- as.POSIXct(strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S"))

# Output format
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# 2x2 window
par(mfrow=c(2,2))

# Plot1.R
plot(data$DateTime, data$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")

# Plot2.R
plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot3.R
with(data, plot(DateTime, Sub_metering_1, type="n", xlab="", ylab = "Energy sub metering"))
with(data, lines(DateTime, Sub_metering_1, col = "black"))
with(data, lines(DateTime, Sub_metering_2, col = "red"))
with(data, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty=c(1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"))

# Plot4.R
plot(data$DateTime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab="Global_reactive_power")

# Output to file
dev.off()
