##################
##################  This analysis is based on data from the National Emissions Inventory (NEI)
##################  The chart answers to question: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
##################



#### Checking if rds files exists in working directory. If not than download and unzip them 
if (!(file.exists("Source_Classification_Code.rds") && file.exists("summarySCC_PM25.rds")))  {
      print("Data not found, trying to download and unzip them.")
      fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
      download.file(fileUrl, destfile = "dataset.zip")
      unzip("dataset.zip")
      print("Data downloaded and unziped.")
      }


### Reading data 
NEI <- readRDS("summarySCC_PM25.rds")


### Calculation total of PM2.5 by year 
mn0<-with(NEI, tapply(Emissions, year, sum, na.rm=TRUE))

### Plotting to screen
plot(c("1999","2002","2005","2008"),mn0,xlab = "Year", ylab = "Total of PM2.5 in tons", main = "Total of PM2.5 in tons for USA")

### Copy plot to file

dev.copy(png,'plot1.png')
dev.off()
