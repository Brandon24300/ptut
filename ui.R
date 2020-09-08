
page <- navbarPage("Departeo",
            
           tabPanel("Carte",
                    sidebarLayout(
                      sidebarPanel(
                        selectInput("varCarte", 
                                    label = h3("Type Carte"), 
                                    choices = list("Departementale"), 
                                    selected = "Regionale"),
                        
                        selectInput("varElection", 
                                    label = h3("Type Election"), 
                                    choices = list("Presidentielle"), 
                                    selected = "Presidentielle"),
                        
                        selectInput("varAnnee",
                                    label = h3("Annee"), 
                                    choices = list("2012", "2017"), 
                                    selected = "2002"),
                        selectInput("varDepartement",
                                    label = h3("Region"), 
                                    choices = list("001" ,"002", "003", "004", "006", "011"), 
                                    selected = "011"),
                        
                        selectInput("varTypeData",
                                    label = h3("Stats"), 
                                    choices = list("Inscrits",
                                                   "Abstentions",
                                                   "Votants",
                                                   "Blancs.et.nuls",
                                                   "Exprimes"),
                                    selected = "Inscrits"),
                        
                        actionButton("search", "Rechercher"),
                        actionButton("reset","Effacer")
                      ),
                      mainPanel(
                        leafletOutput("mymap", height = "800")
                      )
                    )
           ),
           tabPanel("Explorateur de donnees",
                    DT::dataTableOutput("summary")
           ),
           navbarMenu("More",
                      tabPanel("Table",
                               DT::dataTableOutput("table")
                      ),
                      tabPanel("About",
                               fluidRow(
                              
                               )
                      )
           )
)


