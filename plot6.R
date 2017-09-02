##################
##################  This analysis is based on data from the National Emissions Inventory (NEI)
##################  The chart answers to question: 
##################  Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County. 
##################  Which city has seen greater changes over time in motor vehicle emissions?
##################


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
pmBal_Cal<-subset(NEI,fips %in% c("24510", "06037"))

### Creating index of SCC for Motor vehicles
motor<-SCC[grep("Vehicles",SCC$SCC.Level.Two),1]


### Creating subset of pmBal_Cal for motor vehicles
pmBal_Cal_motor<-subset(pmBal_Cal, pmBal_Cal$SCC %in% motor)


### Creating pivot table for sum
pivot<-summarise(group_by(pmBal_Cal_motor,year,fips), sum=sum(Emissions))

### Naiming cities
pivot$fips<-gsub("24510", "Baltimore City", pivot$fips)
pivot$fips<-gsub("06037", "Los Angeles County", pivot$fips)

### Creating mean collumn
mean_city<-with(pivot, tapply(sum,fips, mean))
pivot$mean[pivot$fips=="Baltimore City"]<-mean_city[[1]]
pivot$mean[pivot$fips=="Los Angeles County"]<-mean_city[[2]]

pivot$changes<-pivot$sum-pivot$mean


### Plotting to screen
qplot(year,changes, data = pivot, facets = .~fips, main = "Changes against mean for PM2.5 in tons for vehicle polution", ylab = "Changes against mean of PM2.5 in tons")


### Copy plot to file

dev.copy(png,'plot6.png')
dev.off()
