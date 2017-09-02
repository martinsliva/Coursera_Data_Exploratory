library(ggplot2)
library(dplyr)


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
SCC <- readRDS("Source_Classification_Code.rds")

### Creating subset of data for Baltimore City
pmBal<-subset(NEI,fips=="24510")

### Creating pivot table for sum
pivot<-summarise(group_by(pmBal,year,type), sum=sum(Emissions))

### Plotting to screen
qplot(year,sum, data = pivot, facets = .~type, main = "PM2.5 in tons in Baltimore by type of polution", ylab = "Sum of PM2.5 in tons")

### Copy plot to file

dev.copy(png,'plot3.png')
dev.off()

