#' Recupere tous les fichiers xml a partir d'une url de base et recursivement
#' Si elle poss?de des sous dossiers
#' @param url l'url du dossier courant
#' @return l'url du plus grand fichier sur le repertoire courant
getBiggerUrlFile<- function (url)
{
  triTailleFichier <- "?C=S;O=D"
  urlWithSortingParameter <- paste(url,triTailleFichier, sep = "")
  # Lecture url distantes
  htmlContent = readLines(urlWithSortingParameter)
  # Explication condition regex : https://rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf
  # Cette Regex a pour but de recuperer le contenu dans la balise a
  # Nous recherchons toutes chaines commencant par <a 
  # Une fois trouver nous indiquons que nous selectionnons tout les caracteres jusqu'a >
  # Apr?s nous indiquons que nous recuperons n'importe quel caractere entre > et <
  # Et que la fin du pattern se termine par le </a>
  #(<a[^>]*>(.+)<\/a>).+([0-9]+\.?[0-9]+(K|M))
  sRegexATag = "(<a[^>]*>(.+)</a>).+([0-9]+.?[0-9]+(K|M))"
  # La regex nous retourne un tableau en deux dimensions :
  # [][1] = toute la balise a 
  # [][2] = tout le contenu entre <a> ... </a>
  fileUrl <- NULL
  tryCatch(
    expr = {
      allATag = stringr::str_match(htmlContent,sRegexATag)
      allATag <- na.omit(allATag)
      firstATag <- allATag[1,]
      
      if(is_empty(firstATag) == FALSE)
      {
        xmlFileName <- firstATag[3]
        fileUrl <- paste(url, xmlFileName, sep = "")
      }
    },
    error = function(e){
      message('Caught an error!')
      print(e)
    },
    warning = function(w){
      message('Caught an warning!')
      print(w)
    },
    finally = {
      message('All done, quitting.')
    }
  ) 
 
  return(fileUrl)
}

#' Parse un fichier xml de resultat ou de candidat
#' @param url est l'url du fichier 
#' @param model peut prendre la valeur candidat ou resultat
#' @return  Une liste contenant l'ann?e, votesBlanc, votesNul, election, candidats, nomDepartement
parseXmlFile <- function(url)
{
  xmlFile <- read_xml(url);
  aResultat <- "NULL"
  # iNumTour <- xml_text(xml_find_first(x,".//NumTour")) # Extraction nom departement Ain par exemple
  # Example : https://www.interieur.gouv.fr/avotreservice/elections/telechargements/LG2017/resultatsT1/001/001com.xml
  # Si mega fichier faire un grep sur l'url pour juste recup le mega fichier dans le repertoire
  allCommunes <- as_list(xml_find_all(xmlFile,".//Commune"))
  sAnnee <- xml_text(xml_find_first(xmlFile,".//Annee")) # Extraction Annee de l'election
  sTypeElection <- xml_text(xml_find_first(xmlFile,".//Type")) # Extraction Type Election
  sCodeDepartement <- xml_text(xml_find_first(xmlFile,".//CodDpt")) # Extraction cpde departement 01 par exemple
  sNomDepartement <- xml_text(xml_find_first(xmlFile,".//LibDpt")) # Extraction nom departement Ain par exemple
  aResultat <- list(
    communes = allCommunes,
    annee = sAnnee,
    typeElection = sTypeElection,
    codeDepartement = sCodeDepartement,
    nomDepartement = sNomDepartement
  )
  
  return(aResultat)
}

transformXmlToList <- function(url){
  xmlFile <- read_xml(url);
  return(as_list(xml_find_first(xmlFile,"/Election")))
}

compteNbDossiers <- function(contenuPage){
  sRegexAltAttrbute = '<img.+ alt="(\\[DIR\\])'  # Match attribut alt=DIR
  
  
  dfAltAttribute = stringr::str_match(contenuPage,sRegexAltAttrbute) # On applique la regex
  dossiers = table(dfAltAttribute[, 2]) # On compte toutes les occurences de notre array
  nbDossiers = dossiers[names(dossiers)== "[DIR]"] # on recupere le nombbre d'occurence concernant les dossiers
  return(nbDossiers)
}

getDossiers <- function(contenuPage){
  sRegexAltAttrbute = '<a.+>(.+)</a>'  # Match attribut alt=DIR
  dfAltAttribute = stringr::str_match(contenuPage,sRegexAltAttrbute) # On applique la regex
  dossiers <- unique(grep("/", dfAltAttribute[,2], value=TRUE, fixed=TRUE)) # On cherche juste les elements  qui se terminent par /
  return(dossiers)
}

recursiveLoop <- function(urlElections, tableau = c()){
  for( url in urlElections){
    urlContent = readLines(url)
    if (compteNbDossiers(urlContent) > 1) {
      dossiers =  getDossiers(urlContent)
      dossiersWithUrl = paste(url, dossiers, sep = "")
      tableau <- c(tableau, recursiveLoop(dossiersWithUrl, tableau))
    }else{
      tableau <- c(tableau, getBiggerUrlFile(url))
    }
  }
  return(tableau)
}

possedeDossiers <- function(lignePage){
  sRegexAltAttrbute = '<img.+ alt="(\\[DIR\\])'
  dfAltAttribute = stringr::str_match(lignePage,sRegexAltAttrbute) # On applique la regex
  dossiers = table(dfAltAttribute[, 2]) # On compte toutes les occurences de notre array
  nbDossiers = dossiers[names(dossiers) == "[DIR]"] # on recupere le nombbre d'occurence concernant les dossiers
  return(if(length(nbDossiers) != 0)  TRUE else FALSE )
}


#' Recupere les urls des elections departementales, municipales, presidentielles a partir de 2012
#' @return une liste les urls des elections departementales, municipales, presidentielles
genererUrlsElections <- function()
{
  # annee correspond aux premieres donn?es disponibles sur le site du gouvernement
  url <- "https://www.interieur.gouv.fr/avotreservice/elections/telechargements/"
  htmlContent = readLines(url)
  # Explication condition regex : https://rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf
  # Regex qui recupere tout le contenu dans le a tag seulement si 
  # Le pattern dans la balise a commence par DP ou MN ou PR
  # Et que le caractere ou les caracteres qui suivent sont des nombres
  sRegexATag = "<a[^>]+>((DP|MN|PR)([0-9]+))"
  allATag = stringr::str_match_all(htmlContent,sRegexATag)
  aListUrlGenerer <- c()
  for (aTag in allATag) 
  {
    sTypeElectionEtAnnee <- aTag[,2]
    iAnnee <- aTag[,4]
    # On skip l'iteration
    if (is_empty(sTypeElectionEtAnnee) || iAnnee < 2012 ) {
      next
    }
    # On prend le contenu entre la les crochets du <a> </a>
    sUrlElection = paste(url, sTypeElectionEtAnnee, sep = "")
    aListUrlGenerer <- c(aListUrlGenerer, sUrlElection)
  }
  aListUrlGenerer <- paste(aListUrlGenerer, "/", sep="")
  return(aListUrlGenerer)
}