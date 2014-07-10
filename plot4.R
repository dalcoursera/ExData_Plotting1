# plot4.R generates the combined plot plot4.png, which includes line graphs
# for Global Active Power, Global Reactive Power, Voltage, and Sub-metering
# 1, 2, and 3 on 2007-02-01 and 2007-02-02.

dlzip = "exdata_data_household_power_consumption.zip"
# If data file hasn't been downloaded, fetch it and unzip it
if (!file.exists(dlzip)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                mode = "wb", destfile = dlzip)
  unzip(dlzip)
}

# Extract data from the file around the section we want
overalldata <- data.frame()
overalldata <- read.table("household_power_consumption.txt", comment.char= "", sep= ";", na.strings= "?", skip= 66600, n= 3050)
colnames(overalldata) <- c("Date", "Time", "GAP", "GRP", "Voltage", "GI", "SM1", "SM2", "SM3")

# Find just the data for the two days
twodaydata <- subset(overalldata, Date == "1/2/2007" | Date == "2/2/2007")

# Take the date and time columns to make a datetime vector for plotting
datetime <- as.POSIXct(strptime(paste(twodaydata$Date, twodaydata$Time), "%d/%m/%Y %H:%M:%S"))  

# Set up PNG for plotting combined graphs
png(filename = "plot4.png")
par(mfrow = c(2, 2), mar = c(5, 4, 1, 1), oma = c(0, 0, 2, 0))

# Upper left line graph
plot(datetime, twodaydata$GAP, type = "l", xlab = "", ylab = "Global Active Power", main = "")

# Upper right line graph
plot(datetime, twodaydata$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", main = "")

# Lower left line graph
plot(datetime, twodaydata$SM1, type = "n", xlab = "", ylab = "Energy sub metering", main = "")
points(datetime, twodaydata$SM1, type = "l")
points(datetime, twodaydata$SM2, type = "l", col = "red")
points(datetime, twodaydata$SM3, type = "l", col = "blue")
legend("topright", bty = "n", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Lower right line graph
plot(datetime, twodaydata$GRP, type = "l", xlab = "datetime", ylab = "Global_reactive_power", main = "")
dev.off()
