## ./09_Project/Help_Me_RC  -- terminal commands to kick off ShinyApp for this project

setwd("~/Documents/Coursera/09-DevelopingDataProducts/09_Project/09_presentProduct/Estimate_my_Diamond")
library(shiny)
runApp()

library(shinyapps)
shinyapps::setAccountInfo(name='saoirsegirl', token='1EA7FFA5043D3262BEC3316FBA1A25E0', 
                          secret='Gl1Danh6buwcFeDdCt8V1YZhQJvAv3T5X2ZwJqXz')
deployApp("~/Documents/Coursera/09-DevelopingDataProducts/09_Project/09_presentProduct/Estimate_my_Diamond", 
          account = 'saoirsegirl',
          quiet = FALSE,
          appName = "Estimate_my_Diamond")

terminateApp("Estimate_my_Diamond", quiet = FALSE)

#<img src="http://www.zillow.com/widgets/GetVersionedResource.htm?path=/static/
# logos/Zillowlogo_150x40_rounded.gif" width="150" height="40" 
# alt="Zillow Real Estate Search" />
# Alt text for the image must be "Real Estate on Zillow".