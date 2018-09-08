#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(ggmap)

#read in the location data
lastRefugeDF<-read.table('./lastRefuge.csv')
names(lastRefugeDF) <- c('lng','lat')

# Define UI for application that draws a histogram
ui <- fluidPage(theme = "bootstrap.css",
   
   # Application title
   titlePanel("Ready, aim, fire"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        
        textInput("address", "Enter address"), 
        actionButton("submit", label = "Submit")
        
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        leafletOutput("mymap")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  points <- eventReactive(input$submit,{

    geocode(input$address, output = "latlon" , source = "google")

  })
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      # addProviderTiles(providers$Stamen.TonerLite,
      #                  options = providerTileOptions(noWrap = TRUE)
      # ) %>%
      # addMarkers(data = points())
      # addProviderTiles(providers$Stamen.TonerLite,
      #                  options = providerTileOptions(noWrap = TRUE)
      # ) %>%
      addProviderTiles(providers$OpenTopoMap) %>%
      addMarkers(data = points()) %>%
      addCircles(lng=lastRefugeDF$lng, lat=lastRefugeDF$lat, color='#00F')
  })
  
 
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

