## This first line will likely take a few seconds. Be patient!
if(!exists("NEI"))
        NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
        SCC <- readRDS("Source_Classification_Code.rds")


## check SCC data for coal combustion-related sources 
coalMatches  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
#sum(coalMatches)
coalRelatedSCC <- SCC$SCC[coalMatches]
#length(coalRelatedSCC)

## subset coal related NEI data
coalNEI <- subset(NEI, SCC %in% coalRelatedSCC)

## agrregate data by year
coalAggPM25DataByYear <-aggregate(Emissions~year, coalNEI, sum, na.rm=TRUE)

#Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
png('plot4.png', width=640, height=480)
barplot(height=coalAggPM25DataByYear$Emissions, names.arg=coalAggPM25DataByYear$year, ylab=expression('total PM2.5 emission'),
        main=expression('Total coal combustion-related PM2.5 emissions at various years in United States'), xlab=expression('years'), col=c("black"))
dev.off()

