# Normally my functions would be in another file but as per
# assignment I included them
#

load_data <- function(){
    mydata<-read.table('data/household_power_consumption.txt', sep=';',nrows=1, 
                       header=TRUE)
    data_colnames <- colnames(mydata)
    setAs("character","myTime", function(from) as.Date(from, format="%H:%M:%S"))
    setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
    colClasses <- c('myDate', 'myTime', 'numeric', 'numeric', 'numeric', 
                    'numeric', 'numeric', 'numeric', 'numeric')
    read.table('data/household_power_consumption.txt', sep=';',nrows=60*24*2,
               header=TRUE, colClasses = colClasses, 
               col.names=data_colnames, skip=36+60*6+60*24*46, 
               na.strings="?")
}
mydata<-load_data()

png('plot1.png', width=480, height=480, units='px')
hist(mydata$Global_active_power, col='red', xlab='Global Active Power (kilowatts)', main = 'Global Active Power')
dev.off()