#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes) # Library to accees the themes
library(markdown) # Library to include text

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("cosmo"),
      navbarPage("Bushfire Data Analysis",
        tabPanel("Home",
          mainPanel(
            includeMarkdown("Information.md")
          )
        ), # Close tabPanle Home
        
      ######------- Fire Scar Analysis Page
      navbarMenu("Fire Scar Analysis",
         tabPanel("Bar Charts",
           sidebarLayout(
             sidebarPanel(
               radioButtons("year", "Year", c("2017"="2017","2018"="2018", 
                                              "2019" = "2019"))
             ), # Close sidebar panel
             
             mainPanel(plotOutput("barchartPlot")) # Close Main Panel
           ) # Close sidebar layout
         ), # Close barchart tab
         
         tabPanel("Map",
                  sidebarLayout(
                    sidebarPanel(
                      radioButtons("year", "Year", c("2017"="2017","2018"="2018", 
                                                     "2019" = "2019"))
                    ), # Close sidebar panel
                    
                    mainPanel(plotOutput("map")) # Close Main Panel
                  ) # Close sidebar layout
         ) # Close exp tab
      ), # close navbar menu for fire scar analysis
      
      # navbarMenu("Hotspot",
      #    tabPanel("Bar Charts",
      #             sidebarLayout(
      #               sidebarPanel(
      #                 radioButtons("year", "Year", c("2017"="2017","2018"="2018", 
      #                                                "2019" = "2019"))
      #               ), # Close sidebar panel
      #               
      #               mainPanel(plotOutput("barchart", height = 500)) # Close Main Panel
      #             ) # Close sidebar layout
      #    ), # Close exp tab
      #    
      #    tabPanel("Map",
      #             sidebarLayout(
      #               sidebarPanel(
      #                 radioButtons("year", "Year", c("2017"="2017","2018"="2018", 
      #                                                "2019" = "2019"))
      #               ), # Close sidebar panel
      #               
      #               mainPanel(plotOutput("map")) # Close Main Panel
      #             ) # Close sidebar layout
      #    ) # Close exp tab
      # ), # close navbar menu for hotspots
      
      navbarMenu("Used Data",
         tabPanel("2017",
                  DT::dataTableOutput("table_2017")
         ), # close table panel 2017
         
         tabPanel("2018",
                  DT::dataTableOutput("table_2018")
         ), # close table panel 2018    
         
         tabPanel("2019",
                  DT::dataTableOutput("table_2019")
         ) # close table panel 2018 
        
      ) # close navbar menu for data
    ), # Close Navbar page
  ) # Close Fluid Page
      





