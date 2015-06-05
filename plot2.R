
# Same structure as plot1.R ... wouldn't repeat so much typically 

# The data set specified for the course assignment is loaded once and cached by the data_set() 
# function. The conditional is to avoid invalidating the cache if it's already loaded
if (!exists( "data_set" ))
{
    source("data_set.R")  # Peer reviewers can find the loading code in the sourced file
}

# outputs the plot2 function (defined below) to the plot2.png (by default)
plot2_to_png <- function(plotfunc=plot2, filename="plot2.png") {
    png( filename , height=480, width=480 )
    plotfunc()
    dev.off()
}

# create plot2 (line graph global active power vrs time) using the base graphics package.
# long_ylab param to allow fixup of ylab for reuse of function in plot4
plot2 <- function(long_ylab=TRUE) {
    
    ylab = "Global Active Power"
    if (long_ylab) ylab<-paste(ylab, "(kilowatts)")
    
    dt<-data_set()
    with( dt,
          plot( 1:nrow(dt), Global_active_power, 
                type='l',
                xaxt="n",
                ylab=ylab, xlab=""
          )
    )
    with( wkday_axis_values(dt),
        axis( side=1, at=breaks, labels = labs)
    )
          
}

wkday_axis_values <-function(dt) {
    
    labels <- unique(dt$wkday)
    breaks <- match(labels, dt$wkday )
    labels<-c(labels,"Sat")
    breaks<-c(breaks, nrow(dt))
    data.table( labs=labels, breaks=breaks )
 
}
