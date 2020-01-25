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

#classify according to year

NEI_gross_USA_emissions <- NEI %>% group_by(year) %>% summarise(emission_sum_Mtons = sum(Emissions)/1000000)

# now, start the plot #1 - Line and Point Plot for year-wise gross emissions 
# default file size = 480x480 pixels

png(file="plot1.png")
with(NEI_gross_USA_emissions, plot(year,emission_sum_Mtons,type = "b",pch = 19, col = "green", lwd = 3, ylab = "Million Tons", main = "Gross PM25 Emissions USA"))
dev.off()

quit(status=0)
