source("projettut\\util.R")


# Installation et chargement automatique des packages si nÃ©cessaire
packages <- c("xml2", "RCurl", "RSQLite")
installPackages(packages)
library(xml2)
library(RCurl)
library(RSQLite)
source("database.R")
source("parser.R")
createTables()

urls <- genererUrlsElections()
for(url in urls){
  getBiggerUrlFile(url)
}


url <- "https://www.interieur.gouv.fr/avotreservice/elections/telechargements/LG2012/resultatsT1/001/001com.xml"
aResultat <- parseXmlFile(url)
source("projettut\\database.R")


aResultatLabel <-  c("vote","nbVoteBlanc", "nbVoteNuls", "candidatId", "idTypeElection","idCommune")
aResultatAndCandidatLabel <- c(aResultatLabel,"prenom", "nom", "idPartieCandidat", "nomPartie", "civilite")
start.time <- Sys.time()
d = creerTest(aResultat)


a <- 10
b <- a
a<- 5
a
b
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken


