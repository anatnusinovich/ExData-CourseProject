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
# first subset coal combustion data:
combustionData<- grepl("comb",SCC$SCC.Level.One, ignore.case = TRUE)
coalData<- grepl("coal",SCC$SCC.Level.Four, ignore.case = TRUE)
coalCombustion<- (combustionData & coalData)
combustionSCC<- SCC[coalCombustion,]$SCC
combustionNEI<- NEI[NEI$SCC %in% combustionSCC,]

# plotting using ggplot:
library(ggplot2)
ggp1<- ggplot(combustionNEI,aes(factor(year),Emissions/10^5))+
  geom_bar(stat = "identity",fill="grey",width=0.75) +
  theme_bw() + guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) +
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across the US Between 1999-2008"))
print(ggp1)