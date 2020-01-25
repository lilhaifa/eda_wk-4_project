#!/usr/bin/Rscript

library(readr)
library(lubridate)
library(dplyr)
library(tidyr)
library(ggplot2)

# load the data from the data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# examine data, sanity checking for NAs, etc
mean(is.na(NEI$Emissions))
summary(NEI$Emissions)
# the above reveals that there are no NA values and there also are extreme values like 646952 - probably errors,
# but not impacting this project

# filter type-wise emission summary for Baltimore

NEI_EMIS_TYPE_SUMMARY <- NEI %>% subset(fips == "24510") %>% dplyr::group_by(type,year) %>% dplyr::summarize(Gross_emission_tons = sum(Emissions)/1000,na.rm = TRUE) %>% dplyr::ungroup()

#convert type to factor

NEI_EMIS_TYPE_SUMMARY$type <- as.factor(NEI_EMIS_TYPE_SUMMARY$type)

# now, start the plot #1 - Line and Point Plot for year-wise gross emissions 
# default file size = 480x480 pixels

png(file="plot3.png")

NEI_ggbase <- ggplot(NEI_EMIS_TYPE_SUMMARY,aes(year,Gross_emission_tons))
NEI_ggbase + geom_point(aes(color=type)) + geom_line(aes(color=type)) + labs(title = "PM25 Emission By Source Types Baltimore",x="year",y="Gross Emission Thousand Tons")
dev.off()

quit(status=0)
