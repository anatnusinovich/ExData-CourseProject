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
# comparing emissions in Baltimore with emissions in Los Angeles
# vehiclesBaltimoreNEI<- vehiclesNEI[vehicles$fips=="24510",]
# vehiclesBaltimoreNEI$city<- "Baltimore City"
# vehiclesLosAngelesNEI<- vehiclesNEI[vehicles$fips=="06037",]
# vehiclesLosAngelesNEI$city<- "Los Angeles County"
# bothNEI<- rbind(vehiclesBaltimoreNEI,vehiclesLosAngelesNEI)

vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips == 24510,]
vehiclesBaltimoreNEI$city <- "Baltimore City"
vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"
bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

# constructing plot using ggplot2
library(ggplot2)
ggp <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & Los Angeles Between 1999-2008"))
print(ggp)