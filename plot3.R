plot3<-function(){
        # Read the data from 2007-02-01 to 2007-02-02 in the file 
        library(data.table)
        dtime<- difftime(as.POSIXct("2007-02-03"),as.POSIXct("2007-02-01"),units="mins")
        RowstoRead <- as.numeric(dtime)
        DT<-fread("household_power_consumption.txt",skip="1/2/2007",nrows=RowstoRead,na.string=c("?",""))
        #add name to subset
        setnames(DT, colnames(fread("household_power_consumption.txt", nrows=0)))
        library(dplyr)
        DTdp <-tbl_df(DT)
        #add a new col called Dtime that contained converted time contents that from
        #col "Date" and "Time"        
        Datetime<- strptime(paste(DTdp$Date,DTdp$Time), "%d/%m/%Y %H:%M:%S")
        mutate(DTdp, Dtime=as.POSIXct(Datetime))
        #drawing the plot3 
        plot(DTdp$Dtime,DTdp$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
        points(DTdp$Dtime,DTdp$Sub_metering_2,type="l",col="red")
        points(DTdp$Dtime,DTdp$Sub_metering_3,type="l",col="blue")
        legend("topright",pch="-",col= c("black","red","blue"),legend=  c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        #copy to plot3.png 
        dev.copy(png,file="plot3.png")
        dev.off()
        
}