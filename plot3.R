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

## Create the line plot
## Submetering 1
plot(df$ts,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")

## Paint submetering 2 in red
lines(df$ts,df$Sub_metering_2,col="red")

## Paint Submetering 3 in blue
lines(df$ts,df$Sub_metering_3,col="blue")

## Add the legend the the plot
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

## Copy to a png file.
dev.copy(png, file="ExpDataWeek1/trunk/plot3.png", width=480, height=480)

## Turn off the device.
dev.off()
