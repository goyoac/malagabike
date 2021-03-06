library(shiny)
library(leaflet)

# Load dataset from a real source
est <- read.csv(url("http://datosabiertos.malaga.eu/recursos/transporte/EMT/estacionamientos/Estacionamientos.csv"))

# Shiny Server
shinyServer(function(input, output) {

  # getting the number of free bikes
  output$out1 <- renderText(est[est$ID==input$in1,'NUM_OCUPADOS'])
  # getting the number of free docks
  output$out2 <- renderText(est[est$ID==input$in1,'NUM_LIBRES'])
  # doing some simple computation getting the total number of free bikes
  output$out3 <- renderText(sum(est$'NUM_OCUPADOS'))
  
  # getting the location of the selected bike station and setting it in the map
  output$map <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>%
      addMarkers(lng=est[est$ID==input$in1,'LON'],lat=est[est$ID==input$in1,'LAT'], popup=est[est$ID==input$in1,'DIRECCION'])
  }) 
})