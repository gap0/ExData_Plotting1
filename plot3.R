
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
#Plot the data:

# open png graphik device
png(filename = 'plot3.png',width = 480, height = 480)
# set transparent background like in the example
par(bg="transparent")

# Plot
plot(df$datetime, 
     df$Sub_metering_1, 
     type = "l", 
     xlab='', ylab="Energy sub metering")

# Add other columns
lines(df$datetime, df$Sub_metering_2, type="l", col='red')
lines(df$datetime, df$Sub_metering_3, type="l", col='blue')

# Add legend to plot
legend(x = "topright", 
       legend = colnames(df)[7:9],
       col=c("black","red","blue"),
       lty = 1,
      
)
# Close device
dev.off()
