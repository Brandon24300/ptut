db <- NULL

createTables <- function(){
  db <- getDbConnexion()
  
  dbExecute(conn = db,
            "CREATE TABLE IF NOT EXISTS Regions (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              code CHAR(3)  NOT NULL,
              name TEXT  NOT NULL
          )"
  )
  
  # Insertions des Regions
  dbExecute(conn = db,
            "INSERT OR IGNORE INTO Regions VALUES (1,'01','Guadeloupe'),(2,'02','Martinique'),(3,'03','Guyane'),(4,'04','La R?union'),(5,'06','Mayotte'),(6,'11','?le-de-France'),(7,'24','Centre-Val de Loire'),(8,'27','Bourgogne-Franche-Comt?'),(9,'28','Normandie'),(10,'32','Hauts-de-France'),(11,'44','Grand Est'),(12,'52','Pays de la Loire'),(13,'53','Bretagne'),(14,'75','Nouvelle-Aquitaine'),(15,'76','Occitanie'),(16,'84','Auvergne-Rhône-Alpes')")
  
  dbExecute(conn = db,
            "INSERT OR IGNORE INTO Regions VALUES (17,'93','Provence-Alpes-Côte d''Azur' ),
            (18,'94','Corse'),
            (19,'COM','Collectivités d''Outre-Mer') ")
  
  # Creation table departement
  dbExecute(conn = db,
       "CREATE TABLE IF NOT EXISTS Departement (
         idDpt INTEGER PRIMARY KEY AUTOINCREMENT,
         region_code CHAR(3)  NOT NULL,
         code CHAR(3)  NOT NULL,
         nomDpt TEXT NOT NULL,
         slug TEXT  NOT NULL,
        FOREIGN KEY (`region_code`) REFERENCES Regions (`code`)
      ) "
   )
  

  dbExecute(conn = db,
           "INSERT OR IGNORE INTO Departement VALUES (1,'84','01','Ain','ain'),(2,'32','02','Aisne','aisne'),(3,'84','03','Allier','allier'),(4,'93','04','Alpes-de-Haute-Provence','alpes de haute provence'),(5,'93','05','Hautes-Alpes','hautes alpes'),(6,'93','06','Alpes-Maritimes','alpes maritimes'),(7,'84','07','Ard?che','ardeche'),(8,'44','08','Ardennes','ardennes'),(9,'76','09','Ari?ge','ariege'),(10,'44','10','Aube','aube'),(11,'76','11','Aude','aude'),(12,'76','12','Aveyron','aveyron'),(13,'93','13','Bouches-du-Rh?ne','bouches du rhone'),(14,'28','14','Calvados','calvados'),(15,'84','15','Cantal','cantal'),(16,'75','16','Charente','charente'),(17,'75','17','Charente-Maritime','charente maritime'),(18,'24','18','Cher','cher'),(19,'75','19','Corr?ze','correze'),(20,'27','21','C?te-d''Or','cote dor'),(21,'53','22','C?tes-d''Armor','cotes darmor'),(22,'75','23','Creuse','creuse'),(23,'75','24','Dordogne','dordogne'),(24,'27','25','Doubs','doubs'),(25,'84','26','Dr?me','drome'),(26,'28','27','Eure','eure'),(27,'24','28','Eure-et-Loir','eure et loir'),(28,'53','29','Finist?re','finistere'),(29,'94','2A','Corse-du-Sud','corse du sud'),(30,'94','2B','Haute-Corse','haute corse'),(31,'76','30','Gard','gard'),(32,'76','31','Haute-Garonne','haute garonne'),(33,'76','32','Gers','gers'),(34,'75','33','Gironde','gironde'),(35,'76','34','H?rault','herault'),(36,'53','35','Ille-et-Vilaine','ille et vilaine'),(37,'24','36','Indre','indre'),(38,'24','37','Indre-et-Loire','indre et loire'),(39,'84','38','Is?re','isere'),(40,'27','39','Jura','jura'),(41,'75','40','Landes','landes'),(42,'24','41','Loir-et-Cher','loir et cher'),(43,'84','42','Loire','loire'),(44,'84','43','Haute-Loire','haute loire'),(45,'52','44','Loire-Atlantique','loire atlantique'),(46,'24','45','Loiret','loiret'),(47,'76','46','Lot','lot'),(48,'75','47','Lot-et-Garonne','lot et garonne'),(49,'76','48','Loz?re','lozere'),(50,'52','49','Maine-et-Loire','maine et loire'),(51,'28','50','Manche','manche'),(52,'44','51','Marne','marne'),(53,'44','52','Haute-Marne','haute marne'),(54,'52','53','Mayenne','mayenne'),(55,'44','54','Meurthe-et-Moselle','meurthe et moselle'),(56,'44','55','Meuse','meuse'),(57,'53','56','Morbihan','morbihan'),(58,'44','57','Moselle','moselle'),(59,'27','58','Ni?vre','nievre'),(60,'32','59','Nord','nord'),(61,'32','60','Oise','oise'),(62,'28','61','Orne','orne'),(63,'32','62','Pas-de-Calais','pas de calais'),(64,'84','63','Puy-de-D?me','puy de dome'),(65,'75','64','Pyr?n?es-Atlantiques','pyrenees atlantiques'),(66,'76','65','Hautes-Pyr?n?es','hautes pyrenees'),(67,'76','66','Pyr?n?es-Orientales','pyrenees orientales'),(68,'44','67','Bas-Rhin','bas rhin'),(69,'44','68','Haut-Rhin','haut rhin'),(70,'84','69','Rh?ne','rhone'),(71,'27','70','Haute-Sa?ne','haute saone'),(72,'27','71','Sa?ne-et-Loire','saone et loire'),(73,'52','72','Sarthe','sarthe'),(74,'84','73','Savoie','savoie'),(75,'84','74','Haute-Savoie','haute savoie'),(76,'11','75','Paris','paris'),(77,'28','76','Seine-Maritime','seine maritime'),(78,'11','77','Seine-et-Marne','seine et marne'),(79,'11','78','Yvelines','yvelines'),(80,'75','79','Deux-S?vres','deux sevres'),(81,'32','80','Somme','somme'),(82,'76','81','Tarn','tarn'),(83,'76','82','Tarn-et-Garonne','tarn et garonne'),(84,'93','83','Var','var'),(85,'93','84','Vaucluse','vaucluse'),(86,'52','85','Vend?e','vendee'),(87,'75','86','Vienne','vienne'),(88,'75','87','Haute-Vienne','haute vienne'),(89,'44','88','Vosges','vosges'),(90,'27','89','Yonne','yonne'),(91,'27','90','Territoire de Belfort','territoire de belfort'),(92,'11','91','Essonne','essonne'),(93,'11','92','Hauts-de-Seine','hauts de seine'),(94,'11','93','Seine-Saint-Denis','seine saint denis'),(95,'11','94','Val-de-Marne','val de marne'),(96,'11','95','Val-d''Oise','val doise'),(97,'01','971','Guadeloupe','guadeloupe'),(98,'02','972','Martinique','martinique'),(99,'03','973','Guyane','guyane'),(100,'04','974','La R?union','la reunion'),(101,'06','976','Mayotte','mayotte'),(102,'COM','975','Saint-Pierre-et-Miquelon','saint pierre et miquelon'),(103,'COM','977','Saint-Barth?lemy','saint barthelemy'),(104,'COM','978','Saint-Martin','saint martin'),(105,'COM','984','Terres australes et antarctiques fran?aises','terres australes et antarctiques francaises'),(106,'COM','986','Wallis et Futuna','wallis et futuna'),(107,'COM','987','Polyn?sie fran?aise','polynesie francaise'),(108,'COM','988','Nouvelle-Cal?donie','nouvelle caledonie'),(109,'COM','989','?le de Clipperton','ile de clipperton');
" 
            )
  
  
  dbExecute(conn = db,
              "
      CREATE TABLE IF NOT EXISTS BureauVote(
        idBureauVote TEXT PRIMARY KEY,
        dptId INT NOT NULL,
        foreign key(dptId) references Departement(idDpt)
    );"
  )
  
  dbExecute(conn = db,"INSERT OR IGNORE INTO BureauVote VALUES('-1', 2)") 
  
  dbExecute(conn = db,
        "CREATE TABLE IF NOT EXISTS TypeElection(
          idTypeElection INTEGER PRIMARY KEY AUTOINCREMENT,
          nomTypeElection CHAR(50) NOT NULL
        );"
  )
  dbExecute(conn = db,"INSERT OR IGNORE INTO TypeElection VALUES (null, 'Presidentielle')") 
  
  dbExecute(conn = db,
              "
        CREATE TABLE IF NOT EXISTS Election(
          idElection INTEGER PRIMARY KEY AUTOINCREMENT,
          annee INT NOT NULL,
          typeElectionId INT NOT NULL,
          foreign key(typeElectionId) references TypeElection(idTypeElection)
        );
        "
  )
  dbExecute(conn = db,"INSERT OR IGNORE INTO Election VALUES (null, 2012, 0)")
  dbExecute(conn = db,"INSERT OR IGNORE INTO Election VALUES (null, 2017, 0)")
  
  dbExecute(conn = db,
              "
         CREATE TABLE IF NOT EXISTS PartiPolitique(
    idPartiPolitique INTEGER PRIMARY KEY AUTOINCREMENT,
    libelleParti CHAR(50) NOT NULL);
        "
  )
  dbExecute(conn = db,"INSERT OR IGNORE INTO PartiPolitique VALUES (null, 'Front National')")
  dbExecute(conn = db,"INSERT OR IGNORE INTO PartiPolitique VALUES (null, 'Fédération anarchiste')")
  dbExecute(conn = db,"INSERT OR IGNORE INTO PartiPolitique VALUES (null, 'Mouvement radical')")
  dbExecute(conn = db,"INSERT OR IGNORE INTO PartiPolitique VALUES (null, 'Nous Citoyens')")
  dbExecute(conn = db,"INSERT OR IGNORE INTO PartiPolitique VALUES (null, 'Parti ecologique')")
  dbExecute(conn = db,"INSERT OR IGNORE INTO PartiPolitique VALUES (null, 'Parti animaliste')")
  
  dbExecute(conn = db,
              "
          CREATE TABLE IF NOT EXISTS Candidat(
            idCandidat INTEGER primary key AUTOINCREMENT,
            nomCandidat char(50) not null,
            prenomCandidat char(50) not null,
            sexe char(10),
            partiPolitiqueId int not null,
            foreign key(partiPolitiqueId) references PartiPolitique(idPartiPolitique)
          );
        "
  )
  dbExecute(conn = db,"INSERT OR IGNORE INTO Candidat VALUES (null, 'C', 'Matthias', 'Homme', 0)")
  dbExecute(conn = db,"INSERT OR IGNORE INTO Candidat VALUES (null, 'Guitet', 'Antoine', 'Homme', 1)")
  dbExecute(conn = db,"INSERT OR IGNORE INTO Candidat VALUES (null, 'Sarkozy', 'Nicolas', 'Homme', 2)")
  dbExecute(conn = db,"INSERT OR IGNORE INTO Candidat VALUES (null, 'Royal', 'Segolene', 'Femme', 3)")
  dbExecute(conn = db,"INSERT OR IGNORE INTO Candidat VALUES (null, 'Melenchon', 'Jean-Luc', 'Homme', 4)")
  dbExecute(conn = db,"INSERT OR IGNORE INTO Candidat VALUES (null, 'Macron', 'Emmanuel', 'Homme', 5)")
  dbExecute(conn = db,"INSERT OR IGNORE INTO Candidat VALUES (null, 'Sarkozy', 'Nicolas', 'Homme', 2)")
  dbExecute(conn = db,"INSERT OR IGNORE INTO Candidat VALUES (null, 'Hamont', 'Benoit', 'Homme', 2)")
  dbExecute(conn = db,"INSERT OR IGNORE INTO Candidat VALUES (null, 'LePen', 'Marie', 'Femme', 0)")
  dbExecute(conn = db,
              "
         CREATE TABLE IF NOT EXISTS Resultat(
            idResultat INTEGER primary key AUTOINCREMENT,
            votes int,
            votesBlanc int,
            votesNul int,
            electionId int,
            candidatId int,
            bureauVoteId TEXT,
            foreign key(electionId) references Election(idElection),
            foreign key(candidatId) references Candidat(idCandidat),
            foreign key(bureauVoteId) references BureauVote(idBureauVote)
          );
        "
  )
   dbExecute(conn = db,"INSERT OR IGNORE INTO Resultat VALUES (null, 200, 0, 0, 0, 0, 0)")
   dbExecute(conn = db,"INSERT OR IGNORE INTO Resultat VALUES (null, 250, 0, 0, 0, 1,0)")
   dbExecute(conn = db,"INSERT OR IGNORE INTO Resultat VALUES (null, 175, 0, 0, 0, 2,0)")
   dbExecute(conn = db,"INSERT OR IGNORE INTO Resultat VALUES (null, 221, 0, 0, 0, 3,0)")
   dbExecute(conn = db,"INSERT OR IGNORE INTO Resultat VALUES (null, 425, 0, 0, 0, 4,0)")
   dbExecute(conn = db,"INSERT OR IGNORE INTO Resultat VALUES (null, 679, 0, 0, 0, 5,0)")
   dbExecute(conn = db,"INSERT OR IGNORE INTO Resultat VALUES (null, 348, 0, 0, 0, 6,0)")
   dbExecute(conn = db,"INSERT OR IGNORE INTO Resultat VALUES (null, 1963, 0, 0, 0, 7,0)")
   dbExecute(conn = db,"INSERT OR IGNORE INTO Resultat VALUES (null, 111, 0, 0, 0, 8,0)")
   
   
   dbExecute(conn = db,
             "
         CREATE TABLE IF NOT EXISTS ResultatV(
            idResultat INTEGER primary key AUTOINCREMENT,
            votes int,
            votesBlanc int,
            votesNul int,
            iNumTour int,
            iAneee int,
            election TEXT,
            candidat TEXT,
            ville TEXT,
            codeDepartement TEXT,
            nomDepartement TEXT
          );
        "
   )
   
   dbExecute(conn = db,
             "
         CREATE TABLE IF NOT EXISTS urlParser(
            id INTEGER primary key AUTOINCREMENT,
            url TEXT
          );
        "
   )

  dbDisconnect(conn = db)
}

