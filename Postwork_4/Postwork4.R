################################################################################
#                              POSTWORK 04                                     #
################################################################################

# Ahora investigarás la dependencia o independencia del número de goles anotados 
# por el equipo de casa y el número de goles anotados por el equipo visitante 
# mediante un procedimiento denominado bootstrap, revisa bibliografía en 
# internet para que tengas nociones de este desarrollo.

# Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote 
# X=x goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles 
# (y=0,1,... ,6), en un partido. Obtén una tabla de cocientes al dividir estas 
# probabilidades conjuntas por el producto de las probabilidades marginales 
# correspondientes.

library(dplyr)

# Variables del postwork anterior
Postwork03<-'https://raw.githubusercontent.com/gilesitorr/DataScience3_Bloque2
      /main/Postwork_4/ResultadoPostwork03.csv'
ProbConjunta<-read.csv(Postwork03, header=T)
ProbConjunta$X<-NULL

ProbMargLocal<- ProbConjunta %>% group_by(G.Local) %>% summarise(
  Probabilidad=sum(Probabilidad))

ProbMargVisit<- ProbConjunta %>% group_by(G.Visit) %>% summarise(
  Probabilidad=sum(Probabilidad))

# Matrix de ceros
Cocientes<-matrix(0,nrow=nrow(ProbConjunta),ncol=ncol(ProbConjunta))

# Llenado de la matrix 'Cocientes'
for (i in 1:nrow(ProbConjunta)) {
  VarLocal<-as.numeric(as.character(ProbConjunta[i,1]))
  VarVisit<-as.numeric(as.character(ProbConjunta[i,2]))
  Crit<-(subset(ProbConjunta, G.Local==VarLocal & G.Visit==VarVisit, 
                select = 'Probabilidad'))
  Crit<-Crit/(subset(ProbMargLocal, G.Local==VarLocal, select=Probabilidad))
  Crit<-Crit/(subset(ProbMargVisit, G.Visit==VarVisit, select=Probabilidad))
  Cocientes[i,1]<-VarLocal 
  Cocientes[i,2]<-VarVisit 
  Cocientes[i,3]<-as.numeric(as.character(Crit))
  
}
Cocientes<-data.frame(Cocientes)

# Mediante un procedimiento de boostrap, obtén más cocientes similares a los 
# obtenidos en la tabla del punto anterior. Esto para tener una idea de las 
# distribuciones de la cual vienen los cocientes en la tabla anterior. 
# Menciona en cuáles casos le parece razonable suponer que los cocientes de la 
# tabla en el punto 1, son iguales a 1 (en tal caso tendríamos independencia 
#                                          de las variables aleatorias X y Y).

MediaCocientes<-mean(Cocientes[,ncol(Cocientes)])
SdCocientes<-sd(Cocientes[,ncol(Cocientes)])
Bootsmap<-data.frame(rnorm(nrow(Cocientes), mean=MediaCocientes, sd=SdCocientes))
for (i in 1:100) {
  Compuesto<-rnorm(nrow(Cocientes), mean=MediaCocientes, sd=SdCocientes)
  Bootsmap<-cbind(Bootsmap,Compuesto)
}

Bootsmap<-apply(Bootsmap,2,sort)
MediasBM<-apply(Bootsmap,2,mean)
SDBM<-apply(Bootsmap,1,sd)

z<-(1-Cocientes[,ncol(Cocientes)])/(SDBM/10)
z0.025<- qnorm(p=0.025, lower.tail = FALSE)
Resultz<- (z>-z0.025) & (z<z0.025)

Marcadores<-Cocientes[Resultz,1:3]
names(Marcadores)<-c('G.Local','G.Visit', 'Cociente')

print(paste('Los marcadores para los cuales se puede afirmar independiencia', 
            'entre las variables aleatorias son: '))
print(Marcadores)
