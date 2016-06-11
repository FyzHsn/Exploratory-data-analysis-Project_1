## Data Information
## ================
## We will be using the individual household electric power consumption data
## set. The data set contains measurements of electric power consimption in
## one household with a one minute sampling rate over a period of almost 
## 4 years. Different electrical quantities and some sub-metering values are
## available. Descriptions of the 9 variables in the dataset:
## 1. Date: Date in format dd/mm/yyyy
## 2. Time: time in format hh:mm:ss
## 3. Global_active_power: household global minute-averaged reactive power (in kilowatts)
## 4. Global_reactive_power: household global minute-averaged reactive power (in kilowatts)
## 5. Voltage: minute-averaged voltage (in volt)
## 6. Global_intensity: household global minute-averaged current intensity (in ampere)
## 7. Sub_metering_1: energy sub-metering No.1(in watt-hour of active energy)
##    It corresponds to the kitchen, mainly a dishwasher, an oven, and a microwave.
## 8. Sub_metering_2: energy sub-metering No.2(in watt-hour of active energy)
##    It corresponds to the laundry room, containing a washing-machine, a tumble-drier,
##    a refrigerator and a light.
## 9. Sub_metering_3: energy sub-metering No.3(in watt-hour of active energy)
##    It corresponds to an electric water-heater and an air-conditioner.
       
## Loading the data
## ================
## * The dataset has 2,075,259 rows and 9 columns. Make sure your computer 
##   has enough memory.
## * We will only be using data from the dates 2007-02-01 and 2007-02-02. One
##   alternative is to read the data from just those dates rather than reading
##   the entire dataset and subsetting to those dates.
## * You may find it useful to convert the Date and Time variables to 
##   Date/Time classes in R using the strptime() and as.Date() functions. 
## * Note that in this dataset missing values are coded as ?.

## Assignment - Making plots
## =========================
## Our goal is to examine how household energy usage varies over a 2-day period
## in February, 2007. Your task is to reconstruct the plots outlined below.
## Use the base plotting system. 
## Step 1 - Fork and clone the Github repository: "https://github.com/rdpeng/ExData_Plotting1"  
## Step 2 - Construct the plots and save it to a PNG file with a width of
##          480 pixels and a height of 480 pixels names plot1.png etc.
## Step 3 - Create a separate R code file (plot1.R, plot2.R, etc) that 
##          constructs the corresponding plot, i.e code in plot1.R constructs
##          the plot1.png plot. The code should include the code for reading 
##          the data. Furthermore, include that code that create the PNG file.
## Step 4 - Add the PNG file and R code file to your git repository.

## Plot 1 - Global active power (kilowatts) histogram plots.
## Plot 2 - Global active power (kilowatts) line plot over two days.
## Plot 3 - Energy sub metering over two days with legends black, red and blue.
## Plot 4 - A panel of four plots - (1, 1) Plot 1, (1, 2) Voltage over 
##          datetime, (2, 1) Plot 3, (2, 2) Global_reactive_power over datetime.


## Read in the data to check out the structure of the data 
filename <- "~/JHU_Data_Science/Course_4/Data/exdata_data_household_power_consumption/household_power_consumption.txt"
tempdata <- read.table(filename, header = TRUE, sep = ";", dec = ".", na.strings = "?")
library(lubridate)
tempdata[, 1] <- as.Date(tempdata[, 1], format = "%d/%m/%Y")
tempdata[, 2] <- strptime(tempdata[, 2], format = "%H:%M:%S")
data <- tempdata[which((tempdata[, 1] == "2007-02-01") | (tempdata[, 1] == "2007-02-02")), ]
dim(data)
names(data)
str(data)
head(data)

## Plot 1 - png file with width and height of 480 pixels
png("~/JHU_Data_Science/Course_4/Data/plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()

## Plot 2
png("~/JHU_Data_Science/Course_4/Data/plot2.png", width = 480, height = 480)
datetime <- paste(data$Date, data$Time)
plot(as.POSIXct(datetime), data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

## Plot 3
png("~/JHU_Data_Science/Course_4/Data/plot3.png", width = 480, height = 480)
plot(as.POSIXct(datetime), data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(as.POSIXct(datetime), data$Sub_metering_2, col = "red")
lines(as.POSIXct(datetime), data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"))
dev.off()

## Plot 4
png("~/JHU_Data_Science/Course_4/Data/plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
datetime <- paste(data$Date, data$Time)
plot(as.POSIXct(datetime), data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(as.POSIXct(datetime), data$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
plot(as.POSIXct(datetime), data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(as.POSIXct(datetime), data$Sub_metering_2, col = "red")
lines(as.POSIXct(datetime), data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"), bty = "n")
plot(as.POSIXct(datetime), data$Global_reactive_power, type = "l", xlab = "", ylab = "Global_reactive_power")
dev.off()
