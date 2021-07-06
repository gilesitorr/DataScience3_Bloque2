# Postwork 5
## (Obtenido del [repositorio usado en la Sesión 5](https://github.com/beduExpert/Programacion-R-Santander-2021/tree/main/Sesion-05/Postwork))

Los objetivos de este postwork son los siguientes:

1. A partir del conjunto de datos de soccer de la liga española de las temporadas 2017/2018, 2018/2019 y 2019/2020, crear el data frame `SmallData`, que contenga las columnas `date`, `home.team`, `home.score`, `away.team` y `away.score`; esto se puede hacer con ayuda de la función `select` del paquete `dplyr`. Luego establecer un directorio de trabajo y con ayuda de la función `write.csv` guardar el data frame como un archivo csv con nombre *soccer.csv*. Se puede colocar como argumento `row.names = FALSE` en `write.csv`. 

2. Con la función `create.fbRanks.dataframes` del paquete `fbRanks` importar el archivo *soccer.csv* a `R` y al mismo tiempo asignarlo a una variable llamada `listasoccer`. Se creará una lista con los elementos `scores` y `teams` que son data frames listos para la función `rank.teams`. Asignar estos data frames a variables llamadas `anotaciones` y `equipos`.

3. Con ayuda de la función `unique`, crear un vector de fechas (`fecha`) que no se repitan y que correspondan a las fechas en las que se jugaron partidos. Crear una variable llamada `n` que contenga el número de fechas diferentes. Posteriormente, con la función `rank.teams` y usando como argumentos los data frames `anotaciones` y `equipos`, crear un ranking de equipos usando únicamente datos desde la fecha inicial y hasta la penúltima fecha en la que se jugaron partidos, estas fechas se deberán especificar en `max.date` y `min.date`. Guardar los resultados con el nombre `ranking`.

4. Finalmente estimar las probabilidades de los eventos, el equipo de casa gana, el equipo visitante gana o el resultado es un empate para los partidos que se jugaron en la última fecha del vector de fechas `fecha`. Esto se puede hacer con ayuda de la función `predict` y usando como argumentos `ranking` y `fecha[n]` que deberán especificarse en `date`.

__Notas para los datos de soccer:__ https://www.football-data.co.uk/notes.txt
