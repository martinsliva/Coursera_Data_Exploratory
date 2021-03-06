##################
##################  This analysis is based on data from the National Emissions Inventory (NEI)
##################  The chart answers to question: 
##################  How have emissions from motor vehicle sources changed from 1999�2008 in Baltimore City?
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
SCC <- readRDS("Source_Classification_Code.rds")

### Creating subset of data for Baltimore City
pmBal<-subset(NEI,fips=="24510")

### Creating index of SCC for Motor vehicles
motor<-SCC[grep("Vehicles",SCC$SCC.Level.Two),1]


### Creating subset of pmBal for motor vehicles
pmBal_motor<-subset(pmBal, pmBal$SCC %in% motor)

### Calculation total of PM2.5 by year 
mn0<-with(pmBal_motor, tapply(Emissions, year, sum, na.rm=TRUE))


### Plotting to screen
plot(c(1999,2002,2005,2008),mn0,xlab = "Year", ylab = "Total of PM2.5 in tons",main = "Total of PM2.5 for Baltimore City from motor vehicles")


### Copy plot to file

dev.copy(png,'plot5.png')
dev.off()
