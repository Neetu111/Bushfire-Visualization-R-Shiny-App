library(shiny)
library(tidyverse)
library(sf)
library(data.table)
library(ozmaps)
library(lwgeom)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Darwin Region Shape
  darwin_shape = read_sf("Data-Raw/LandSystems_darwl_250/data/darwl_250_bnd.shp")
  
  # Data for darwin region
  df_2017 = read_sf("Data-Raw/2017 Data/df_2017.shp")
  df_2018 = read_sf("Data-Raw/2018 Data/df_2018.shp")
  df_2019 = read_sf("Data-Raw/2019 Data/df_2019.shp")
  
 output$distPlot <- renderPlot({
    
    # df_2017 = fire_scar_2017 %>%
    #   select(Update_No, Month)
    # draw the histogram with the specified number of bins
    ggplot(data = df_2018, mapping = aes(x=Month, y =Update_No)) +
      geom_col()
  })
  
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
  output$map = renderPlot({
    
    if (input$year == 2017){
      df = df_2017
    }
    else if (input$year == 2018){
      df = df_2018
    }
    else if (input$year == 2019){
      df = df_2019
    }
    
    ggplot() +
      geom_sf(data = darwin_shape) +
      geom_sf(data = df, mapping = aes(fill = Update_No))
  })
  
  ###----------  Table outputs
  # Table output 2017
  output$table_2017 <- DT::renderDataTable({
    DT::datatable(df_2017)
  })
  
  # Table output 2018
  output$table_2018 <- DT::renderDataTable({
    DT::datatable(df_2018)
  })
  
  # Table output 2019
  output$table_2019 <- DT::renderDataTable({
    DT::datatable(df_2019)
  })
  
}
