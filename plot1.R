## set working directory 
setwd("C:/Users/sc56603/DataScience/Exploratory Data Analysis/Week4/Data")

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI"))
        NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
        SCC <- readRDS("Source_Classification_Code.rds")

## check unique pollutant(s)
pollutants <- unique(NEI$Pollutant)
head(pollutants)

##check missing value
#mean(is.na(NEI$Pollutant))

## agrregate data by year
aggPM25Data <-aggregate(Emissions~year, NEI, sum, na.rm=TRUE)

##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
png('plot1.png', width=640, height=480)
barplot(height=aggPM25Data$Emissions, names.arg=aggPM25Data$year, ylab=expression('total PM2.5 emission'),
        main=expression('Total PM2.5 emissions at various years'), col=c("grey"))
dev.off()

