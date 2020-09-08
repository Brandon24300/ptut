library(leaflet)
createTables()
server <- function(input, output, session) {
  
  output$mymap <- renderLeaflet({
    leaflet() %>% addTiles() %>% 
      setView(lng = 1.8883335, lat = 46.603354, zoom = 5)
  })
  
  observeEvent(input$search, {
    typeElection <- input$varElection
    anneeSelectionner <- input$varAnnee
    departementSelectionner <- input$varDepartement
    stats <- input$varTypeData
    urlElection <- paste("https://www.interieur.gouv.fr/avotreservice/elections/telechargements/PR", anneeSelectionner, "/", sep="")
    if (urlDejaParser(urlElection) == FALSE) {
      ajouterUrlParser(urlElection)   
      showNotification("En cours de recuperation des fichiers distants. ~ 20min")
      aUrlsFichiers <- recursiveLoop(urlElection)
      showNotification("Parsage des fichiers. ~ 25 min")
      for (i in 1:length(aUrlsFichiers)) {
        aDataFormatter <- transformXmlToList(aUrlsFichiers[i])
        creerResultatPresidentielle(aDataFormatter)
      }
    }
    showNotification("Fin des recuperations des données")
    villes <- data.frame(Ville = c( "Marseille"),
                         Latitude = c(48.85661400000001, 50.62924999999999, 47.218371, 43.296482),
                         Longitude = c(2.3522219000000177, 3.057256000000052, -1.553621000000021, 5.369779999999992),
                         Population = c(2249975, 227560, 284970, 850726))
    
    output$mymap <-  renderLeaflet({
      leaflet(villes) %>% addTiles() %>%
        addCircles(lng = ~Longitude, lat = ~Latitude, weight = 1,
                   radius = ~sqrt(Population) * 50, popup = ~paste(Ville, ":", Population, "<br> aaaa"),
                   color = "#a500a5", fillOpacity = 0.5)
    })
  
  })
  observeEvent(input$reset, {
    output$mymap <- renderLeaflet({
      leaflet() %>% addTiles() %>% 
        setView(lng = 1.8883335, lat = 46.603354, zoom = 5)
    })
  })
  
  
  output$summary <- DT::renderDataTable({
    DT::datatable(getAllResultatElectionByDepatement())
  })
  
  output$table <- DT::renderDataTable({
    
  })
}