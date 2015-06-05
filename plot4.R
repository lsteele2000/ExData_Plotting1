
# Same as plot1.R & plot2.R & plot3.R, ... 
# except we'll source plot2.R and plot3.R since they're subplots.

source("plot2.R")
source("plot3.R")

# The data set specified for the course assignment is loaded once and cached by the data_set() 
# function. The conditional is to avoid invalidating the cache if it's already loaded
if (!exists( "data_set" ))
{
  source("data_set.R")  # Peer reviewers can find the loading code in the sourced file
}

# outputs the plot4 function (defined below) to the plot4.png (by default)
plot4_to_png <- function(plotfunc=plot4, filename="plot4.png") {
  png( filename, height=480, width=480 )
  plotfunc()
  dev.off()
}

# create plot4 using the base graphics package,
plot4<-function() {
  par(mfcol = c( 2, 2)) # XXX believe this is a a global setting, verify

  plot2(long_ylab=FALSE)
  plot3(legend_border=FALSE)
  plot_voltage_vs_time()
  plot_reactive_vs_time()
  par(mfcol = c( 1,1 )) # lazy restore (if global), should have saved initial vals above
}

plot_voltage_vs_time<-function() {
  dt<-data_set()
  x_scale= 1:nrow(dt)
  with(dt, plot( x_scale, Voltage,type='l', xlab="datetime") )
}

plot_reactive_vs_time<-function() {
  dt<-data_set()
  x_scale= 1:nrow(dt)
  with(dt, plot( x_scale, Global_reactive_power,type='l', xlab="datetime") )  
}
