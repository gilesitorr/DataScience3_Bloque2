#Importa el conjunto de datos match.data.csv a R y realiza lo siguiente:

library(dplyr)
library(DescTools)

setwd("C:/Users/giles/Documents/DataScience-BEDU/FASE2/BLOQUE2/SESIÓN6")
df <- read.csv("match.data.csv")
df$date <- as.Date(df$date, format="%Y-%m-%d")

# Agrega una nueva columna sumagoles que contenga la suma de goles por partido.
df <- mutate(df, sumagoles=home.score+away.score)

#Obtén el promedio por mes de la suma de goles.
serie <- aggregate(sumagoles~ Month(date)+Year(date), df, mean)
serie <- rename(serie, mes=`Month(date)`,
                año=`Year(date)`)

for (i in 1:length(serie$mes)){
  if (as.numeric(serie$mes[i])<10){
    serie$mes[i] <- paste0("0",serie$mes[i])
  }
  else{
    serie$mes[i] <- as.character(serie$mes[i])
  }
}

serie <- mutate(serie, año=as.character(año))

serie <- mutate(serie, date=as.Date(paste0(año,"-",mes,"-15"), format="%Y-%m-%d"))
serie <- select(serie, date, sumagoles)

# Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.
serie.t <- ts(serie[1:96,2])
serie.t

#Grafica la serie de tiempo.
plot(serie.t, xlab = "Meses con juegos", ylab = "Suma de goles promedio", main = "Serie de Goles Totales",
     sub = "Serie mensual: Agosto de 2010 a Diciembre de 2019")
