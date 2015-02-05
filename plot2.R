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
class(DT)
Date_Time <- strptime(DT, "%Y-%m-%d %H:%M:%S")

fil[,"Date"]  <- as.data.frame(Date_Time)
fil <- fil[,-which(colnames(fil)=="Time")]
colnames(fil)[which(colnames(fil)=="Date")] <- "Date_Time"

Sys.setlocale("LC_TIME", "English")

wkdays <- c("Thu", "Fri", "Sat")

TS <- ts(as.numeric(as.character(fil$Global_active_power)))
plot(TS,  xaxt = "n", xlab= NULL, ylab="Global Active Power (kilowatts)")
axis(1, at=c(1, 1441, 2881), labels=wkdays)

dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
