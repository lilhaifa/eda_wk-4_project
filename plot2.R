#!/usr/bin/Rscript

library(readr)
library(lubridate)
library(dplyr)
library(tidyr)

# load the data from the data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# examine data, sanity checking for NAs, etc
mean(is.na(NEI$Emissions))
summary(NEI$Emissions)
# the above reveals that there are no NA values and there also are extreme values like 646952 - probably errors,
# but not impacting this project

# filter Baltimore City Data

NEI_BALTIMR <- subset(NEI,fips == "24510")
#classify according to year

NEI_gross_BALTIMR_emissions <- NEI_BALTIMR %>% group_by(year) %>% summarise(emission_sum_ThousandTons = sum(Emissions)/1000)

# now, start the plot #1 - Line and Point Plot for year-wise gross emissions 
# default file size = 480x480 pixels

png(file="plot2.png")
with(NEI_gross_BALTIMR_emissions, plot(year,emission_sum_ThousandTons,type = "b",pch = 19, col = "green", lwd = 3, ylab = "Thousand Tons", main = "Gross PM25 Emissions BALTIMORE"))
dev.off()

quit(status=0)
