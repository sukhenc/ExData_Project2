## This first line will likely take a few seconds. Be patient!
if(!exists("NEI"))
        NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
        SCC <- readRDS("Source_Classification_Code.rds")

##subset data for bultimore city and motor vehicle sources 
baltiomoreNEIOnRoad <- subset(NEI, fips=="24510" & type=="ON-ROAD")
losAnglesNEIOnRoad <- subset(NEI, fips=="06037" & type=="ON-ROAD")
## add city column and combine the dataframes 
baltiomoreNEIOnRoad$city <- "Baltimore"
losAnglesNEIOnRoad$city <- "Los Angeles"
bothCityNEIOnRoadData <- rbind(baltiomoreNEIOnRoad, losAnglesNEIOnRoad)

## agrregate data by year and city
aggPM25DataOnRoadCities <-aggregate(Emissions~year + city, bothCityNEIOnRoadData, sum, na.rm=TRUE)

##Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California.
##Which city has seen greater changes over time in motor vehicle emissions?
library(ggplot2)
png("plot6.png", width=640, height=480)
g <- ggplot(aggPM25DataOnRoadCities, aes(year, Emissions, color = city))
g <- g + geom_line() +
        xlab("year") +
        ylab(expression('Total PM2.5 Emissions')) +
        ggtitle('Total Emissions (PM25) in Baltimore and Los Angeles from 1999 to 2008') 
print(g)
dev.off()