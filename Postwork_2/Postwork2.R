#Se lee la base de datos directos de los enlaces
u1718<- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
u1819<- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
u1920<- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

setwd("C:/Users/giles/Documents/DataScience-BEDU/FASE2/BLOQUE2/SESIÓN2")

download.file(url = u1718, destfile = "SP1-1718.csv", mode = "wb")
download.file(url = u1819, destfile = "SP1-1819.csv", mode = "wb")
download.file(url = u1920, destfile = "SP1-1920.csv", mode = "wb")

df.1718<- read.csv("SP1-1718.csv")
df.1819<- read.csv("SP1-1819.csv")
df.1920<- read.csv("SP1-1920.csv")

#Se consultan las características de las bases de datos
str(df.1718); head(df.1718); View(df.1718); summary(df.1718)
str(df.1819); head(df.1819); View(df.1819); summary(df.1819)
str(df.1920); head(df.1920); View(df.1920); summary(df.1920)

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
summary(df.1720)
View(df.1720)
