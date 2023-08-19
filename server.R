

function(input, output, session) {
  
  # Reactive expression for the data subsetted to what the user selected
  filteredData <- reactive({
    subset(world_ofpra_wgs84, world_ofpra_wgs84$sexe == input$sexe & world_ofpra_wgs84$annee == input$annee 
          & world_ofpra_wgs84$leaf_taux == input$leaf_taux
          )
  })
  
  
  output$map <- renderLeaflet({
    # Use leaflet() here, and only include aspects of the map that
    # won't need to change dynamically (at least, not unless the
    # entire map is being torn down and recreated).
    
    leaflet(world_ofpra_wgs84) %>% addTiles(options = providerTileOptions(minZoom = 1.5, maxZoom = 4.5)) %>%
      setView(lng = 33, lat = 15, zoom = 1.5)
      
  })
  
  
  # Incremental changes to the map 
  observe({

    #Setting up the pop up text
    popup_sb <- with(filteredData(), 
                     paste('<b>', nationalite, '</b>', '<br>',
                           "Nombre de demandes : ", nb_demandes ,'<br>',
                           "Taux d'admission : ", taux_admission_p, "%"))
    
    leafletProxy("map", data = filteredData()) %>%
      clearShapes() %>%
      addPolygons(
       # data = map, 
        label = ~nationalite,
        popup = ~popup_sb,
        fill = TRUE, 
        color = "black",
        weight = 1,
        #  color = "black",
        # Application de la fonction palette
        fillColor = ~pal(filteredData()$taux_admission_p_clear),
        fillOpacity = 0.6,
        highlightOptions = highlightOptions(color = "white", weight = 2)) %>%
      
      addPolygons(
        # data = map, 
        label = ~nationalite,
        popup = ~popup_sb,
        fill = TRUE, 
        color = "black",
        weight = 1,
        #  color = "black",
        # Application de la fonction palette
        fillColor = ~pal2(filteredData()$nb_demandes_discret_clear),
        fillOpacity = 0.6,
        highlightOptions = highlightOptions(color = "white", weight = 2))
    
    # Use a separate observer to recreate the legend as needed.
    observe({
      proxy <- leafletProxy("map", data = filteredData())
      
      # Remove any existing legend, and only if the legend is
      # enabled, create a new one.
      proxy %>% clearControls()
      if (input$leaf_taux == TRUE) {
        proxy %>%
          addLegend(position = "bottomleft",
                    title = "Taux d'admission",
                    pal = pal, values = world_ofpra_wgs84$taux_admission_p, na.label = "Pas de données")
      }
      if (input$leaf_taux == FALSE) {
        proxy %>%
          addLegend(position = "bottomleft",
                    title = "Nombre de demandes statuées",
                    pal = pal2, values = world_ofpra_wgs84$nb_demandes_discret_clear, na.label = "Pas de données")
      }
    })
 
      })

  
    }