getDbConnexion <- function(){
  if(is.null(db)){
    driver <- SQLite()
    db <- dbConnect(driver, dbname = "stockage.sqlite", journal_mode = "off", synchronous = "off", cache_size = "100000")
    #journal_mode = "off", synchronous = "off", cache_size = "100000"
  }

  return(db)
}

creerTest <- function(list){
  annee = list$annee
  typeElection = list$typeElection
  codeDepartement = list$codeDepartement
  nomDepartement = list$nomDepartement
  communes = list$communes
  connexion <- getDbConnexion()
 
  idDepartement = getIdDepartementByName(connexion, nomDepartement)
 # print(paste(idDepartement, nomDepartement))
  
  idTypeElection = getIdTypeElectionByName(connexion, typeElection)
  # Si le type Elections n'existe pas alors on le cr?e
  if (is.null(idTypeElection)) {
    idTypeElection = creerTypeElection(connexion, nomDepartement)
  }
  
  # Pour ?viter de bombarder la base de requ?te on recupere tous les parties politique d?j? existant
  # et on va regarder si le partie politique existe dans notre dataFrame pour r?cup?rer l'id
  # Afin qu'on puisse respecter notre contrainte de cl? ?trang?re sur la table resultat et candidat
  #dfPartiePolitiqueExistant <- getAllPartiePolitique(connexion)
  aCodeCommunes  = c()

  aResultatVoteNulEtBlanc <- data.frame(matrix(ncol = 6, nrow = 0))
  aResultatCandidat <- data.frame(matrix(ncol = 11, nrow = 0))
  aResultatLabel <-  c("vote","nbVoteBlanc", "nbVoteNuls", "candidatId", "idTypeElection","idCommune")
  aResultatAndCandidatLabel <- c(aResultatLabel,"prenom", "nom", "idPartieCandidat", "nomPartie", "civilite")
  
  colnames(aResultatCandidat) <- aResultatAndCandidatLabel
  colnames(aResultatVoteNulEtBlanc) <- aResultatLabel
  iTailleNulBlancDf <- 0
  
  for(index in 1:length(communes)){
    commune <- communes[[index]]
    idCommune <- commune$CodSubCom
    aCodeCommunes <- c(aCodeCommunes, sprintf("%s",idCommune))
    if (is.null(commune$Tours$Tour$Mentions$Nuls$Nombre) == FALSE) 
    {
      nbVoteNuls <- commune$Tours$Tour$Mentions$Nuls$Nombre 
      nbVoteBlanc <- commune$Tours$Tour$Mentions$Blancs$Nombre 
      numTour <- commune$Tours$Tour$NumTour
      listCandidats <- commune$Tours$Tour$Resultats$Candidats
    }
    else
    {
      nbVoteNuls <- 0
      nbVoteBlanc <- 0 
      numTour <- commune$Tour$NumTour
      listCandidats <- commune$Tour$Resultats$ListesCandidats
    }
    
    aResultatVoteNulEtBlanc[index, ] = c( 0 ,nbVoteBlanc, nbVoteNuls,"NULL",  idTypeElection, idCommune)
    # Parcours des candidats
    for (index3 in 1:length(listCandidats)) {
      candidat <- listCandidats[index3]$Candidat
      nom = candidat$NomPsn
      prenom = candidat$PrenomPsn
      civilite =  candidat$CivilitePsn
      civilite = ifelse(is.null(civilite), "NULL", civilite)
      nbVoixCandidat = candidat$NbVoix
      nomPartie = candidat$LibNua
      
      #aResultatLabel <-  c("vote","nbVoteBlanc", "nbVoteNuls", "candidatId", "idTypeElection","idCommune")
      #aResultatAndCandidatLabel <- c(aResultatLabel,"prenom", "nom", "idPartieCandidat", "nomPartie", "civilite")
      # Les valeurs UNKNOWN sont des valeurs qui vont provenir de la base a ce moment la on ne connait pas encore 
      # Les valeurs qui seront recupérées plus bas par des requetes sql
      aResultatCandidat[nrow(aResultatCandidat) + 1, ] <- c(
        nbVoixCandidat, 0, 0, "UNKNOWN", idTypeElection, idCommune, prenom, nom, "UNKNOWN", nomPartie, civilite)
      
    }
  }
  
  aCodeCommunesFromBase <- getAllBureauVote(connexion,aCodeCommunes, idDepartement)
  '%notin%' <- Negate('%in%')
  aCommunesNonExistantes <- aCodeCommunesFromBase[aCodeCommunesFromBase$idBureauVote %notin% aCodeCommunes,]
  # On insere les communes non existantes
  if(is_empty(aCommunesNonExistantes) == FALSE){
    creerBureauVote(connexion, unique(aCommunesNonExistantes$idBureauVote), idDepartement)
    # Tout simplement s'il n'y a pas de data en base
  }else if(is_empty(aCodeCommunesFromBase)){
    creerBureauVote(connexion, unique(aCodeCommunes), idDepartement)
  }
  
  #(vote, votesBlanc, votesNul, electionId, candidatId, bureauVoteId)
  dbBegin(connexion)
  for(index in 1:nrow(aResultatVoteNulEtBlanc)){
    
    creerResultatElection(
      connexion,
      aResultatVoteNulEtBlanc[index,]$vote,
      aResultatVoteNulEtBlanc[index,]$nbVoteBlanc,
      aResultatVoteNulEtBlanc[index,]$nbVoteNuls,
      aResultatVoteNulEtBlanc[index,]$idTypeElection,
      aResultatVoteNulEtBlanc[index,]$candidatId,
      aResultatVoteNulEtBlanc[index,]$idCommune
    )
  }
  
  aNomParties <- unique(aResultatCandidat$nomPartie);
  aCandidatInfos <- aResultatCandidat[,c("nom","prenom","civilite", "nomPartie")]
  
  aNomPartiesFromDataBase <- getAllPartiePolitique(connexion, aNomParties)
  aCandidatsFromDatabase <- getAllCandidats(connexion, aCandidatInfos[,"nom"], aCandidatInfos[,"prenom"])
  
  aCandidatsNonExistant <- aCandidatsFromDatabase[aCandidatsFromDatabase$nomCandidat %notin% aCandidatInfos$nom && aCandidatsFromDatabase$prenomCandidat %notin% aCandidatInfos$prenom, ]
  
  aNomPartieNonExistant <- aNomPartiesFromDataBase[aNomPartiesFromDataBase$libelleParti %notin% aNomParties]
  aCandidatNonExistant  <- NULL
  if(is_empty(aNomPartieNonExistant) == FALSE){
    print("LOL")
    for(sNomPartie in aNomPartieNonExistant){
      partieId <- creerPartiePolitique(connexion, sNomPartie)
      aNomPartiesFromDataBase[nrow(aNomPartiesFromDataBase) + 1, ] <- c(partieId, sNomPartie)
    }
  }else if(is_empty(aNomParties) == FALSE && is_empty(aNomPartiesFromDataBase)){
    print("Lel")
    for(sNomPartie in aNomParties){
      partieId <- creerPartiePolitique(connexion, sNomPartie)
      aNomPartiesFromDataBase[nrow(aNomPartiesFromDataBase) + 1, ] <- c(partieId, sNomPartie)
    }
  }
 # print(unique(aCandidatInfos))
  if(is_empty(aCandidatsNonExistant) == FALSE){
    print("LLL")
  }
  else if (is_empty(aCandidatsFromDatabase)) {
    print("Miam")
    
    for(index in 1:nrow(unique(aCandidatInfos))){
      nomPartieCandidat <- aCandidatInfos[index,]$nomPartie
      nomCandidat <- aCandidatInfos[index,]$nom
      prenomCandidat <- aCandidatInfos[index,]$prenom
      civiliteCandidat <- aCandidatInfos[index,]$civilite
      iIdPartieCandidat <- aNomPartiesFromDataBase[aNomPartiesFromDataBase$libelleParti %in% nomPartieCandidat,][1,]$idPartiPolitique
      #(firstName, name, sexe, idPartiePolitique){
      creerCandidat(connexion, prenomCandidat, nomCandidat, civiliteCandidat, iIdPartieCandidat  )
      #print(aCandidatInfos[index,])
    }
  }
  
  dbCommit(connexion)
  # Parcours de notre nouvelle liste candidat
  for(index in 1:nrow(aResultatCandidat)){
    oCandidatFromXml <- aResultatCandidat[index,]
    oCandidatFromBase <- aCandidatsFromDatabase[aCandidatsFromDatabase$nomCandidat == oCandidatFromXml$nom && aCandidatsFromDatabase$prenomCandidat == oCandidatFromXml$prenom, ]
    if(is_empty(oCandidatFromBase)){
      cat(oCandidatFromXml$nom, oCandidatFromXml$prenom)
      print("")
    }
  }
 # print(aCandidatsFromDatabase)
 
  dbDisconnect(connexion)
}

