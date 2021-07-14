################################################################################
#                                  POSTWORK 05                                 #
################################################################################

# A partir del conjunto de datos de soccer de la liga española de las 
# temporadas 2017/2018, 2018/2019 y 2019/2020, crea el data frame SmallData, 
# que contenga las columnas date, home.team, home.score, away.team y 
# away.score; esto lo puede hacer con ayuda de la función select del paquete 
# dplyr. Luego establece un directorio de trabajo y con ayuda de la función 
# write.csv guarda el data frame como un archivo csv con nombre soccer.csv. 
# Puedes colocar como argumento row.names = FALSE en write.csv.

library(dplyr)
library(stringr)
library(fbRanks)

Files<-c('https://raw.githubusercontent.com/gilesitorr/DataScience3_Bloque2/main/Postwork_2/SP1_1718.csv',
        'https://raw.githubusercontent.com/gilesitorr/DataScience3_Bloque2/main/Postwork_2/SP1_1819.csv',
        'https://raw.githubusercontent.com/gilesitorr/DataScience3_Bloque2/main/Postwork_2/SP1_1920.csv')
SmallData<-lapply(Files,read.csv)
SmallData<-lapply(SmallData,function(x){select(x,c('Date',
                                      'HomeTeam','FTHG','AwayTeam','FTAG'))})

SmallData<-lapply(SmallData,function(x){
  mutate(x,Date=as.Date(Date, "%d/%m/%Y"))})

SmallData<-do.call(rbind,SmallData)

NM<-c('date', 'home.team', 'home.score', 'away.team','away.score')
names(SmallData)<-NM

write.csv(SmallData,'Soccer.csv', row.names=F)

# Con la función create.fbRanks.dataframes del paquete fbRanks importe el 
# archivo soccer.csv a R y al mismo tiempo asignelo a una variable llamada 
# listasoccer. Se creará una lista con los elementos scores y teams que son 
# data frames listos para la función rank.teams. Asigna estos data frames a 
# variables llamadas anotaciones y equipos.

ListaSoccer<-create.fbRanks.dataframes(scores.file='Soccer.csv', 
                                       date.format= '%Y-%m-%d')
str(ListaSoccer)
Anotaciones<-ListaSoccer$scores
Equipos<-ListaSoccer$teams

# Con ayuda de la función unique crea un vector de fechas (fecha) que no se 
# repitan y que correspondan a las fechas en las que se jugaron partidos. 
# Crea una variable llamada n que contenga el número de fechas diferentes. 
# Posteriormente, con la función rank.teams y usando como argumentos los 
# data frames anotaciones y equipos, crea un ranking de equipos usando 
# únicamente datos desde la fecha inicial y hasta la penúltima fecha en la 
# que se jugaron partidos, estas fechas las deberá especificar en max.date y 
# min.date. Guarda los resultados con el nombre ranking.

Fechas<-as.character(unique(SmallData$date))
Fechas<-sort(as.Date(str_replace(Fechas,'00','20')))
n<-length(Fechas)
Ranking<-rank.teams(scores=Anotaciones, teams = Equipos, 
                    max.date = Fechas[n-1], min.date = Fechas[1])

# Finalmente estima las probabilidades de los eventos, el equipo de casa 
# gana, el equipo visitante gana o el resultado es un empate para los 
# partidos que se jugaron en la última fecha del vector de fechas fecha. 
# Esto lo puedes hacer con ayuda de la función predict y usando como 
# argumentos ranking y fecha[n] que deberá especificar en date.

predict(Ranking,date=Fechas[n])
