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
require(osrm)
library(geosphere)

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
  
  route <- eventReactive(input$submit,{
    # route planning
    dists<-distm(as.vector(points()), lastRefugeDF, fun = distHaversine)
    # sort them in acending distance, prune to first 10 sites
    closestLastRefuges<-lastRefugeDF[order(dists),][1:3,]
    # next find the route to each dist
    list(osrmRoute(src = c("home", points()[1], points()[2]), 
                       dst = c("last refuges", closestLastRefuges[1,1],closestLastRefuges[1,2]),
                       sp = TRUE),
    osrmRoute(src = c("home", points()[1], points()[2]), 
              dst = c("last refuges", closestLastRefuges[2,1],closestLastRefuges[2,2]),
              sp = TRUE),
    osrmRoute(src = c("home", points()[1], points()[2]), 
              dst = c("last refuges", closestLastRefuges[3,1],closestLastRefuges[3,2]),
              sp = TRUE))
    
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
      addPolylines(data = route()[[1]], color="#FF0000") %>%
      addPolylines(data = route()[[2]], color="#00FF00") %>%
      addPolylines(data = route()[[3]], color="#0000FF") %>%
      setView(points()$lon, points()$lat, zoom = 11) %>%
      addCircles(lng=lastRefugeDF$lng, lat=lastRefugeDF$lat, color="#FF0000",fillColor="#00FF00", radius=30, weight=10)
    
      
  })
  
 
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

