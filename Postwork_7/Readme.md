# Postwork 7
## (Obtenido del [repositorio usado en la Sesión 7](https://github.com/beduExpert/Programacion-R-Santander-2021/tree/main/Sesion-07/Postwork))

Los objetivos de este postwork son los siguientes:


Utilizando el manejador de BDD _Mongodb Compass_ (previamente instalado), realizar las siguientes acciones: 

1. Alojar el fichero  `match.data.csv` en una base de datos llamada `match_games`. Luego, usando la función `mongo`, se hace la conexión (ya sea a un servidor local o de MongoDB Atlas) nombrando al argumento `collection` como `match`.
2. Una vez hecho esto, realizar un `count` para conocer el número de registros que se tiene en la base. Si el número resultante es cero, se pueden agregar los registros a la colección con el elemento `insert` del objeto conexión.
3. Realizar una consulta utilizando la sintaxis de **Mongodb** en la base de datos, para conocer el número de goles que metió el Real Madrid el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?.
4. Por último, cerrar la conexión con la BDD.
 
__Notas para los datos de soccer:__ https://www.football-data.co.uk/notes.txt
