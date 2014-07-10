# plot1.R generates plot1.png, the histogram for Global Active Power on
# 2007-02-01 and 2007-02-02.

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

# Make the PNG histogram plot
png(filename = "plot1.png")
hist(twodaydata$GAP, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col="red")
dev.off()