##
##RNofal
##This is the work area where the input files resides
workArea <- "C:/ramziPri/R_workarea/Exploratory_Data_Analysis/proj1"
fileName <-"household_power_consumption.txt"
pngOutFile <-"plot2.png"
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
#Create a graphic device PNG
#png(filename = "Rplot%03d.png",
#   width = 480, height = 480, units = "px", pointsize = 12,
#    bg = "white", res = NA, family = "", restoreConsole = TRUE,
#    type = c("windows", "cairo", "cairo-png"), antialias)
png(pngOutFile, width=480, height=480) # need to specify widith, height as 480, 480 respectivly 

#the type argument of plot is to indicates what type of plot should be drawn, in this case we need "l" for lines
#The X-axis is not set  therefore make it an empty string
with(ss_hpc,plot(dt,gap,type="l", xlab="",ylab="Global Active Power (kilowatts)"))
dev.off() #Release the device