# ======================= Bureau Vote ====================================
#'
#'@param conn connexion a la base de donnée
#'@param aId un tableau des id des sous communes de type c()
#'@param dptId l'id du departement auxquels sont rattachés les sous communes
creerBureauVote <- function(conn, aId, dptId){
  #conn <- getDbConnexion()
  aValues = ''
  dbBegin(conn)
  for(id in aId){
    aValues <-  sprintf("('%s',%s)", id, dptId)
    query <- paste("insert into BureauVote VALUES ", aValues)
    dbExecute(conn, query)
  }
  dbCommit(conn)
  #aAllIdFormatInsertSql <- paste(aValues, collapse = ",")
  
  

}
#'@param conn Objet de connexion vers la base 
#'@param allBureauVoteId tableau de donnee c() ou list()
getAllBureauVote <- function(conn, aCodeCommunes, dptId){
  query <- sprintf("SELECT * FROM BureauVote where dptId = %s  and idBureauVote in (%s)", dptId ,paste(aCodeCommunes, collapse = ","))
  rs <- dbSendQuery(conn, query)
  df <- dbFetch(rs) # Retourne un data Frame
  dbClearResult(rs)
  return(df)
}

bureauVoteExiste <- function(conn, id){
 # conn <- getDbConnexion()
  query <- sprintf(
    "SELECT * FROM BureauVote where idBureauVote = %s",
    id
  )
  rs <- dbSendQuery(conn, query)
  df <- dbFetch(rs) # Retourne un data Frame
  existe = FALSE
  
  if (dbGetRowCount(rs) > 0) {
    existe = TRUE
  }
  
  dbClearResult(rs)
 
  return(existe)
}

