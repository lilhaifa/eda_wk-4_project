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

# To extract SCC codes for a combination of Coal and Combustion,
# we first build a list of such codes from SCC data-frame above
# For Combustion, we use the field "SCC.Level.One" from the DF and then extract the SCC codes by searching for "Combustion" string  

NEI_COMBUST_SCC <- SCC[grep("Combustion",SCC$SCC.Level.One),c(1)] %>% as.character()

# For Coal, we use the field "SCC.Level.Three" from the DF SCC and then extract the SCC codes by searching for "Coal" string  

NEI_COAL_SCC <- SCC[grep("Coal",SCC$SCC.Level.Three),c(1)] %>% as.character()

#finally, in order to have a combination of coal and combustion, we take an intersection of these two vectors 

NEI_COAL_COMBUST_SCC <- intersect(NEI_COMBUST_SCC,NEI_COAL_SCC)

# Now we extract the emission data based on the SCC codes above

COAL_COMBUST_EMISSIONS_SUMMARY <- dplyr::filter(NEI,SCC %in% NEI_COAL_COMBUST_SCC) %>% dplyr::group_by(year) %>% dplyr::summarize(Gross_emissions_coal_combust_tons = sum(Emissions)) %>% dplyr::ungroup()

# now, start the plot #4 - a barplot for coal-combustion emissions across USA 
# default file size = 480x480 pixels

png(file="plot4.png")
barplot(COAL_COMBUST_EMISSIONS_SUMMARY$Gross_emissions_coal_combust_tons/100000,names.arg = COAL_COMBUST_EMISSIONS_SUMMARY$year, xlab = "year", ylab = "Hundred-Thousand Tons", col = "yellow", main = "Coal Combustion Emissions USA")
dev.off()

quit(status=0)
