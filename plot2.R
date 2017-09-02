

#### Checking if rds files exists in working directory. If not than download and unzip them 
if (!(file.exists("Source_Classification_Code.rds") && file.exists("summarySCC_PM25.rds")))  {
  print("Data not found, trying to download and unzip them.")
  fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl, destfile = "dataset.zip")
  unzip("dataset.zip")
  print("Data downloaded and unziped.")
}


### Reading data 
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

### Creating subset of data for Baltimore City
pmBal<-subset(NEI,fips=="24510")


### Calculation total of PM2.5 by year 
mn0<-with(pmBal, tapply(Emissions, year, sum, na.rm=TRUE))

### Plotting to screen
plot(c(1999,2002,2005,2008),mn0,xlab = "Year", ylab = "Total of PM2.5 in tons",main = "Total of PM2.5 for Baltimore City")

### Copy plot to file

dev.copy(png,'plot2.png')
dev.off()