# ============================ Methode Table Candidat ======================================
# Renvoie null si l'id n'existe pas 
creerCandidat <- function(conn, firstName, name, sexe, idPartiePolitique){
 # conn <- getDbConnexion()

  query <- sprintf(
    "insert into Candidat (nomCandidat, prenomCandidat, sexe, partiPolitiqueId) VALUES ('%s', '%s', '%s', %s)",
    name, firstName, sexe, idPartiePolitique)
  
  dbExecute(conn, query)
  #candidat <- getCandidat(firstName, name, idPartiePolitique)
  return(getLastRowInsertId())
}

getCandidat <- function(conn, prenomCandidat, nomCandidat, idPartiePolitique){
  #conn <- getDbConnexion()
  query <- sprintf(
    "SELECT * FROM Candidat where nomCandidat = '%s' and prenomCandidat = '%s' and partiPolitiqueId = %s",
    nomCandidat, prenomCandidat, idPartiePolitique
  )
  rs <- dbSendQuery(conn, query)
  df <- dbFetch(rs) # Retourne un data Frame
  
  dbClearResult(rs)
  
  return(df)
}
#' @param conn connexion
#' @param nom une liste de nom ou bien juste un nom
#' @param prenom une liste de prenom ou juste le nom
#' @return dataFrame avec les résultats si match
getAllCandidats <- function(conn, nom, prenom){
  aNomsFormatSql <- sprintf("'%s'", nom)
  aPrenomsFormatSql <- sprintf("'%s'", prenom)
  
  sNoms <- paste(aNomsFormatSql, collapse = ",")
  sPrenoms <- paste(aPrenomsFormatSql, collapse = ",")
  
  query <- sprintf("SELECT * FROM Candidat where nomCandidat in(%s) and prenomCandidat in (%s)", sNoms,sPrenoms)
  rs <- dbSendQuery(conn, query)
  df <- dbFetch(rs) # Retourne un data Frame
  dbClearResult(rs)
  
  return(df)
}


