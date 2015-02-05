data <- read.table("household_power_consumption.txt", header=T, sep=";", dec=".")



#2007-02-01 and 2007-02-02


data[, "Date"] <- as.Date(data[, "Date"],format = "%d/%m/%Y")

mydate1 <- factor("01/02/2007")
as.Date(mydate1, format = "%d/%m/%Y")
mydate2 <- factor("02/02/2007")
as.Date(mydate2, format = "%d/%m/%Y")
dates1 = which(data[, "Date"]==as.Date(mydate1, format = "%d/%m/%Y"))
dates2 = which(data[, "Date"]==as.Date(mydate2, format = "%d/%m/%Y"))
fil <- data[c(dates1,dates2),]

DT <- paste(as.character(fil$Date), as.character(fil$Time))
Date_Time <- strptime(DT, "%Y-%m-%d %H:%M:%S")

fil[,"Date"]  <- as.data.frame(Date_Time)
fil <- fil[,-which(colnames(fil)=="Time")]
colnames(fil)[which(colnames(fil)=="Date")] <- "Date_Time"

Sys.setlocale("LC_TIME", "English")

wkdays <- c("Thu", "Fri", "Sat")

fil[,"Global_reactive_power"] <- as.numeric(as.character(fil$Global_reactive_power))
fil[,"Voltage"] <- as.numeric(as.character(fil$Voltage))
fil[,"Global_intensity"] <- as.numeric(as.character(fil$Global_intensity))
fil[,"Sub_metering_1"] <- as.numeric(as.character(fil$Sub_metering_1))
fil[,"Sub_metering_2"] <- as.numeric(as.character(fil$Sub_metering_2))

par(mar=c(4, 5, 0.9, 1))
par(mfcol=c(2,2))
TS <- ts(as.numeric(as.character(fil$Global_active_power)))
plot(TS,  xaxt = "n", xlab= NULL, ylab="Global Active Power (kilowatts)")
axis(1, at=c(1, 1441, 2881), labels=wkdays)

fil[,"Sub_metering_1"] <- as.numeric(as.character(fil$Sub_metering_1))
fil[,"Sub_metering_2"] <- as.numeric(as.character(fil$Sub_metering_2))
Sub_metering <- fil[, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]
TS1 <- ts(Sub_metering)
ts.plot(TS1, gpars=list(xaxt = "n", xlab= NULL, ylab="Energy sub metering",  col = c("black", "red", "blue")))
axis(1, at=c(1, 1441, 2881),  labels=wkdays)
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red","blue"), cex=0.5, bty = "n")

TS2 <- ts(fil[,"Voltage"])
plot(TS2, xaxt = "n", xlab= "datetime", ylab="Voltage")
axis(1, at=c(1, 1441, 2881), labels=wkdays)

TS3 <- ts(fil[,"Global_reactive_power"])
plot(TS3, xaxt = "n", xlab= "datetime", ylab="Global_reactive_power")
axis(1, at=c(1, 1441, 2881), labels=wkdays)

dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
