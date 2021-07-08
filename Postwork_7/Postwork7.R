library(mongolite)

#Alojar el fichero match.data.csv en una base de datos llamada match_games,
#nombrando al collection como match
setwd("C:/Users/giles/Documents/DataScience-BEDU/FASE2/BLOQUE2/SESIÓN7")
match_games <- read.csv("match.data.csv")
match_games$date <- as.Date(match_games$date)
str(match_games)

con <- mongo(
        collection = "match",
        url = "mongodb://localhost" #Aquí te conectas a tu servidor,
        #por ejemplo, puedes poner el enlace que pondrías en Compass para conectarte
        #a MongoDB Atlas. También puedes usar un servidor local.
        #Para usar un servidor local, como en mi caso, tienes que descargar
        #MongoDB Community Server. El url es "https://www.mongodb.com/try/download/community"
       )
con$insert(match_games)

#Una vez hecho esto, realizar un count para conocer el número de registros
#que se tiene en la base
con$count()

#Realiza una consulta utilizando la sintaxis de Mongodb en la base de datos,
#para conocer el número de goles que metió el Real Madrid el 20 de diciembre de
#2015 y contra que equipo jugó, ¿perdió ó fue goleada?
con$find(query='{"date": "2015-12-20",
           "$or": [{"home_team": "Real Madrid"}, {"away_team": "Real Madrid"}]}')
##  date       home_team    home_score  away_team    away_score
##1 2015-12-20 Real Madrid  10          Vallecano    2
## Fue goleada

  
#Por último, no olvides cerrar la conexión con la BDD
con$drop()
con$disconnect(gc=TRUE)
