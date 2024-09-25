library(magrittr)
library(FNN)
library(tidyverse)
library(broom)
library(dplyr)
library(shiny)
library(leaflet)
library(RColorBrewer)
library(sf)

sf <- read.csv("sf.csv")
sm <- read.csv("sanmateo.csv")
sc <- read.csv("santaclara.csv")
oak <- read.csv("oakland.csv")
shape <- read_sf("ca_counties\\CA_Counties.shp")

SFBayShape <- shape[shape$NAME %in% c("San Francisco", "San Mateo", "Santa Clara", "Alameda"), ]
SFBayShape <- st_transform(SFBayShape, crs = 4326)

stations <- read.csv("Station_Names.csv")

sfcoord <- sf[,c("latitude",{"longitude"})]
stationcoord <- stations[,c("Latitude",{"Longitude"})]

nearest_subway <- get.knnx(stationcoord, sfcoord, k = 1)
sf$nearest_station_dist <- nearest_subway$nn.dist * 1000 

sfcoord <- sf[, c("latitude", "longitude", "price", "name", "nearest_station_dist")]
stationcoord <- stations[, c("Latitude", "Longitude", "Station.Name", "Type")]

model <- lm(price ~ nearest_station_dist, data = sf)
summary(model)


smcoord <- sm[,c("latitude",{"longitude"})]
stationcoord <- stations[,c("Latitude",{"Longitude"})]

nearest_subway <- get.knnx(stationcoord, smcoord, k = 1)
sm$nearest_station_dist <- nearest_subway$nn.dist * 1000 

smcoord <- sm[, c("latitude", "longitude", "price", "name", "nearest_station_dist")]
stationcoord <- stations[, c("Latitude", "Longitude", "Station.Name", "Type")]

model <- lm(price ~ nearest_station_dist, data = sm)
summary(model)


sccoord <- sc[,c("latitude",{"longitude"})]
stationcoord <- stations[,c("Latitude",{"Longitude"})]

nearest_subway <- get.knnx(stationcoord, sccoord, k = 1)
sc$nearest_station_dist <- nearest_subway$nn.dist * 1000 

sccoord <- sc[, c("latitude", "longitude", "price", "name", "nearest_station_dist")]
stationcoord <- stations[, c("Latitude", "Longitude", "Station.Name", "Type")]

model <- lm(price ~ nearest_station_dist, data = sc)
summary(model)


oakcoord <- oak[,c("latitude",{"longitude"})]
stationcoord <- stations[,c("Latitude",{"Longitude"})]

nearest_subway <- get.knnx(stationcoord, oakcoord, k = 1)
oak$nearest_station_dist <- nearest_subway$nn.dist * 1000 

oakcoord <- oak[, c("latitude", "longitude", "price", "name", "nearest_station_dist")]
stationcoord <- stations[, c("Latitude", "Longitude", "Station.Name", "Type")]

model <- lm(price ~ nearest_station_dist, data = oak)
summary(model)


app2_ui <- fluidPage(
  titlePanel("Bay Area Airbnb and Train Map"),
  
  mainPanel(
    leafletOutput("map", height = "1200px", width = "150%")
  )
)

app2_server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
    m <- leaflet(data = SFBayShape) %>%
      addTiles("https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png") %>%
      setView(lng = -122.2711, lat = 37.5585, zoom = 11) %>%
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
      addCircleMarkers(data = sfcoord,
                       lng = ~longitude, lat = ~latitude,
                       color = palette(brewer.pal(n=3,name ='YlGn')),
                       radius = 4,
                       popup = ~paste("<br>Name: ", name, "<br>Price: $", price, "<br>Distance: ", nearest_station_dist),
                       stroke = FALSE, fillOpacity = 0.7)
    
    
    m <- m %>%
      addCircleMarkers(data = smcoord,
                       lng = ~longitude, lat = ~latitude,
                       color = palette(brewer.pal(n=3,name ='YlGn')),
                       radius = 4,
                       popup = ~paste("<br>Name: ", name, "<br>Price: $", price, "<br>Distance: ", nearest_station_dist),
                       stroke = FALSE, fillOpacity = 0.7)
    
    m <- m %>%
      addCircleMarkers(data = sccoord,
                       lng = ~longitude, lat = ~latitude,
                       color = palette(brewer.pal(n=3,name ='YlGn')),
                       radius = 4,
                       popup = ~paste("<br>Name: ", name, "<br>Price: $", price, "<br>Distance: ", nearest_station_dist),
                       stroke = FALSE, fillOpacity = 0.7)
    
    m <- m %>%
      addCircleMarkers(data = oakcoord,
                       lng = ~longitude, lat = ~latitude,
                       color = palette(brewer.pal(n=3,name ='YlGn')),
                       radius = 4,
                       popup = ~paste("<br>Name: ", name, "<br>Price: $", price, "<br>Distance: ", nearest_station_dist),
                       stroke = FALSE, fillOpacity = 0.7)
    
    
    m <- m %>%
      addCircleMarkers(
        data = stationcoord,
        lng = ~Longitude, lat = ~Latitude,
        color = ~ifelse(stationcoord$Type == 1, "blue", "red"),
        radius = 10,
        popup = ~paste("<br>Station Name: ", Station.Name)
      )
    
    
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
        colors = c("blue", "red"),
        labels = c("BART Stop", "Caltrain Stop"),
        title = "Train Type"
      )
    
    m
  })
}
