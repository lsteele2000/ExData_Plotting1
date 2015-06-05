
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
plot2 <- function(long_ylab=TRUE) {
  dt<-data_set()
  x_scale= 1:nrow(dt)
  ylab = "Global Active Power"
  if (long_ylab) ylab<-paste(ylab, "(kilowatts)")
  plot( x_scale, dt$Global_active_power, , type='l',ylab=ylab, xlab="")
}

