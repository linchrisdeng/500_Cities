library(shiny)
library(tidyverse)
library(leaflet)
library(leaflet.extras)
# Prepare dataset

# Define server logic required to draw a histogram
shinyServer(function(input, output, session){
  
  ## Select State
  observeEvent(
    input$StateAbbr,
    updateSelectInput(session, "PlaceName",
                      "Selected City: ",
                      choices = df$PlaceName[df$StateAbbr == input$StateAbbr]))
  
  ## getdata reactive
  getdata = reactive(df %>%
                       filter(StateAbbr == input$StateAbbr) %>%
                       filter(PlaceName == input$PlaceName)
                       )
  
  
  
  maxlat = reactive(getdata() %>% select(latitude) %>% max(.))
  maxlng = reactive(getdata() %>% select(longitude) %>% max(.))
  minlat = reactive(getdata() %>% select(latitude) %>% min(.))
  minlng = reactive(getdata() %>% select(longitude) %>% min(.))

    ## Leaflet  
  
  output$selected_map <- renderLeaflet({
      leaflet(data = getdata()) %>%
      addMiniMap() %>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)) %>%
      fitBounds(lng1 = maxlng(), lng2 = minlng(),
                   lat1 = maxlat(), lat2 = minlat())%>%
      addResetMapButton()

  })
  

  observe({
    radiusdata = getdata()[[input$Measure]]
    min_max_norm = function(x){
      return((x-min(x))/(max(x)-min(x)))
    }
    radius = min_max_norm(radiusdata) * 1300
    
    # radius =  getdata()[[input$Measure]] * 35
    colordata = getdata()[[input$Measure]]
    pal = colorNumeric(palette = "magma", domain =colordata, reverse = TRUE)
    
    leafletProxy("selected_map", data = getdata()) %>%
      clearShapes() %>%
      addCircles(lng = ~longitude, lat = ~latitude, 
                 stroke = FALSE, radius = radius, 
                 fillColor = pal(colordata), fillOpacity = 0.6, 
                 label = ~paste0("POP: ", radiusdata)) %>%
      clearControls() %>%
      leaflet::addLegend("bottomleft", pal = pal, values = colordata, 
                title = "Census Tract") 
  

  })
})