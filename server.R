library(shiny)
library(leaflet)

# Load dataset from a real source
est <- read.csv(url("http://datosabiertos.malaga.eu/recursos/transporte/EMT/estacionamientos/Estacionamientos.csv"))

# Shiny Server
shinyServer(function(input, output) {

  # getting the number of free bikes
  output$out1 <- renderText(est[est$ID==input$in1,'NUM_OCUPADOS'])
  output$out2 <- renderText(est[est$ID==input$in1,'NUM_LIBRES'])
  
  # getting the location of the selected bike station and setting it in the map
  output$map <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>%
      addMarkers(lng=est[est$ID==input$in1,'LON'],lat=est[est$ID==input$in1,'LAT'], popup=est[est$ID==input$in1,'DIRECCION'])
  }) 
  
  # setting some html code to embed it int the "Explore dataset" tab panel
  output$datosabiertos <- renderUI({tags$iframe(
              src = "http://datosabiertos.malaga.eu/dataset/malaga-bici/resource/3bb304f9-9de3-4bac-943e-7acce7e8e8f9/view/e1eaaf64-da38-478c-9067-e25fcef71a5b", 
              width = "1000",
              height="660",
              seamless="seamless")
  })
              
})