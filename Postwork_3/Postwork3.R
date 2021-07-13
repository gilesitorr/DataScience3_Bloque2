###############################################################################
#                              POSTWORK 03                                    #
###############################################################################

# Ahora graficaremos probabilidades (estimadas) marginales y conjuntas para el 
# número de goles que anotan en un partido el equipo de casa o el equipo 
# visitante.

# Con el último data frame obtenido en el postwork de la sesión 2, elabora 
# tablas de frecuencias relativas para estimar las siguientes probabilidades:

# La probabilidad (marginal) de que el equipo que juega en casa anote x 
# goles (x=0,1,2,)

library(ggplot2)
Postwork02='https://raw.githubusercontent.com/gilesitorr/DataScience3_Bloque2/main/Postwork_3/ResultadoPostwork02.csv'
TemUn<-read.csv(Postwork02, header=T)

ProbMargLocal<-data.frame(table(data.frame(TemUn$FTHG))/(nrow(TemUn)))
names(ProbMargLocal)<-c('G.Local','Probabilidad')

print(paste('La probabilidad marginal de que el equipo que juega como',
            'local anote cierta cantidad de goles, se muestra en:'))
ProbMargLocal

# La probabilidad (marginal) de que el equipo que juega como visitante anote 
# 'y' goles (y=0,1,2,)

ProbMargVisit<-data.frame(table(data.frame(TemUn$FTAG))/(nrow(TemUn)))
names(ProbMargVisit)<-c('G.Visit','Probabilidad')

print(paste('La probabilidad marginal de que el equipo que juega como',
            'visitante anote cierta cantidad de goles, se muestra en:'))
ProbMargVisit

# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y 
# el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)

Local<-TemUn$FTHG; Visitante<-TemUn$FTAG

ProbConjunta<-table(data.frame(Local,Visitante))/nrow(TemUn)

print(paste('La probabilidad conjunta de que un partido concluya con cierto',
            'marcador, se muestra en la tabla siguiente:'))

ProbConjunta

ProbConjunta<-data.frame(ProbConjunta)
names(ProbConjunta)<-c('G.Local', 'G.Visit', 'Probabilidad')

write.csv(ProbConjunta,file='ResultadoPostwork03.csv')

# Realiza lo siguiente:

# Un gráfico de barras para las probabilidades marginales estimadas del número 
# de goles que anota el equipo de casa.

ggplot(ProbMargLocal, aes(x = G.Local, y = Probabilidad)) +
  geom_bar(stat="identity", col="black", fill="Pale green") +
  ggtitle("Probabilidad de que el local haga goles") +
  ylab("Probabilidad") +
  xlab("Goles") +
  theme_light()

# Un gráfico de barras para las probabilidades marginales estimadas del número 
# de goles que anota el equipo visitante.

ggplot(ProbMargVisit, aes(x = G.Visit, y = Probabilidad)) +
  geom_bar(stat="identity", col="black", fill="Pale green") +
  ggtitle("Probabilidad de que el visitante haga goles") +
  ylab("Probabilidad") +
  xlab("Goles") +
  theme_light()

# Un HeatMap para las probabilidades conjuntas estimadas de los números de goles 
# que anotan el equipo de casa y el equipo visitante en un partido.

ggplot(ProbConjunta, aes(x = G.Local, y = G.Visit, fill = Probabilidad)) +
  geom_tile() +
  ggtitle("Probabilidad conjunta de los goles") +
  labs(x="Goles del local",y="Goles del visitante",fill='Probabilidad') +
  theme_light()
