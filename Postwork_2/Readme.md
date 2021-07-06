# Postwork 2
## (Obtenido del [repositorio usado en la Sesión 2](https://github.com/beduExpert/Programacion-R-Santander-2021/tree/main/Sesion-02/Postwork))

Los objetivos de este postwork son los siguientes:

1. Importar los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división de la liga española a `R`, los datos se pueden encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php.

2. Revisar la estructura de de los data frames al usar las funciones: `str`, `head`, `View` y `summary`

3. Con la función `select` del paquete `dplyr` seleccionar únicamente las columnas `Date`, `HomeTeam`, `AwayTeam`, `FTHG`, `FTAG` y `FTR`; esto para cada uno de los data frames. (Hint: también se puede usar `lapply`).

4. Asegurarse de que los elementos de las columnas correspondientes de los nuevos data frames sean del mismo tipo (Hint 1: usar `as.Date` y `mutate` para arreglar las fechas). Con ayuda de la función `rbind` formar un único data frame que contenga las seis columnas mencionadas en el punto 3 (Hint 2: la función `do.call` podría ser utilizada).

__Notas para los datos de soccer:__ https://www.football-data.co.uk/notes.txt
