library(gt)
library(magrittr)
library(FNN)
library(tidyverse)
library(broom)
library(dplyr)
library(shiny)
library(leaflet)
library(RColorBrewer)
library(sf)

data(metro)
ParisAirbnb <- read.csv("parisairbnb.csv")

ParisShape <- read_sf("paris.geojson")
ParisShape <- st_transform(ParisShape, crs = 4326)

ParisAirbnb <- ParisAirbnb[,c("latitude",{"longitude"}, {"price"}, {"name"})]


ParisAirbnbC <- ParisAirbnb[,c ("latitude", {"longitude"})]
ParisMetroC <- metro[,c("latitude", "longitude")]

nearest_subway <- get.knnx(ParisMetroC, ParisAirbnbC, k=1)
ParisAirbnb$nearest_subway_distance <- nearest_subway$nn.dist * 1000

model <- lm(price ~ nearest_subway_distance, data = ParisAirbnb)
summary(model)

app4_ui <- fluidPage(
  titlePanel("Paris Airbnb and Metro Map"),
  
  mainPanel(
    leafletOutput("map", height = "1200px", width = "150%")
  )
)

app4_server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
    m <- leaflet(data=ParisShape) %>%
      addTiles(urlTemplate = "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png") %>%
      setView(lng = 2.3514, lat = 48.8575, zoom = 13) %>%
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
        label = ~name 
        
      )
    m <- m %>%
      addCircleMarkers(data = ParisAirbnb,
                       lng = ~longitude, lat = ~latitude,
                       color = palette(brewer.pal(n=3,name ='YlGn')),
                       radius = 3,
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
        labels = c("Metro Stop"),
        title = "Metro Legend"
      )
    
    m <- m %>%
      addCircleMarkers(data = metro,
                       lng = ~longitude, lat = ~latitude,
                       color = "blue", radius = 8,
                       popup = ~paste("<br>Stop Name: ", name, "<br>Location: ", location))
    
    m
  })
}
