###############################################################################
#                              POSTWORK 02                                    #
###############################################################################

# Ahora vamos a generar un cúmulo de datos mayor al que se tenía, ésta es una 
# situación habitual que se puede presentar para complementar un análisis, 
# siempre es importante estar revisando las características o tipos de datos que 
# tenemos, por si es necesario realizar alguna transformación en las variables y 
# poder hacer operaciones aritméticas si es el caso. Además de sólo tener 
# presente algunas de las variables, no siempre se requiere el uso de todas para 
# ciertos procesamientos.

# Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 
# de la primera división de la liga española a R, los datos los puedes encontrar 
# en el siguiente enlace: https://www.football-data.co.uk/spainm.php

library(stringr)
library(dplyr)

temporadas<-c('https://raw.githubusercontent.com/gilesitorr/DataScience3_Bloque2/main/Postwork_2/SP1_1718.csv',
              'https://raw.githubusercontent.com/gilesitorr/DataScience3_Bloque2/main/Postwork_2/SP1_1819.csv',
              'https://raw.githubusercontent.com/gilesitorr/DataScience3_Bloque2/main/Postwork_2/SP1_1920.csv')

TemporadasUnidas<-lapply(temporadas, read.csv)

# Revisa la estructura de de los data frames al usar las funciones: str, head, 
# View y summary

summary(TemporadasUnidas)
lapply(TemporadasUnidas,str)
lapply(TemporadasUnidas,head)
lapply(TemporadasUnidas,View)
lapply(TemporadasUnidas,summary)

# Con la función select del paquete dplyr selecciona únicamente las columnas 
# Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data 
# rames. (Hint: también puedes usar lapply).

NewTemUn<-lapply(TemporadasUnidas,function(x){select(x,c('Date',
                      'HomeTeam', 'AwayTeam','FTHG','FTAG','FTR'))})

NewTemUn<-lapply(NewTemUn,function(x){mutate(x,Date=as.Date(Date, "%d/%m/%Y"))})

TemUn<-do.call(rbind,NewTemUn)

TemUn$Date<-as.Date(str_replace(TemUn$Date,'00','20'))

write.csv(TemUn, file='ResultadoPostwork02.csv')

# Asegúrate de que los elementos de las columnas correspondientes de los nuevos 
# data frames sean del mismo tipo (Hint 1: usa as.Date y mutate para arreglar 
# las fechas).Con ayuda de la función rbind forma un único data frame que 
# contenga las seis columnas mencionadas en el punto 3 
# (Hint 2: la función do.call podría ser utilizada).