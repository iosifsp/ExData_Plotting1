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

#set graphic device
png("plot1.png")

#draw the histogram 
hist(df$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()
