####-------- Load Libraries
library(shiny)
library(tidyverse)
library(sf)
library(data.table)
library(ozmaps)
library(lwgeom)
library(plotly)

####-------- Data Preparation
fire_scar_2017 = read_sf("Data-Raw/2017 firescar shapefiles/fs17_mths_gda.shp") %>%
  mutate(across(Month, as.factor)) 
fire_scar_2018 = read_sf("Data-Raw/2018 firescar shapefiles/fs2018Revised.shp") %>%
  mutate(across(Month, as.factor)) %>%
  rename(Update_No = Update_no)
fire_scar_2019 = read_sf("Data-Raw/2019 firescar shapefiles/fs19_mths_gda.shp") %>%
  mutate(across(Month, as.factor)) 

# Darwin Region Shape
darwin_shape = read_sf("Data-Raw/LandSystems_darwl_250/data/darwl_250_bnd.shp")

# Data for darwin region
df_2017 = st_join(fire_scar_2017, darwin_shape, left = FALSE, largest = TRUE)
df_2018 = st_join(st_buffer(fire_scar_2018, 0), darwin_shape, left = FALSE, 
                  largest = TRUE)
df_2019 = st_join(st_buffer(fire_scar_2019, 0), darwin_shape, left = FALSE, 
                  largest = TRUE)

#######--------- Write data in a file
st_write(df_2017, "df_2017.shp")
st_write(df_2018, "df_2018.shp")
st_write(df_2019, "df_2019.shp")

#######--------- Read new data

df_2017 = read_sf("Data-Raw/2017 Data/df_2017.shp")
df_2018 = read_sf("Data-Raw/2018 Data/df_2018.shp")
df_2019 = read_sf("Data-Raw/2019 Data/df_2019.shp")

# Maps witgh new data
ggplot() +
  geom_sf(data = darwin_shape) +
  geom_sf(df_2017, mapping = aes(fill = Update_No))

d = df_2018 %>%
  select(Update_No, Month)

ggplot() +
  geom_sf(data = darwin_shape) +
  geom_sf(d, mapping = aes(fill = Update_No))

ggplot() +
  geom_sf(data = darwin_shape) +
  geom_sf(df_2019, mapping = aes(fill = Update_No))


#######--------- Barchart With Plotly
df_2017 %>%
  plot_ly() %>%
  add_trace(x = ~Month, y = ~Update_No, color = ~Month, type = "bar")

df_2018 %>%
  plot_ly() %>%
  add_trace(x = ~Month, y = ~Update_No, color = ~Month, type = "bar")

df_2019 %>%
  plot_ly() %>%
  add_trace(x = ~Month, y = ~Update_No, color = ~Month, type = "bar")

#######--------- Barchart With Leaflet
interval = seq(min(df_2017$Update_No), max(df_2017$Update_No), 30)
color_palette = colorBin("YlOrBr", domain = df_2017$Update_No, bins = interval)

df_2017 %>%
  leaflet() %>%
  addTiles() %>%
  addPolygons(fillColor = ~color_palette(Update_No), weight = 2, 
              opacity = 1, color = "grey", dashArray = "3", fillOpacity = 0.7,
              highlight = highlightOptions(weight = 5, color = "#666", 
                                           dashArray = "", fillOpacity = 0.7,
                                           bringToFront = TRUE)) %>%
  addLegend(pal = color_palette, values = ~Update_No, opacity = 0.7, title = NULL,
            position = "bottomright")

# Different basemap
# get_providers("1.7.0")$providers  # Get list of providers maps

# Lable = Area, Update No., Month, 
labels = sprintf("Update No: %s <br/> Month: %s <br/> Area(KM Square): %s <br/> Region: %s",
                 df_2017$Update_No, df_2017$Month, df_2017$AREA_KM2, df_2017$Region) %>% 
  lapply(htmltools::HTML)
  
df_2017 %>%
  leaflet() %>%
  addProviderTiles(providers$OpenSeaMap) %>%
  addPolygons(fillColor = ~color_palette(Update_No), weight = 2, 
              opacity = 1, color = "grey", dashArray = "3", fillOpacity = 0.7,
              highlight = highlightOptions(weight = 5, color = "#666", 
                                           dashArray = "", fillOpacity = 0.7,
                                           bringToFront = TRUE),
              label = labels, labelOptions = labelOptions(style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "15px", direction = "auto")) %>%
  addLegend(pal = color_palette, values = ~Update_No, opacity = 0.7, title = NULL,
            position = "bottomright")









