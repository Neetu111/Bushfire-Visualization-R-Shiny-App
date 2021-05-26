library(shiny)
library(tidyverse)
library(sf)
library(data.table)
library(ozmaps)
library(lwgeom)
library(plotly)
library(leaflet)
library(leaflet.extras)
library(leaflet.providers)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Darwin Region Shape
  darwin_shape = read_sf("Data-Raw/LandSystems_darwl_250/data/darwl_250_bnd.shp")
  
  # Data for darwin region
  df_2017 = read_sf("Data-Raw/2017 Data/df_2017.shp")
  df_2018 = read_sf("Data-Raw/2018 Data/df_2018.shp")
  df_2019 = read_sf("Data-Raw/2019 Data/df_2019.shp")
  
  ###----------  Barcharts Outputs
  output$barchartPlot = renderPlot({
    
    if (input$barchart_year == 2017){
      df = df_2017 %>%
        select(Update_No, Month)
    }
    else if (input$barchart_year == 2018){
      df = df_2018 %>%
        select(Update_No, Month)
    }
    else if (input$barchart_year == 2019){
      df = df_2019 %>%
        select(Update_No, Month)
    }
    
    ggplot(data = df, mapping = aes(x=Month, y =Update_No, fill = Month)) +
      geom_col()
  })
  
  ###----------  Plotly BarChart
  output$PlotlyBarchart = renderPlotly({
    if (input$plotly_year == "2017"){
      df = df_2017 %>%
        select(Update_No, Month) 
    }
    else if (input$plotly_year == "2018"){
      df = df_2018 %>%
        select(Update_No, Month) 
    }
    else if (input$plotly_year == "2019"){
      df = df_2019 %>%
        select(Update_No, Month) 
    }
    df %>%
      plot_ly() %>%
      add_trace(x = ~Month, y = ~Update_No, color = ~Month, type = "bar")
  })
  
  ###------------- Map with ggplot()
  output$MapPlot = renderPlot({

    if (input$ggplot_map_year == 2017){
      df = df_2017 %>%
        select(Update_No, Month)
    }
    else if (input$ggplot_map_year == 2018){
      df = df_2018 %>%
        select(Update_No, Month)
    }
    else if (input$ggplot_map_year == 2019){
      df = df_2019 %>%
        select(Update_No, Month)
    }

    ggplot() +
      geom_sf(data = darwin_shape) +
      geom_sf(data = df, mapping = aes(fill = Update_No))
  })
  
  ###----------  LeafletMap
  output$LeafletMap = renderLeaflet({
    
    if (input$leaflet_year == 2017){
      df = df_2017
    }
    else if (input$leaflet_year == 2018){
      df = df_2018
    }
    else if (input$leaflet_year == 2019){
      df = df_2019
    }
    
    interval = seq(min(input$range), max(input$range), 30)
    color_palette = colorBin(input$colors, domain = df$Update_No, bins = interval)
    selected_basemap = input$basemap
    labels = sprintf("Update No: %s <br/> Month: %s <br/> Area(KM Square): %s <br/> Region: %s",
                     df$Update_No, df$Month, df$AREA_KM2, df$Region) %>% 
      lapply(htmltools::HTML)
    
    # get_providers("1.7.0")$providers
    
    df %>%
      leaflet() %>%
      addProviderTiles(input$basemap) %>%
      addPolygons(fillColor = ~color_palette(Update_No), weight = 2, 
                  opacity = 1, color = "grey", dashArray = "3", fillOpacity = 0.7,
                  highlight = highlightOptions(weight = 5, color = "#666", 
                                               dashArray = "", fillOpacity = 0.7,
                                               bringToFront = TRUE), 
                  label = labels, labelOptions = labelOptions(style = list("font-weight" = "normal",
                                                                           padding = "3px 8px"),
                                                              textsize = "15px", direction = "auto")) %>%
      addLegend(pal = color_palette, values = ~Update_No, opacity = 0.7, title = NULL,
                position = "bottomright")
  })
  
  ###----------  Table outputs
  # Table output 2017
  output$table_2017 <- DT::renderDataTable({
    DT::datatable(df_2017 %>%
                    select(Update_No, Month))
  })
  
  # Table output 2018
  output$table_2018 <- DT::renderDataTable({
    DT::datatable(df_2018 %>%
                    select(Update_No, Month))
  })
  
  # Table output 2019
  output$table_2019 <- DT::renderDataTable({
    DT::datatable(df_2019 %>%
                    select(Update_No, Month))
  })
  
}