# ============================ FIN Methode Table Candidat ======================================

# ============================ Methode Table Partie Politique ======================================
getIdPartiePolitiqueByName <- function(name){
  conn <- getDbConnexion()
  query <- dbSendQuery(conn, "SELECT idPartiPolitique FROM PartiPolitique WHERE libelleParti = ?")
  rs <- dbBind(query, list(name))
  df <- dbFetch(rs)
  idPartie = NULL
  if (dbGetRowCount(rs) > 0) {
    idPartie <- df[1,] # Premiere Ligne
  }
  
  dbClearResult(rs)
  
  return(idPartie)
}

getAllPartiePolitique <- function(conn, nomParties){
  #conn <- getDbConnexion()
  aNomPartiesFormatSql <- sprintf("'%s'", nomParties)
  
  sNoms <- paste(aNomPartiesFormatSql, collapse = ",")
  query <- sprintf("SELECT idPartiPolitique, libelleParti FROM PartiPolitique where libelleParti in(%s)", sNoms )
  rs <- dbSendQuery(conn, query)
  df <- dbFetch(rs) # Retourne un data Frame
  dbClearResult(rs)
  
  return(df)
}

# Renvoie null si l'id n'existe pas 
creerPartiePolitique <- function(conn, name){
  #conn <- getDbConnexion()
  query <- sprintf("insert into PartiPolitique (libelleParti) VALUES ('%s')", name)
  dbExecute(conn, query)
  #idPartieCreer <- getIdPartiePolitiqueByName(name)
  return(getLastRowInsertId())
}

