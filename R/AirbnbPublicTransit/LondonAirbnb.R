library(shiny)
library(leaflet)
library(dplyr)
library(tidyverse)
library(RColorBrewer)
library(sf)
library(FNN)  

LondonAirbnb = read.csv("C:\\Users\\nbwan\\Documents\\RStudio\\airbnb\\LondonAirbnb.csv")
tube <- read.csv("C:\\Users\\nbwan\\Documents\\RStudio\\airbnb\\LondonTube.csv")

LDNshape <- read_sf("C:\\Users\\nbwan\\Documents\\RStudio\\airbnb\\statistical-gis-boundaries-london\\statistical-gis-boundaries-london\\ESRI\\London_Borough_Excluding_MHW.shp")
LDNshape <- st_transform(LDNshape, crs = 4326)

LondonAirbnb <- LondonAirbnb[, c("latitude", "longitude", "price", "name")]

LondonAirbnb  <- na.omit(LondonAirbnb)
tube <- na.omit(tube)

londoncoord <- LondonAirbnb[,c ("latitude", "longitude")]
tubecoord <- tube[,c("Latitude", "Longitude")]

nearest_subway <- get.knnx(tubecoord, londoncoord, k=1)
LondonAirbnb$nearest_subway_distance <- nearest_subway$nn.dist * 1000

model <- lm(price ~ nearest_subway_distance, data = LondonAirbnb)
summary(model)

app3_ui <- fluidPage(
  titlePanel("London Airbnb and Tube Map"),
  
  mainPanel(
    leafletOutput("map", height = "1200px", width = "150%")
  )
)

app3_server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
    m <- leaflet(data=LDNshape) %>%
      addTiles(urlTemplate = "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png") %>%
      setView(lng = -0.13392, lat = 51.51022, zoom = 11) %>%
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
        label = ~NAME 
        
      )
    m <- m %>%
      addCircleMarkers(data = LondonAirbnb,
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
      addCircleMarkers(data = tube,
                       lng = ~Longitude, lat = ~Latitude,
                       color = "blue", radius = 8,
                       popup = ~paste("<br>Stop Name: ", Name, "<br>Line: ", Line))
    
    m
  })
}


