library(shiny)
library(leaflet)
library(dplyr)
library(tidyverse)
library(RColorBrewer) 

ui <- fluidPage(
  titlePanel("Multi-App Shiny Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput("app_select", "Select an app:", 
                  choices = c("NYC Airbnb and Subway Map", "Bay Area Airbnb and Train Map", "London Airbnb and Tube Map", "Paris Airbnb and Metro Map"))
    ),
    mainPanel(
      uiOutput("app_ui")
    )
  )
)

server <- function(input, output, session) {
  output$app_ui <- renderUI({
    if (input$app_select == "NYC Airbnb and Subway Map") {
      source("NYCAirbnb.R", local = TRUE)
      app1_ui 
    } else if (input$app_select == "Bay Area Airbnb and Train Map") {
      source("SFAirbnb.R", local = TRUE)
      app2_ui 
    } else if (input$app_select == "London Airbnb and Tube Map") {
      source("LondonAirbnb.R", local = TRUE)
      app3_ui 
    } else if (input$app_select == "Paris Airbnb and Metro Map") {
      source("ParisAirbnb.R", local = TRUE)
      app4_ui 
    }
  })
  
  observe({
    if (input$app_select == "NYC Airbnb and Subway Map") {
      app1_server(input, output, session)  
    } else if (input$app_select == "Bay Area Airbnb and Train Map") {
      app2_server(input, output, session)  
    } else if (input$app_select == "London Airbnb and Tube Map") {
      app3_server(input, output, session)
    } else if (input$app_select == "Paris Airbnb and Metro Map") {
      app4_server(input, output, session)
    }
  })
}

shinyApp(ui = ui, server = server)




