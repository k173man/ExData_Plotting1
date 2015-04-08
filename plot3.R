library(sqldf)

f <- file("household_power_consumption.txt")
hpc <- sqldf(
    "select * from f where Date = '1/2/2007' or Date = '2/2/2007'", 
    dbname = tempfile(), 
    file.format = list(sep = ";", header = T, row.names = F)
)
close(f)

hpc$datetime <- strptime(paste(hpc$Date, hpc$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

png(filename = "plot3.png")
with(hpc, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
with(hpc, lines(datetime, Sub_metering_1, col = "black"))
with(hpc, lines(datetime, Sub_metering_2, col = "red"))
with(hpc, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()