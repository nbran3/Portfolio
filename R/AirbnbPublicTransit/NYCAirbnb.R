library(magrittr)
library(FNN)
library(tidyverse)
library(broom)
library(dplyr)
library(shiny)
library(leaflet)
library(RColorBrewer)
library(sf)

NYCshapefile = read_sf("Borough Boundaries/geo_export_d079e284-a4b2-4fcd-8acc-1e851205e8ce.shp")
NYCairbnb <- read.csv("new_york_listings_2024.csv")
NYCmetrodata <- read.csv("MTA_Subway_Stations.csv")

NYCairbnbcoord <- NYCairbnb[,c("latitude",{"longitude"})]
NYCmetrocoord <- NYCmetrodata[,c("GTFS.Latitude",{"GTFS.Longitude"})]

nearest_subway <- get.knnx(NYCmetrocoord, NYCairbnbcoord, k = 1)
NYCairbnb$nearest_subway_distance <- log(nearest_subway$nn.dist + 1e-6)

NYCairbnbcoord <- NYCairbnb[,c("latitude",{"longitude"}, {"price"}, {"name"},{"nearest_subway_distance"})]
NYCmetrocoord <- NYCmetrodata[,c("GTFS.Latitude",{"GTFS.Longitude"}, {"Station.ID"}, {"Stop.Name"}, {"Line"})]

model <- lm(price ~ nearest_subway_distance, data = NYCairbnb)
summary(model)


app1_ui <- fluidPage(
  titlePanel("NYC Airbnb and Subway Map"),
  
  mainPanel(
    leafletOutput("map", height = "1200px", width = "150%")
  )
)

app1_server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
    m <- leaflet(data=NYCshapefile) %>%
      addTiles("https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png") %>%
      setView(lng = -74.0060, lat = 40.7128, zoom = 12) %>%
      addPolygons(
        color = "#444444",  
        weight =1,           
        fillColor = "gray", 
        fillOpacity = 0.5,  
        highlight = highlightOptions(
          weight = 2,       
          color = "#666666",
          fillOpacity = 0.7 
        ),
        label = ~boro_name   
        
      )
    
    m <- m %>%
      addCircleMarkers(data = NYCairbnbcoord,
                       lng = ~longitude, lat = ~latitude,
                       color = palette(brewer.pal(n=3,name ='YlGn')),
                       radius = 4,
                       popup = ~paste("<br>Name: ", name, "<br>Price: $", price, "<br>Distance: ", nearest_subway_distance),
                       stroke = FALSE, fillOpacity = 0.7)
    
    
    m <- m %>%
      addLegend(
        position = "topright",
        colors = palette(brewer.pal(n=3,name ='YlGn')),
        labels = c("Low", "Medium", "High"),
        title = "Price Legend"
      )
    
    m <- m %>%
      addLegend(
        position = "bottomright",
        colors = c("blue"),
        labels = c("MTA Stop"),
        title = "MTA Legend"
      )
    
    
    m <- m %>%
      addCircleMarkers(data = NYCmetrocoord,
                       lng = ~GTFS.Longitude, lat = ~GTFS.Latitude,
                       color = "blue", radius = 6,
                       popup = ~paste("<br>Stop Name: ", Stop.Name,"<br>Line: ", Line,"<br>Station ID: ", Station.ID))
    
    m
  })
}
