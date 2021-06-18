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
# first subset the motor vehicles data 
vehicles<- grepl("vehicle",SCC$SCC.Level.Two, ignore.case = TRUE)
vehiclesSCC<- SCC[vehicles,]$SCC
vehiclesNEI<- NEI[NEI$SCC %in% vehiclesSCC,]
baltimoreVehiclesNEI<- vehiclesNEI[vehiclesNEI$fips==24510,]

# using ggplot2:
library(ggplot2)
ggp2<- ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() + guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2,5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore Between 1999-2008"))
print(ggp2)