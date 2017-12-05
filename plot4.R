library(dplyr)

fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileURL,temp)
unzip(temp)

elec_consumption <- read.table(".\\exdata_2Fdata%2Fhousehold_power_consumption\\household_power_consumption.txt",header=FALSE,na.strings = "?", sep=";",skip=grep("1/2/2007",readLines("household_power_consumption.txt")),nrows = 2879)

ec_df <- elec_consumption %>% rowwise() %>% mutate(datetime = paste(Date,Time))
ec_df$datetime = strptime(ec_df$datetime,"%Y-%m-%d %H:%M:%S")

png("plot4.png",width=480,height=480,units="px")

par(mfrow=c(2,2))
plot(ec_df$datetime,ec_df$Global_active_power,type="n",xlab=" ",ylab="Global Active Power")
lines(ec_df$datetime,ec_df$Global_active_power)
plot(ec_df$datetime,ec_df$Voltage,type="n",xlab="datetime",ylab="Voltage")
lines(ec_df$datetime,ec_df$Voltage)
plot(ec_df$datetime,ec_df$Sub_metering_1,type ="n",xlab = " ", ylab="Energy Sub Metering",ylim=c(0,40))
lines(ec_df$datetime,ec_df$Sub_metering_1)
lines(ec_df$datetime,ec_df$Sub_metering_2,col="red")
lines(ec_df$datetime,ec_df$Sub_metering_3,col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black","red","blue"),lwd=2)
plot(ec_df$datetime,ec_df$Global_reactive_power,type="n",xlab="datetime",ylab="Global_reactive_power")
lines(ec_df$datetime,ec_df$Global_reactive_power)

dev.off()