## preparing the data
# download file and extracting data sets:
dataFile<- "NEI_data.zip"
if (!file.exists(dataFile)) {
  dataURL<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url = dataURL, destfile = dataFile)
}

if (!(file.exists("summarySCC_PM25.rds") && file.exists("Source_Classification_Code.rds"))) {
  unzip(dataFile)
} 

# reading data sets into r:
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")

## constructing a plot 
# aggregating the data to get total PM25:
PM25Totals<- aggregate(Emissions~year,NEI,sum)

# plotting total PM25 emissions from all sources (using the base plotting system):
barplot(
  (PM25Totals$Emissions)/10^6,
names.arg=PM25Totals$year,
xlab="Year",
ylab="PM2.5 Emissions (10^6 Tons)",
main= "Total PM2.5 Emissions from All US Sources Between 1999-2008"
)

