###############################################################################
#                               POSTWORK 01                                   #
###############################################################################

# Importa los datos de soccer de la temporada 2019/2020 de la primera división 
# de la liga española a R, los datos los puedes encontrar en el siguiente 
# enlace: https://www.football-data.co.uk/spainm.php

## Ubicación del archivo csv

library(dplyr)
Aa<-read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

# Del data frame que resulta de importar los datos a R, extrae las columnas que 
# contienen los números de goles anotados por los equipos que jugaron en casa 
# (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)

GolesLocal<-data.frame(Aa$FTHG)
GolesVisitante<-data.frame(Aa$FTAG)

# Consulta cómo funciona la función table en R al ejecutar en la consola ?table

?table

# Posteriormente elabora tablas de frecuencias relativas para estimar las 
# siguientes probabilidades:

# La probabilidad (marginal) de que el equipo que juega en casa anote x goles 
# (x = 0, 1, 2, ...)

JJG<-sum(table(GolesLocal)) # Juegos jugados
P_Local_G=data.frame(table(GolesLocal)/JJG) 

NM<-c('Goles', 'Probabilidad')
names(P_Local_G)<-NM

print(paste('La probabilidad marginal de que un equipo anote cierto número',
            'de goles de local, se muetra en la tabla siguiente:'))
P_Local_G

# La probabilidad (marginal) de que el equipo que juega como visitante anote y 
# goles (y = 0, 1, 2, ...)

P_Visit_G=data.frame(table(GolesVisitante)/JJG)
names(P_Visit_G)<-NM
print(paste('La probabilidad marginal de que un equipo anote cierto número',
            'de goles de visitante, se muetra en la tabla siguiente:'))
P_Visit_G

# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y 
# el equipo que juega como visitante anote y goles (x = 0, 1, 2, ..., 
# y = 0, 1, 2, ...)

GolesLocalVisit<-data.frame(GolesLocal,GolesVisitante)
names(GolesLocalVisit) <- c("G.Local", "G.Visit")
GolesLocalVisit <- table(GolesLocalVisit)
GolesLocalVisit <- GolesLocalVisit/JJG
print(paste('La probabilidad conjunta de que, tanto el equipo local como el',
            'visitante anoten cierto número de goles, se muetra en la tabla',
            ' siguiente:'))
GolesLocalVisit
