## This first line will likely take a few seconds. Be patient!
if(!exists("NEI"))
        NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
        SCC <- readRDS("Source_Classification_Code.rds")

##subset data for bultimore city 
baltiomoreNEI <- subset(NEI, fips=="24510")

## check types
types <- unique(baltiomoreNEI$type)
#head(types)
#class(types)

## agrregate data by year and type 
baltiomoreAggPM25DataByType <-aggregate(Emissions~year+type, baltiomoreNEI, sum, na.rm=TRUE)

##Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, 
##which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
##Which have seen increases in emissions from 1999-2008? Use 
library(ggplot2)
png("plot3.png", width=640, height=480)
g <- ggplot(baltiomoreAggPM25DataByType, aes(year, Emissions, color = type))
g <- g + geom_line() +
        xlab("year") +
        ylab(expression('Total PM2.5 Emissions')) +
        ggtitle('Total Emissions (PM25) in Baltimore Cityfrom 1999 to 2008') 
print(g)
dev.off()

