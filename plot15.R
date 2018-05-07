## This first line will likely take a few seconds. Be patient!
if(!exists("NEI"))
        NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
        SCC <- readRDS("Source_Classification_Code.rds")

##subset data for bultimore city and motor vehicle sources 
unique(NEI$type)
baltiomoreNEIOnRoad <- subset(NEI, fips=="24510" & type=="ON-ROAD")

## agrregate data by year
aggPM25DataOnRoad <-aggregate(Emissions~year, baltiomoreNEIOnRoad, sum, na.rm=TRUE)

##How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
png('plot5.png', width=640, height=480)
barplot(height=aggPM25DataOnRoad$Emissions, names.arg=aggPM25DataOnRoad$year, ylab=expression('total PM2.5 emission'),
        main=expression('Total PM2.5 emissions from motor vehicle at various years in Baltimore City'), col=c("green"))
dev.off()

