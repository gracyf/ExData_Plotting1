library(dplyr)

fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileURL,temp)
unzip(temp)

elec_consumption <- read.table(".\\exdata_2Fdata%2Fhousehold_power_consumption\\household_power_consumption.txt",header=FALSE,na.strings = "?", sep=";",skip=grep("1/2/2007",readLines("household_power_consumption.txt")),nrows = 2879)

ec_df <- elec_consumption %>% rowwise() %>% mutate(datetime = paste(Date,Time))
ec_df$datetime = strptime(ec_df$datetime,"%Y-%m-%d %H:%M:%S")

png("plot3.png",width=480,height=480,units="px")

plot(ec_df$datetime,ec_df$Sub_metering_1,type ="n",xlab = " ", ylab="Energy Sub Metering")

lines(ec_df$datetime,ec_df$Sub_metering_1)
lines(ec_df$datetime,ec_df$Sub_metering_2,col="red")
lines(ec_df$datetime,ec_df$Sub_metering_3,col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black","red","blue"),lwd=2)

dev.off()