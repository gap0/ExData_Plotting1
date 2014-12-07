
#Read the date from the textfile in a dataframe
data <- read.csv("household_power_consumption.txt", header = TRUE, sep=";")

#Convert the Date column to Date datatype
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Select the requested date times
data_sub1 <- subset(data, Date == as.Date("2007-02-01"))
data_sub2 <- subset(data, Date == as.Date("2007-02-02"))
#merge the dataframes (there must be a simpler solution, I know.;))
df <- rbind(data_sub1, data_sub2) 

#Data Conversion:
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
#Add column datetime to data frame
x <- paste(df$Date, df$Time)
df$datetime <- strptime(x, "%Y-%m-%d %H:%M:%S")
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))

#Plot the data in png device:
# open png graphik device
png(filename = 'plot4.png',width = 480, height = 480)
# set transparent background like in the example
par(mfrow = c(2,2))
par(bg="transparent")

# Plot1
plot(df$datetime,
     df$Global_active_power, 
     type='l',
     xlab='', 
     ylab="Global Active Power"
)
#Plot2
plot(df$datetime, 
     df$Voltage, 
     type = "l", 
     xlab='datetime', 
     ylab="Energy sub metering"
)
#Plot3
plot(df$datetime, 
     df$Sub_metering_1, 
     type = "l", 
     xlab='', ylab="Energy sub metering")
lines(df$datetime, df$Sub_metering_2, type="l", col='red')
lines(df$datetime, df$Sub_metering_3, type="l", col='blue')
legend(x = "topright", 
       legend = colnames(df)[7:9],
       col=c("black","red","blue"),
       lty = 1,
       bty='n'
)
#Plot4
plot(df$datetime, 
     df$Global_reactive_power, 
     type = "l", 
     xlab='datetime', 
     ylab="Global_reactive_power"
)

# Close device
dev.off()
