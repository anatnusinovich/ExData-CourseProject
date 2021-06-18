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
# aggregating Baltimore data: 
baltimoreNEI<- NEI[NEI$fips=="24510",]
BaltimoreTotals<- aggregate(Emissions~year,baltimoreNEI,sum) 

# plotting total Baltimore emissions (using the base plotting system):
barplot(BaltimoreTotals$Emissions,
        names.arg = BaltimoreTotals$year,
        xlab= "Year",
        ylab= "PM2.5 Emissions (Tons)",
        main= "Total PM2.5 Emissions from All Baltimore City Sources Between 1999-2008")