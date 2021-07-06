######################################################
# Vamos a ejecutar de golpe el script del Postwork 2 #
######################################################

#Se lee la base de datos directos de los enlaces
u1718<- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
u1819<- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
u1920<- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

setwd("C:/Users/giles/Documents/DataScience-BEDU/FASE2/BLOQUE2/SESIÓN3")

download.file(url = u1718, destfile = "SP1-1718.csv", mode = "wb")
download.file(url = u1819, destfile = "SP1-1819.csv", mode = "wb")
download.file(url = u1920, destfile = "SP1-1920.csv", mode = "wb")

df.1718<- read.csv("SP1-1718.csv")
df.1819<- read.csv("SP1-1819.csv")
df.1920<- read.csv("SP1-1920.csv")

#Se usa <select> de <dplyr> para seleccionar sólo algunas columnas
library(dplyr)
df.1718 <- select(df.1718, Date:FTR)
df.1819 <- select(df.1819, Date:FTR)
df.1920 <- select(df.1920, Date, HomeTeam:FTR)

#Arreglamos los formatos de las fechas para tener uno unificado dd-mm-YYYY
library(stringr)
df.1718 <- mutate(df.1718, Date=as.Date(Date,"%d/%m/%Y"))
df.1718$Date <- format(df.1718$Date, "%d/%m/%Y")
df.1718$Date<- str_replace(df.1718$Date, "00", "20")

df.1718 <- mutate(df.1718, Date=as.Date(Date,"%d/%m/%Y"))
df.1819 <- mutate(df.1819, Date=as.Date(Date,"%d/%m/%Y"))
df.1920 <- mutate(df.1920, Date=as.Date(Date,"%d/%m/%Y"))

#Se forma un único dataframe con datos desde 2017 hasta 2020
df.1720 <- rbind(df.1718, df.1819, df.1920)

######################################
# Aquí empezamos lo de este Postwork #
######################################

str(df.1720) #La dataframe con la que empezaremos

#Separamos las columnas con los datos sobre los goles
df.goals<- subset(df.1720, select=c("FTHG", "FTAG"))
str(df.goals)


##############################
# Se reutiliza el Postwork 1 #
##############################

###################################################################
GolesLocal<-data.frame(df.goals$FTHG)
GolesVisitante<-data.frame(df.goals$FTAG)

JJG<-sum(table(GolesLocal)) # En general
P_Local_G=data.frame(table(GolesLocal)/JJG) # En general

NM<-c('Goles', 'Probabilidad')
names(P_Local_G)<-NM
P_Local_G

P_Visit_G=data.frame(table(GolesVisitante)/JJG) # En General
names(P_Visit_G)<-NM
P_Visit_G

GolesLocalVisit<-df.goals
names(GolesLocalVisit) <- c("G.Local", "G.Visit")
GolesLocalVisit <- table(GolesLocalVisit)
GolesLocalVisit <- GolesLocalVisit/JJG
GolesLocalVisit

###################################################################


#A continuación, se graficará
library(ggplot2)
df.Paway<- data.frame(goles=0:(length(P_visit_G)-1), probabilidad=P_visit_G); str(df.Paway) #Visitante
df.Phome<- data.frame(goles=0:(length(P_Local_G)-1), probabilidad=P_Local_G); str(df.Phome) #Local
df.Pconj<- as.data.frame(GolesLocalVisit); str(df.Pconj) #Conjunta

#Gráfica de barras para las probabilidades marginales del equipo visitante
ggplot(df.Paway, aes(x = goles, y = probabilidad)) +
  geom_bar(stat="identity", col="black", fill="Pale green") +
  ggtitle("Probabilidad de que el visitante haga goles") +
  ylab("Probabilidad") +
  xlab("Goles hechos") +
  theme_light()

#Gráfica de barras para las probabilidades marginales del local
ggplot(df.Phome, aes(x = goles, y = probabilidad)) +
  geom_bar(stat="identity", col="black", fill="Pale green") +
  ggtitle("Probabilidad de que el local haga goles") +
  ylab("Probabilidad") +
  xlab("Goles hechos") +
  theme_light()

#HeatMap para las probabilidades conjuntas
ggplot(df.Pconj, aes(x = FTHG, y = FTAG, fill = Freq)) +
  geom_tile() +
  ggtitle("Probabilidad conjunta de los goles") +
  labs(x="Goles del local",y="Goles del visitante",fill='Probabilidad') +
  theme_light()
