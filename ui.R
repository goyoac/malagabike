library(shiny)
library(leaflet)

# Load dataset from a real source
est <- read.csv(url("http://datosabiertos.malaga.eu/recursos/transporte/EMT/estacionamientos/Estacionamientos.csv"))

shinyUI(
        navbarPage("Malaga Cycles",
                   # multi-page UI that includes a navigation bar.
                   tabPanel("Bicycle availability",
                            h2("Bike sharing system of Malaga City"),
                            h3("Available bikes locator by bike station"),
                            sidebarPanel(
                              #verbatimTextOutput('out1'),
                              selectInput('in1', 'Select the bike station', choices = setNames(est$ID,est$NOMBRE), selectize = TRUE)
                            ),
                            mainPanel(
                              h4("No. bikes available"),
                              textOutput('out1'),
                              h4("Available seats parking"),
                              textOutput('out2'),
                              br(),
                              leafletOutput("map", height = 500),
                              h5("* actual data at the time of loading")
                            )
                   ), # end of "Bicycle availability" tab panel
                   
                   tabPanel("Explore dataset",
                            h4("This page let you to explore dataset through a grid, a graph, and even a map view."),
                            htmlOutput("datosabiertos")
                   ), # end of "Explore dataset" tab panel
                   
                   tabPanel("About",
                            mainPanel(
                              includeMarkdown("about.md")
                            )
                   ) # end of "About" tab panel
        )
)
