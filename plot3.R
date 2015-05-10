##Plot 3
##Submetering

hpc_data <- read.table("household_power_consumption.txt", header= TRUE, sep=";", nrows = 2075259, )

names(hpc_data)[1] <- "record_date"
names(hpc_data)[2] <- "record_time"

hpc_data$record_date <- as.Date(as.character(hpc_data$record_date), '%d/%m/%Y')
hpc_data$date_time <- as.POSIXct(paste(hpc_data$record_date, hpc_data$record_time), format="%Y-%m-%d %H:%M:%S")

hpc_data_dates <- subset(hpc_data, record_date >= '2007-02-01' & record_date <= '2007-02-02')

##fix vars
hpc_data_dates$Sub_metering_1 <- as.numeric(as.character(hpc_data_dates$Sub_metering_1))
hpc_data_dates$Sub_metering_2 <- as.numeric(as.character(hpc_data_dates$Sub_metering_2))
hpc_data_dates$Sub_metering_3 <- as.numeric(as.character(hpc_data_dates$Sub_metering_3))

png("plot3.png", width= 480, height = 480, units = "px")
with(hpc_data_dates,  plot(date_time,Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
lines(hpc_data_dates$date_time,hpc_data_dates$Sub_metering_2, type = "l", col="red")
lines(hpc_data_dates$date_time,hpc_data_dates$Sub_metering_3, type = "l", col = "blue")

legend("topright",  c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),
       col=c("black", "blue","red"),
        pt.cex=1, cex=0.75
       )

dev.off()
