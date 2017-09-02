##################
##################  This analysis is based on data from the National Emissions Inventory (NEI)
##################  The chart answers to question: 
##################  Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
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


### Creating index of SCC containning coal
coal<-SCC[grep("Coal",SCC$SCC.Level.Four), 1]

### Creating subset of NEI for Coal
NEI_coal<-subset(NEI, NEI$SCC %in% coal)

### Calculation total of PM2.5 by year 
mn0<-with(NEI_coal, tapply(Emissions, year, sum, na.rm=TRUE))


### Plotting to screen
plot(c("1999","2002","2005","2008"),mn0,xlab = "Year", ylab = "Total of PM2.5 in tons", main = "Total of PM2.5 in tons for USA for Coal combustion sources")

### Copy plot to file

dev.copy(png,'plot4.png')
dev.off()