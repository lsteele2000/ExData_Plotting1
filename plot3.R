
# Same structure as plot1.R & plot2.R ... cut and paste to conform to expectations

# The data set specified for the course assignment is loaded once and cached by the data_set() 
# function. The conditional is to avoid invalidating the cache if it's already loaded
if (!exists( "data_set" ))
{
    source("data_set.R")  # Peer reviewers can find the loading code in the sourced file
}

# outputs the plot3 function (defined below) to the plot3.png (by default)
plot3_to_png <- function(plotfunc=plot3, filename="plot3.png") {
    png( filename , height=480, width=480 )
    plotfunc()
    dev.off()
}

# create plot3 using the base graphics package
# legend_border parameter to allow use for the panel in plot4
plot3<-function(legend_border=TRUE) {
    
    dt=data_set()
    pcolors <-  c("black", "red", "blue")
    pnames  <-  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    plot( 1:nrow(dt), dt[[ pnames[1] ]], col=pcolors[1], type='l',
          xaxt="n", xlab="",
          ylab="Energy sub metering"
    )
    points( 1:nrow(dt), dt[[ pnames[2] ]], col=pcolors[2], type='l')
    points( 1:nrow(dt), dt[[ pnames[3] ]], col=pcolors[3], type='l')
    
    with( wkday_axis_values(dt), axis( side=1, at=breaks, labels = labs) )
    
    border<-ifelse(legend_border, "0", "n")
    legend("topright", col=pcolors, legend=pnames, pch=151, bty=border )
}

# hack to get the breaks/labels for the wkdays
wkday_axis_values <-function(dt) {
    
    labels <- unique(dt$wkday)
    breaks <- match(labels, dt$wkday )
    labels<-c(labels,"Sat")
    breaks<-c(breaks, nrow(dt))
    data.table( labs=labels, breaks=breaks )
 
}
