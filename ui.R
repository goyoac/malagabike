library(shiny)
library(leaflet)

# Load dataset from a real source
est <- read.csv(url("http://datosabiertos.malaga.eu/recursos/transporte/EMT/estacionamientos/Estacionamientos.csv"))

shinyUI(
        navbarPage("Malaga Cycles",
                   # multi-page UI that includes a navigation bar.
                   tabPanel("Bicycle availability",
                            # Using select input with dynamic data provisioning
                            h2("Bike sharing system of Malaga City"),
                            h3("Available bikes locator by bike station"),
                            sidebarPanel(
                              selectInput('in1', 'Select the bike station', choices = setNames(est$ID,est$NOMBRE), selectize = TRUE)
                            ),
                            # In the main panel we set a map using leaflet
                            mainPanel(
                              h4("No. bikes available"),
                              textOutput('out1'),
                              h4("Available seats parking"),
                              textOutput('out2'),
                              h4("No. bikes available in the city"),
                              textOutput('out3'),
                              br(),
                              leafletOutput("map", height = 500),
                              h5("* actual data at the time of loading")
                            )
                   ), # end of "Bicycle availability" tab panel
                   
                   # Panel with some info about the app
                   tabPanel("About",
                            mainPanel(
                              includeMarkdown("about.md")
                            )
                   ) # end of "About" tab panel
        )
)
