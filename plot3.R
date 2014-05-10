### Read data from household_power_consumption.txt, which has to be located in your working directory
Data<-read.table(file="./household_power_consumption.txt",sep=";",header=F, as.is=T, 
                 col.names=c("Date", "Time", "Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
Data<-Data[2:2075260,]

### Take data from the dates 2007-02-01 and 2007-02-02
cleanData<-Data[as.Date(Data$Date,"%d/%m/%Y")>=as.Date("2007-02-01"),]
cleanData<-cleanData[as.Date(cleanData$Date,"%d/%m/%Y")<=as.Date("2007-02-02"),]

### Change classes of variables
cleanData[,1]<-as.POSIXct(strptime(paste(cleanData[,1],cleanData[,2]), "%d/%m/%Y%H:%M:%S"))
cleanData[,3]<-as.numeric(cleanData[,3])
cleanData[,4]<-as.numeric(cleanData[,4])
cleanData[,5]<-as.numeric(cleanData[,5])
cleanData[,6]<-as.numeric(cleanData[,6])
cleanData[,7]<-as.numeric(cleanData[,7])
cleanData[,8]<-as.numeric(cleanData[,8])
cleanData[,9]<-as.numeric(cleanData[,9])
cleanData<-cleanData[,c(1,3,4,5,6,7,8,9)]

### Create Plot 2
png(filename = "plot3.png", width = 480, height = 480,
    units = "px", pointsize = 12, bg = "white", res = NA,
    restoreConsole = TRUE)

###
yrange<-range(c(cleanData$Sub_metering_1,cleanData$Sub_metering_2,cleanData$Sub_metering_3))

plot(cleanData[,1],cleanData$Sub_metering_1,type="l",ylab = "Energy sub metering",ylim=yrange,xlab="")
par(new=TRUE)
plot(cleanData[,1],cleanData$Sub_metering_2,type="l",ylab = "Energy sub metering",ylim=yrange,xlab="",col="red")
par(new=TRUE)
plot(cleanData[,1],cleanData$Sub_metering_3,type="l",ylab = "Energy sub metering",ylim=yrange,xlab="",col="blue")

legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
###

dev.copy(png,file="plot3.png")
dev.off()
dev.off()
