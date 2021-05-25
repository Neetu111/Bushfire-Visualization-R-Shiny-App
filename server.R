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
    
    if (input$year == 2017){
      df = df_2017 %>%
        select(Update_No, Month)
    }
    else if (input$year == 2018){
      df = df_2018 %>%
        select(Update_No, Month)
    }
    else if (input$year == 2019){
      df = df_2019 %>%
        select(Update_No, Month)
    }
    
    ggplot(data = df, mapping = aes(x=Month, y =Update_No, fill = Month)) +
      geom_col()
  })
  
  ###----------  Map Outputs
  # observe({
  #   observeEvent(input$run, {
  #     if (input$year == 2017){
  #       output$MapPlot = renderPlot({
  #         ggplot() +
  #           geom_sf(data = darwin_shape) +
  #           geom_sf(data = df_2017, mapping = aes(fill = Update_No))
  #       }) # Close render plot 2017
  #     }
  #     else if (input$year == 2018){
  #       output$MapPlot = renderPlot({
  #         ggplot() +
  #           geom_sf(data = darwin_shape) +
  #           geom_sf(data = df_2018, mapping = aes(fill = Update_No))
  #       }) # Close render plot 2018
  #     }
  #     else if (input$year == 2019){
  #       output$MapPlot = renderPlot({
  #         ggplot() +
  #           geom_sf(data = darwin_shape) +
  #           geom_sf(data = df_2019, mapping = aes(fill = Update_No))
  #       }) # Close render plot 2019
  #     }
  #   }) # Close observe event
  # }) # Close observe
  
  output$MapPlot = renderPlot({

    if (input$year == 2017){
      df = df_2017 %>%
        select(Update_No, Month)
    }
    else if (input$year == 2018){
      df = df_2018 %>%
        select(Update_No, Month)
    }
    else if (input$year == 2019){
      df = df_2019 %>%
        select(Update_No, Month)
    }

    ggplot() +
      geom_sf(data = darwin_shape) +
      geom_sf(data = df, mapping = aes(fill = Update_No))
  })
  
  ###----------  Plotly BarChart
  output$PlotlyBarchart = renderPlotly({
    if (input$year == "2017"){
      df = df_2017 %>%
        select(Update_No, Month) 
    }
    else if (input$year == "2018"){
      df = df_2018 %>%
        select(Update_No, Month) 
    }
    else if (input$year == "2019"){
      df = df_2019 %>%
        select(Update_No, Month) 
    }
    df %>%
      plot_ly() %>%
      add_trace(x = ~Month, y = ~Update_No, color = ~Month, type = "bar")
  })
  
  ###----------  LeafletMap
  output$LeafletMap = renderLeaflet({
    
    interval = seq(min(df_2017$Update_No), max(df_2017$Update_No), 30)
    color_palette = colorBin(input$colors, domain = df_2017$Update_No, bins = input$range)
    selected_basemap = input$basemap
    
    # get_providers("1.7.0")$providers
    
    df_2017 %>%
      leaflet() %>%
      addProviderTiles(input$basemap) %>%
      addPolygons(fillColor = ~color_palette(Update_No), weight = 2, 
                  opacity = 1, color = "grey", dashArray = "3", fillOpacity = 0.7,
                  highlight = highlightOptions(weight = 5, color = "#666", 
                                               dashArray = "", fillOpacity = 0.7,
                                               bringToFront = TRUE)) %>%
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
