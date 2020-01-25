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

NEI_BALT_LACOUNTY_EMI <- subset(NEI,(fips == "24510" | fips == "06037") & SCC %in% MOTVEH_SRCS) %>% dplyr::group_by(fips,year) %>% dplyr::summarize(Gross_emissions_motveh_tons = sum(Emissions)) %>% dplyr::ungroup()

# add county names as factors - manually in this case as the data set is very small

NEI_BALT_LACOUNTY_EMI$County_name <- rep(c("LA County","Baltimore"),each = 4)
NEI_BALT_LACOUNTY_EMI$County_name <- as.factor(NEI_BALT_LACOUNTY_EMI$County_name) 

# now, start the plot #6 - a line and point to compare emission trends between Baltimore and LA County 
# default file size = 480x480 pixels

png(file="plot6.png")
NEI_Balt_LA_motveh_ggbase <- ggplot(NEI_BALT_LACOUNTY_EMI,aes(year,Gross_emissions_motveh_tons/1000),group = County_name)
NEI_Balt_LA_motveh_ggbase + geom_point(aes(color = County_name)) + geom_line(aes(color = County_name)) + labs(title = "PM25 Emissions Baltimore Vs LA County",x="year",y="Thousand Tons") 
dev.off()

quit(status=0)
