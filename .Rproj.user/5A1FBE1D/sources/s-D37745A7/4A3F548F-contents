####-------- Load Libraries
library(shiny)
library(tidyverse)
library(sf)
library(data.table)
library(ozmaps)
library(lwgeom)

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

ggplot() +
  geom_sf(data = darwin_shape) +
  geom_sf(df_2018, mapping = aes(fill = Update_No))

ggplot() +
  geom_sf(data = darwin_shape) +
  geom_sf(df_2019, mapping = aes(fill = Update_No))



# Code Exp
df = fire_scar_2017 %>%
  filter(Region %like% "NT")

aus_states <- ozmaps::ozmap_states %>%
  filter(NAME %in% c("Northern Territory", "Other Territories"))

darwin_shape = read_sf("Data-Raw/LandSystems_darwl_250/data/darwl_250_bnd.shp") %>% 
  view()
  
ggplot() +
  geom_sf(data = darwin_shape)

ggplot() +
  geom_sf(data = darwin_shape) +
  geom_sf(data = df, mapping = aes(fill = Update_No))
  
  
# data_darwin_shape <- st_join(df, darwin_shape, left = FALSE, largest = TRUE)
data_darwin_shape <- st_join(fire_scar_2018, darwin_shape, join = st_intersects)
  
ggplot() +
  geom_sf(data = data_darwin_shape, mapping = aes(fill = Update_no))


ggplot() +
  geom_sf(data = darwin_shape) +
  geom_sf(data = data_darwin_shape, mapping = aes(fill = Update_no))






# 
# +
#   geom_sf(darwin_shape)
# 
# 




# # Tab 2
# tabPanel("Hotspot Analysis",
#          sidebarPanel(
#            textInput("txt", "Text input:", "text here"),
#            sliderInput("slider", "Slider input:", 1, 100, 30),
#            actionButton("action", "Button"),
#            actionButton("action2", "Button2", class = "btn-primary")
#          ),
#          mainPanel(
#            tabsetPanel(
#              tabPanel("Fire Scars Data"),
#              tabPanel("Hotspot")
#            )
#          ),
# )


# # Sidebar with a slider input for number of bins 
# sidebarLayout(
#   sidebarPanel(
#     sliderInput("bins",
#                 "Number of bins:",
#                 min = 1,
#                 max = 50,
#                 value = 30)
#   ),

# # Show a plot of the generated distribution
# mainPanel(
#   plotOutput("distPlot")
# )
# )


# sidebarPanel(
#   textInput("txt", "Text input:", "text here"),
#   sliderInput("slider", "Slider input:", 1, 100, 30),
#   actionButton("action", "Button"),
#   actionButton("action2", "Button2", class = "btn-primary")