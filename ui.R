
fluidPage(
  titlePanel(
    "Admissions OFPRA à la protection internationale"
  ),
  sidebarLayout(
    sidebarPanel(
      selectInput("leaf_taux", "Variable", 
                  choices = list("Taux d'admission" = TRUE, "Nombre de demandes" = FALSE), selected = TRUE),
      sliderInput("annee",
                  "Année :",
                  min = min(world_ofpra_wgs84$annee, na.rm = TRUE),  
                  max = max(world_ofpra_wgs84$annee, na.rm = TRUE), 
                  value = max(world_ofpra_wgs84$annee, na.rm = TRUE), 
                  sep = "", 
                  step = 1),
      radioButtons("sexe", h3("Population"), 
                  choices = list("Ensemble" = "global", "Femmes" = "femmes",
                                 "Hommes" = "hommes"), selected = "global"),
      
    #  checkboxInput("leaf_taux", "Taux d'admission", value = TRUE),
    #  checkboxInput("leaf_demandes", "Nombre de demandes", value = TRUE),
       width = 2
    ),
    mainPanel(
      leafletOutput(outputId = 'map', width = "100%", height = 500),
      p("Source : data.gouv"),
      p("L'Office Français de Protection des Réfugiés et Apatrides (OFPRA) est un établissement public administratif qui statue sur les demandes de protection internationale qui lui sont soumises"),
      p("Le taux d'admission à la protection internationale est défini comme rapport entre le nombre de décisions positives (pour l'obtention du statut de réfugié-e ou de la protection subsidiaire) et le nombre total de demandes statuées sur une année donnée"),
      p("Attention, les décisions statuées une année donnée ne correspondent pas forcément aux demandes déposées la même année, mais peuvent porter sur des demandes déposées lors des années antérieures"),
      p("Les pays pour lesquels les demandes concernaient moins de 5 personnes ne sont pas représentés")
    )
  )
)
