# eda_wk-4_project
Coursera Exploratory Data Analysis week-4 Project
# Overall Description
## Scripts and Plots
   1. For each question in the assignment (reproduced below), there's a corresponding script - plot1.R, plot1.png, etc.
   2. The answers to the questions are given after the list of questions.
## Questions in the Assignment
1.	Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
2.	Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
3.	Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
4.	Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
5.	How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
6.	Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips=="06037"). Which city has seen greater changes over time in motor
## Answers 
1.  Yes, the total PM2.5 emissions have decreased **consistently** in US from 1999 to 2008, as is clearly evident from plot1.png.
2.  Yes, the total PM2.5 emissions have decreased from 1999 to 2008, but **not consistently. The emissions increased between 2002 and 2005**, and thereafter decreased to final levels much lower than 1999
3. Of the 4 types of sources, emissions due to **"Point" type of sources increased from 1999 to 2005 and then falling in 2008 to values a little higher than 1999**. Others decreased consistently but **varying rates of decrease** as is evident from the plot. On-road and Non-Road levels have been quite low compared to non-point sources over the given period of time
4. The emissions due to Coal Combustion sources have remained consistent from 1999 to 2005 and then have reduced by ~ 25% - 30% during 2008.
5. Motor Vehicular emissions in Baltimore City have reduced consistently from 1999 to 2008. The reduction was ~ 60% from 1999 to 2002, reduced marginally from 2002 to 2005 and then in 2008, finally reduced to ~ 25% of the levels in 1999. 
6. The following can be seen from the plot:
   * The vehicular emissions in LA County are much higher than those in Baltimore
   * The vehicular emissions in LA County have **actually net increased** from 1999 to 2008, rising from 1999 to 2005, and then reducing in 2008 to levels **slightly higher** than 1999. 
   * The vehicular emissions in Baltimore have reduced consistently from 1999 to 2008. 
