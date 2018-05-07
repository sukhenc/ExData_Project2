## This first line will likely take a few seconds. Be patient!
if(!exists("NEI"))
        NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
        SCC <- readRDS("Source_Classification_Code.rds")

## check fips
fips <- unique(NEI$fips)
#class(fips)

##subset data for bultimore city 
baltiomoreNEI <- subset(NEI, fips=="24510")

## agrregate data by year
baltiomoreAggPM25Data <-aggregate(Emissions~year, baltiomoreNEI, sum, na.rm=TRUE)

##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008? 
png('plot2.png', width=640, height=480)
barplot(height=baltiomoreAggPM25Data$Emissions, names.arg=baltiomoreAggPM25Data$year, ylab=expression('total PM2.5 emission'),
        main=expression('Total PM2.5 emissions at various years in Baltimore'), xlab=expression('years'), col=c("blue"))
dev.off()

