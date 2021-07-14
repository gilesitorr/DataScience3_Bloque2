################################################################################
#                                 POSTWORK 06                                  #
################################################################################

# Importa el conjunto de datos match.data.csv a R y realiza lo siguiente:

library(dplyr)

df <- read.csv("https://raw.githubusercontent.com/gilesitorr/DataScience3_Bloque2/main/Postwork_6/match.data.csv", header=T)
df$date <- as.Date(df$date, format="%Y-%m-%d")

df<-mutate(df,Year.month=format(date,'%Y/%m')) 

# Agrega una nueva columna sumagoles que contenga la suma de goles por partido.

df <- mutate(df, sumagoles=home.score+away.score)

# Obtén el promedio por mes de la suma de goles.

Promedio<- df %>% group_by(Year.month) %>% summarise(gols.month=mean(sumagoles),
                      Games.month=n())

# Crea la serie de tiempo del promedio por mes de la suma de goles hasta 
# diciembre de 2019.

PromedioHastaDic2019<-ts(subset(Promedio, Year.month<='2019/12', 
                             select='gols.month'))

# Grafica la serie de tiempo.
plot(PromedioHastaDic2019, xlab = "Fechas jugadas", 
     ylab = "Goles promedio", 
     main = "Serie tiempo: promedio de goles por mes",
     sub = "Serie mensual: de Agosto de 2010 hasta Diciembre de 2019")
