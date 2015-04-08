library(sqldf)

f <- file("household_power_consumption.txt")
hpc <- sqldf(
    "select * from f where Date = '1/2/2007' or Date = '2/2/2007'", 
    dbname = tempfile(), 
    file.format = list(sep = ";", header = T, row.names = F)
)
close(f)

hpc$datetime <- strptime(paste(hpc$Date, hpc$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

png(filename = "plot2.png")
with(hpc, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()