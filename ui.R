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
library(RColorBrewer)
library(leaflet.providers)
library(plotly)
library(leaflet)

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
          
        # Barchart              
         tabPanel("Bar Charts",
           sidebarLayout(
             sidebarPanel(
               radioButtons("year", "Year", c("2017"="2017","2018"="2018", 
                                              "2019" = "2019"))
             ), # Close sidebar panel
             
             mainPanel(plotOutput("barchartPlot")) # Close Main Panel
           ) # Close sidebar layout
         ), # Close barchart tab
         
        # Plotly Bar Charts
        tabPanel("Interactive Bar Charts",
                 sidebarLayout(
                   sidebarPanel(
                     radioButtons("year", "Year", c("2017"="2017","2018"="2018", 
                                                    "2019" = "2019"))
                   ), # Close sidebar panel
                   
                   mainPanel(plotlyOutput("PlotlyBarchart")) # Close Main Panel
                 ) # Close sidebar layout
        ), # Close barchart tab
        
        # Map
         tabPanel("Map",
                  sidebarLayout(
                    sidebarPanel(
                      radioButtons("year", "Year", c("2017"=2017,"2018"=2018, 
                                                     "2019" = 2019), selected= 2019)
                      # actionButton("run", "Run")
                    ), # Close sidebar panel
                    
                    mainPanel(plotOutput("MapPlot")) # Close Main Panel
                  ) # Close sidebar layout
         ) # Close exp tab
      ), # close navbar menu for fire scar analysis
      
      ######------- leaflet map Page
      tabPanel("Leaflet Map",
          tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
          leafletOutput("LeafletMap", height = 800),
          absolutePanel(top = 80, right = 10,
            
            # Select number of intervals          
            sliderInput("range", "Update Number Values", min(df_2017$Update_No), 
                        max(df_2017$Update_No), value = range(df_2017$Update_No), step = 10
            ), # Close number of intervals 
            
            # Select color theme
            selectInput("colors", "Color Scheme",
                        rownames(subset(brewer.pal.info, category %in% c("seq", "div")))
            ), # Close select input for color theme
            
            # Select Basemap
            selectInput("basemap", "Basemap",
                        get_providers("1.7.0")$providers
            ), # Close select input for basemap
            
          ) # Close absolute panel
      ), # Close Leaflet map
      
      # ######------- Plotly Barchart Page
      # tabPanel("Plotly Barchart",
      #          mainPanel(plotlyOutput("PlotlyBarchart"))
      # ), # Close Leaflet map
      
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
      