# ============================ Fin Methode Table Partie Politique ======================================

# ============================ Methode Table Departement ======================================

getAllDepartement <- function(){
  conn <- getDbConnexion()
  rs <- dbSendQuery(conn, "SELECT * FROM departement")
  df <- dbFetch(rs)
  dbClearResult(rs) 
  
  return(df)
}

# Renvoie null si l'id n'existe pas 
getIdDepartementByName <- function(conn, name){
  #conn <- getDbConnexion()
  
  query <- dbSendQuery(conn = conn, "SELECT idDpt FROM departement WHERE slug = LOWER(?) ")
  
  rs <- dbBind(query, list( name))
  df <- dbFetch(rs)
  idPartie = NULL
  if (dbGetRowCount(rs) > 0) {
    idPartie <- df[1,] # Premiere Ligne
  }
  
  dbClearResult(rs)
  
  return(idPartie)
}

# ============================ Fin Methode Table Departement ======================================


# ============================ Methode Table Type Election ======================================

creerTypeElection <- function(conn, name){
  #conn <- getDbConnexion()
  dbExecute(conn, sprintf("insert into TypeElection (nomTypeElection) VALUES ('%s')", name))
  #idPartieCreer <- getIdTypeElectionByName(conn,name)
  return(getLastRowInsertId())
}

