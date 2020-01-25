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

# To extract SCC codes for Motor Vehicle sources 
# we first build a list of such codes from SCC data-frame above
# For Combustion, we use the field "EI.Sector" from the DF and then extract the SCC codes by searching for "Mobile - On-Road" string  

MOTVEH_SRCS <- SCC[grep("Mobile - On-Road",SCC$EI.Sector),c(1)] %>% as.character()

# Now we extract the emission data based on the SCC codes above

BALTIMORE_MOTVEH_EMI_SUMMARY <- dplyr::filter(NEI,fips == "24510" & SCC %in% MOTVEH_SRCS) %>% dplyr::group_by(year) %>% dplyr::summarize(Gross_motveh_tons = sum(Emissions)) %>% dplyr::ungroup()

# now, start the plot #5 - a barplot for Baltimore Motor-Vehicular emissions 
# default file size = 480x480 pixels

png(file="plot5.png")
barplot(BALTIMORE_MOTVEH_EMI_SUMMARY$Gross_motveh_tons,names.arg = BALTIMORE_MOTVEH_EMI_SUMMARY$year, xlab = "year", ylab = "Tons", col = "yellow", main = "Motor Vehicular Emissions Baltimore")
dev.off()

quit(status=0)
