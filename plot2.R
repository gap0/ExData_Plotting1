
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

#Plot the data:
# open png graphik device
png(filename = 'plot2.png',width = 480, height = 480)
# set transparent background like in the example
par(bg="transparent")

# Plot
plot(df$datetime, 
     df$Global_active_power, 
     type = "l", 
     xlab='', ylab="Global Active Power (kilowatts)")
# Close device
dev.off()
