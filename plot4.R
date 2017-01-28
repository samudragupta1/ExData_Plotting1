## R script to read in data from the household_power_consumption.txt file.
## The data is read and then processed and plotted
## The plot is then converted to a png file of 480x480 pixels dimension

## First read the data 
mytab <- read.table("./ExpDataWeek1/household_power_consumption.txt",header=TRUE,sep=";")


## Convert the date from string to date format.
mytab$Date <- as.Date(mytab$Date,"%d/%m/%Y")

## Create a subset with only 2007-02-01 and 2007-02-02
df <- mytab[(mytab$Date=="2007-02-01") | (mytab$Date=="2007-02-02"),]

## Concatenate date and timestamp
df <- transform(df, ts=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

## Convert the submetering 1,2,3 value to a numeric value
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

## Convert Global Active Power to numeric value
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))

## Convert Global Reactive Power to numeric value
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))

## Convert voltage to numeric
df$Voltage <- as.numeric(as.character(df$Voltage))

## Set the graphical parameters
par(mfrow=c(2,2))

##Plot number 1
plot(df$ts,df$Global_active_power, type="l", xlab="", ylab="Global Active Power")

##Plot number 2
plot(df$ts,df$Voltage, type="l", xlab="datetime", ylab="Voltage")

##Plot number 3
plot(df$ts,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")

## Paint Submetering 2 in blue
lines(df$ts,df$Sub_metering_2,col="red")

## Paint Submetering 3 in blue
lines(df$ts,df$Sub_metering_3,col="blue")

## Add the legend the the plot
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly

#PLOT 4
plot(df$ts,df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

## Copy to a png file.
dev.copy(png, file="ExpDataWeek1/trunk/plot4.png", width=480, height=480)

## Turn off the device.
dev.off()
