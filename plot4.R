##
##RNofal
##This is the work area where the input files resides
workArea <- "C:/ramziPri/R_workarea/Exploratory_Data_Analysis/proj1"
fileName <-"household_power_consumption.txt"
pngOutFile <-"plot4.png"
# The following variable describes the starting and ending dates of the processed data.

sdate <- "1/2/2007" 
edate <- "2/2/2007"
#Make sure the workarea is set properly
setwd(workArea)
hpc <- read.table(fileName,header=TRUE,sep=";",stringsAsFactors=FALSE, dec=".")
#Subset the data to extract only the rows between sdate and edate
ss_hpc <- subset(hpc,Date==sdate | Date ==edate)
#extract the Global_active_power from the our data in the Date range, and convert it to numeric 
gap <- as.numeric(ss_hpc$Global_active_power)

#now extract the date and time, and concatenate them.
#Format of date is 1/2/2007 for day/month/year 
dt <- strptime(paste(ss_hpc$Date, ss_hpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#In this plot we need 'dt' aganist Sub_metering_1, Sub_metering_2 and Sub_metering_3 on the same plot
#First need to extract the 3 columns and convert them to numeric. 
sm1 <- as.numeric(ss_hpc$Sub_metering_1)
sm2 <- as.numeric(ss_hpc$Sub_metering_2)
sm3 <- as.numeric(ss_hpc$Sub_metering_3)

#Create a graphic device PNG
#png(filename = "Rplot%03d.png",
#   width = 480, height = 480, units = "px", pointsize = 12,
#    bg = "white", res = NA, family = "", restoreConsole = TRUE,
#    type = c("windows", "cairo", "cairo-png"), antialias)
png(pngOutFile, width=480, height=480) # need to specify widith, height as 480, 480 respectivly 

#In this section we need to add 4 plots 2x2, therefore we need to use mfrow=c(2,2)
par(mfrow = c(2,2))
#the type argument of plot is to indicates what type of plot should be drawn, in this case we need "l" for lines
#The X-axis is not set  therefore make it an empty string
#In order to plot dt with sm1 and sm2, and sm3
#First we plot dt with sm1 , and here X-axis is an empty string 
#Then in order add series lines that have the same x and y ranges, lines() will do the job
#Plot 1 and 3 are the same as the plot from plot2.R and plot3.R respectively.
#Plot 1,1 date time vs Global Active power xlab has no name
plot(dt,gap,type="l", xlab="",ylab="Global Active Power")

#Plot 1,2 date time vs Voltage (converted to numeric)  where voltage is the column "Voltage" from the data frame. 
plot(dt, as.numeric(ss_hpc$Voltage), type="l", xlab="datetime", ylab="Voltage")

#plot 2,1 is exatly as plot3.R

plot(dt,sm1,type="l", col="black",xlab="",ylab="Energy sub metering")
lines(dt,sm2,type="l", col="red")
lines(dt,sm3,type="l", col="blue")
#Finally add the legend
#lty, lwd the line types and widths for lines appearing in the legend. One of these two must be specified for line drawing.
#bty is type of the box to be drawn , value ="n" , no box will be drawn.
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red",'blue'),lty=1,lwd=2,bty="n")


#plot 2,2 is plot between dt and Global_reactive_power (converted to numeric)
plot(dt, as.numeric(ss_hpc$Global_reactive_power), type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off() #Release the device
