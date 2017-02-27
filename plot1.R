## Create folder:
if(!file.exists("./data")) {dir.create("./data")}
## Download file from the web:
fileUrl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")
## Unzip file:
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")
## Reading data only for the chosen dates:
files <- file("./data/household_power_consumption.txt")
subsetData <- read.table(text = grep("^[1,2]/2/2007", readLines(files), value = TRUE), sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')
## Check the subset data:
head(subsetData$Date)
## Convert the Date and Time variables to Date/Time classes:
subsetData$Date <- as.Date(subsetData$Date, format = "%d/%m/%Y")
class(subsetData$Date)
subsetData$Global_active_power <- as.numeric(as.character(subsetData$Global_active_power))
subsetData$Global_reactive_power <- as.numeric(as.character(subsetData$Global_reactive_power))
subsetData$Voltage <- as.numeric(as.character(subsetData$Voltage))
subsetData <- transform(subsetData, timestamp = as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
subsetData$Sub_metering_1 <- as.numeric(as.character(subsetData$Sub_metering_1))
subsetData$Sub_metering_2 <- as.numeric(as.character(subsetData$Sub_metering_2))
subsetData$Sub_metering_3 <- as.numeric(as.character(subsetData$Sub_metering_3))
hist(subsetData$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()