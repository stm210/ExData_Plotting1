## Plot 2
## Global Active Power

hpc_data <- read.table("household_power_consumption.txt", header= TRUE, sep=";", nrows = 2075259, )

names(hpc_data)[1] <- "record_date"
names(hpc_data)[2] <- "record_time"

hpc_data$record_date <- as.Date(as.character(hpc_data$record_date), '%d/%m/%Y')
hpc_data$date_time <- as.POSIXct(paste(hpc_data$record_date, hpc_data$record_time), format="%Y-%m-%d %H:%M:%S")

hpc_data_dates <- subset(hpc_data, record_date >= '2007-02-01' & record_date <= '2007-02-02')

hpc_data_dates$Global_active_power <- as.character(hpc_data_dates$Global_active_power)

hpc_data_dates$Global_active_power[hpc_data_dates$Global_active_power == "?"] <- NA 
hpc_data_dates <- hpc_data_dates[complete.cases(hpc_data_dates$Global_active_power), ] 

hpc_data_dates$Global_active_power <- as.numeric(hpc_data_dates$Global_active_power)

png("plot2.png", width= 480, height = 480, units = "px")
with(hpc_data_dates, plot(date_time,Global_active_power, type = "l",
                            ylab = "Global Active Power (kilowatts)", xlab = ""))

dev.off()