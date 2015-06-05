
library(dplyr)
library(lubridate)
library(sqldf)

env<-new.env()
assign("cached_data", NULL, envir=env)

#### 'public' section ####
# data_set()
#   returns a copy of our data set ready for munching
data_set <- function()
{
    if (is.null( get("cached_data", env) ) )
    {
        message("Loading source data")
        evalq(cached_data<-load_source(), env );
    }
    copy(get("cached_data",env))
}

flush_cache<-function()
{
  evalq(cached_data<-NULL,env)
}
#### end public ######

# low level method to load the project data set.
# downloads/unzips from remote site into ./Data as required
# returns a data.table filtered to the project/specified 1/1/2007 -- 1/2/2007 table entries
load_source <- function(
    srcName = "household_power_consumption.txt",
    destDir="Data", 
    forceDownload=FALSE)
{
  path = file.path( destDir,srcName)
  if ( !file.exists(path) || forceDownload )
  {
    message("Downloading project data ...")
    remoteFile = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    temp <- tempfile()
    download.file(remoteFile,temp)
    unzip(temp,overwrite = TRUE,exdir= destDir)
    unlink(temp)
    if ( !file.exists(path))
    {
      error( sprintf( "Target file \"%s\" not found", path))
    }
  }
  f<-file(path)
  dt<-tbl_df( sqldf("select * from f where Date like '1/2/2007' or Date like '2/2/2007'", 
        dbname=tempfile(), file.format=list(header=T,row.names=F,sep=";"))
    )
  close(f)
  fixup_(dt)
}

# stub for any additional modification needed to the input set
fixup_ <-function( dt ) {
  # add day of week into table
  dt %>% mutate( wkday = weekdays( as.Date(Date,"%d/%m/%Y"), abbreviate = T))
}

