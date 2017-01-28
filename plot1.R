## R script to read in data from the household_power_consumption.txt file.
## The data is read and then processed and plotted
## The plot is then converted to a png file of 480x480 pixels dimension

## First read the data 
mytab <- read.table("./ExpDataWeek1/household_power_consumption.txt",header=TRUE,sep=";")

## Convert the date from string to date format.
mytab$Date <- as.Date(mytab$Date,"%d/%m/%Y")

## Create a subset with only 2007-02-01 and 2007-02-02
df <- mytab[(mytab$Date=="2007-02-01") | (mytab$Date=="2007-02-02"),]

## Convert the Global_active_power value to a numeric value
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))

## Create the histogram
hist(df$Global_active_power, main=paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")

## Copy to a png file.
dev.copy(png, file="ExpDataWeek1/trunk/plot1.png", width=480, height=480)

## Turn off the device.
dev.off()
