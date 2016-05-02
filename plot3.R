library(data.table)

#read the dates only from the file
initial <- fread("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", select = c(1))

#find the first number of row of date 1/2/2007
start <- min(which(initial == "1/2/2007"))

#fild the last number of row of date 2/2/2007
end <- max (which(initial == "2/2/2007"))
number_rows = end - start + 1

#Read a small protion of the data for obtaining the column names and column classes
initial <- fread("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
       data.table = FALSE,  nrow = 3)
col_names <- colnames(initial)

#free memory
rm(initial)

#read the data for the speciphic dates
df <- fread("household_power_consumption.txt", sep = ";", na.strings = "?",
            data.table = FALSE, header = FALSE,  skip = start, 
            nrows = number_rows, col.names = col_names)

df$Date <- paste(df$Date,df$Time, sep= " ")

df$Date <- as.POSIXlt(strptime(df$Date, "%d/%m/%Y %H:%M:%S"))

#set graphic device
png("plot3.png")

#draw the histogram 
plot(x=df$Date,y= df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x=df$Date,y= df$Sub_metering_2, type = 'l', col = "red")
lines(x=df$Date,y= df$Sub_metering_3, type = 'l', col = "blue")
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lwd = 1, col = c("black", "red", "blue"))

dev.off()
