plot2<-function(){
        # Read the data from 2007-02-01 to 2007-02-02 in the file 
        library(data.table)
        dtime<- difftime(as.POSIXct("2007-02-03"),as.POSIXct("2007-02-01"),units="mins")
        RowstoRead <- as.numeric(dtime)
        # Data file was stored at default directory
        DT<-fread("household_power_consumption.txt",skip="1/2/2007",nrows=RowstoRead,na.string=c("?",""))
        #add name to subset
        setnames(DT, colnames(fread("household_power_consumption.txt", nrows=0)))
        library(dplyr)
        DTdp <-tbl_df(DT)
        #add a new col called Dtime that contained converted time contents that from
        #col "Date" and "Time"        
        Datetime<- strptime(paste(DTdp$Date,DTdp$Time), "%d/%m/%Y %H:%M:%S")
        Dtdp<-mutate(DTdp, Dtime=as.POSIXct(Datetime))
        #drawing the plot2 
        png(file="plot2.png", width=480, height=480, units="px") 
        plot(DTdp$Dtime,DTdp$Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)")
        dev.off()
        
}