getLastRowInsertId <- function( ){
  query <- "select last_insert_rowid()"
  rs <- dbSendQuery(getDbConnexion(), query) 
  df <- dbFetch(rs)
  dbClearResult(rs)
  
  return(df)
}
# Renvoie null si l'id n'existe pas 
getIdTypeElectionByName <- function(conn,name){
  #conn <- getDbConnexion()
  query <- dbSendQuery(conn, "SELECT idTypeElection FROM TypeElection WHERE nomTypeElection = ?")
  rs <- dbBind(query, list(name))
  df <- dbFetch(rs)
  idPartie = NULL
  if (dbGetRowCount(rs) > 0) {
    idPartie <- df[1,] # Premiere Ligne
  }
  
  dbClearResult(rs)
  
  return(idPartie)
}

creerResultatPresidentielle <- function(data){
  conn <- getDbConnexion()
  nbCommunes <- length(data$Departement$Communes)
  codeDepartement <- data$Departement$CodDpt
  nomDepartement <- data$Departement$LibDpt
  iAnnee <- data$Scrutin$Annee
  for(j in 1:nbCommunes){
    ville <- data$Departement$Communes[j]$Commune$LibSubCom

    iNombreTours = length(xxx$Departement$Communes[j]$Commune$Tours)
    for(iTourActuel in 1:iNombreTours){
      voteBlanc <- xxx$Departement$Communes[j]$Commune$Tours[iTourActuel]$Tour$Mentions$Blancs
      voteNul <- xxx$Departement$Communes[j]$Commune$Tours[iTourActuel]$Tour$Mentions$Nuls
      election <- "presidentielle"
      iNbCommunes <- length(data$Departement$Communes$Commune$Tours[iTourActuel]$Tour$Resultats$Candidats)
      for( i in 1:iNbCommunes){
        votes <- data$Departement$Communes[j]$Commune$Tours[iTourActuel]$Tour$Resultats$Candidats[i]$Candidat$NbVoix
        candidat <- data$Departement$Communes[j]$Commune$Tours[iTourActuel]$Tour$Resultats$Candidats[i]$Candidat$NomPsn
        dbExecute(conn, sprintf('insert into ResultatV (votes,votesBlanc,votesNul,iNumTour, election, candidat, ville, codeDepartement,nomDepartement) VALUES (%s,%s,%s,%s,%s, "%s","%s","%s","%s","%s")',
                                votes, 0, 0,iTourActuel,iAnnee, election, candidat, ville, codeDepartement, nomDepartement))
      }
    }
 
  }
  
}

