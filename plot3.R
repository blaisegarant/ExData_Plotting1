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
get_tickers <- function(date_vector){
    days <- c(unique(date_vector), tail(date_vector, n=1)+1)
    positions <- c(mapply(function(a){min(which(date_vector==a))}, days[1:2]), 
                   length(date_vector)+1)
    labels <- mapply(function(a){substr(weekdays(a),1,3)}, days)
    list(positions=positions, labels=labels)
}
add_weekday_axis <- function(date_vector){
    tickers<-get_tickers(date_vector)
    axis(1,tickers$positions, tickers$labels)
}
mydata<-load_data()


png('plot3.png', width=480, height=480, units='px')
plot(mydata$Sub_metering_1, type='n', xaxt='n', xlab='', ylab='Energy sub metering')
lines(mydata$Sub_metering_1, col='black')
lines(mydata$Sub_metering_2, col='red')
lines(mydata$Sub_metering_3, col='blue')
legend('topright', lty=1, col=c('black','red', 'blue'), legend=tail(names(mydata),n=3))
add_weekday_axis(mydata$Date)
dev.off()