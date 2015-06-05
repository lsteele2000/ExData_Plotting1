
# The data set specified for the course assignment is loaded once and cached by the data_set() 
# function. The conditional is to avoid invalidating the cache if it's already loaded
if (!exists( "data_set" ))
{
    source("data_set.R")  # Peer reviewers can find the loading code in the sourced file
}

# outputs the plot1 function to the plot1.png (by default)
plot1_to_png <- function(plotfunc=plot1, filename="plot1.png") {
  png( filename , height=480, width=480 )
  plotfunc()
  dev.off()
}

# create plot1 (histogram of global active power) using the base graphics package.
plot1 <- function() {
  with( data_set(),
        hist( Global_active_power, 
          col = "red", 
          main="Global Active Power",
          xlab = "Global Active Power (kilowatts)"
          )
      )    
}