# ============================ Fin Methode Table Type Election ======================================

# ============================  Methode Table Election ======================================
creerElection <- function(annee, typeElectionId){
  conn <- getDbConnexion()
  dbExecute(conn, sprintf("insert into Election (annee,typeElectionId) VALUES (%s,%s)", annee, typeElectionId))
  idPartieCreer <- getIdPartiePolitiqueByName(name)
  return(idPartieCreer)
}


# ============================ Fin Methode Table Election ======================================

# ============================  Methode Table Resultat ======================================

creerResultatElection <- function(conn, vote, votesBlanc, votesNul, electionId, candidatId, bureauVoteId){
  #conn <- getDbConnexion()
  query <- sprintf(
    "insert into Resultat (votes, votesBlanc, votesNul, electionId, candidatId, bureauVoteId) VALUES (%s, %s, %s, %s, %s, %s)",
    vote, votesBlanc, votesNul, electionId, candidatId, bureauVoteId
  )
  #print(query)
  dbExecute(conn, query)
  #idPartieCreer <- getIdResultatByElection(vote, votesBlanc, votesNul, electionId, candidatId, bureauVoteId)
 # return(getLastRowInsertId())
}

getIdResultatByElection <- function(vote, votesBlanc, votesNul, electionId, candidatId, bureauVoteId){
  conn <- getDbConnexion()
  query <- sprintf("SELECT idResultat FROM Resultat WHERE votes = %s AND votesBlanc = %s AND  votesNul = %s AND electionId = %s AND candidatId = %s AND bureauVoteId = %s"
                   , vote, votesBlanc, votesNul, electionId, candidatId, bureauVoteId)
  rs <- dbSendQuery(conn, query )
  #rs <- dbBind(query, list(vote, votesBlanc, votesNul, electionId, candidatId, bureauVoteId))
  df <- dbFetch(rs)
  idPartie = NULL
  if (dbGetRowCount(rs) > 0) {
    idPartie <- df[1,] # Premiere Ligne
  }
  
  dbClearResult(rs)
  
  return(idPartie)
}

getAllResultatElection <- function(){
  conn <- getDbConnexion()
  rs <- dbSendQuery(conn, "SELECT * FROM Resultat")
  df <- dbFetch(rs) # Retourne un data Frame
  dbClearResult(rs)
  
  return(df)
}


#' @param typeElection departementale presidentielle
#' @param annee une liste de prenom ou juste le nom
#' @param departement le numero du departement 93 par exemple
#' @param annee 2020 par exemple
#' @param typeStatistique inscrits / abstentions / vote blanc / vote nul
#' @return dataFrame avec les résultats si match
getAllResultatSelectionUtilisateur <- function(typeElection, annee, departement, typeStatistique){
  
  conn <- getDbConnexion()
  rs <- dbSendQuery(conn, sprintf("
                    Select SUM(votes) as total_vote, candidat, gps_lat, gps_lng from ResultatV join Departement on ResultatV.nomDepartement like slug and ResultatV.nomDepartement = '%s' and typeElection = '%s' group by candidat
                    "), departement, typeElection)
  df <- dbFetch(rs) # Retourne un data Frame
  dbClearResult(rs)
  
  return(df)
}

ajouterUrlParser <- function(url){
  conn <- getDbConnexion()
  dbExecute(conn, sprintf("insert into urlParser (url) VALUES ('%s')", url))
}

urlDejaParser <- function(url){
  conn <- getDbConnexion()
  query <- sprintf(
    "SELECT * FROM urlParser where url = '%s'",
    url
  )
  rs <- dbSendQuery(conn, query)
  df <- dbFetch(rs) # Retourne un data Frame
  existe = FALSE
  
  if (dbGetRowCount(rs) > 0) {
    existe = TRUE
  }
  
  dbClearResult(rs)
  
  return(existe)
}


getAllResultatElectionByDepatement <- function(){
  conn <- getDbConnexion()
  rs <- dbSendQuery(conn, "SELECT SUM(votes) as total_vote,candidat, election, nomDepartement,iNumTour as tour from ResultatV group by election, candidat, nomDepartement, iNumTour")
  
  df <- dbFetch(rs) # Retourne un data Frame
  dbClearResult(rs)
  
  return(df)
}

