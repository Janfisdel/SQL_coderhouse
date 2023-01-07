# CURSO SQL - CODER HOUSE

## Comisión 34970

### Situación real
- En mi trabajo contamos de forma física con distintos freezers con muestras de sangre desde hace más de 20 años de un estudio en particular.
- Cada paciente tiene un número identificatorio único.
- Cada tramo del estudio se divide en varias secciones.
- cada tramo cada paciente (o la mayoría de ellos) tiene una o dos muestras.
- Dentro de cada freezer las muestras están guardadas en cajas. Cada caja tiene algún tramo del estudio, pero cada tramo lo conforman varias cajas poque no entran en una sola. También se les puso número a las cajas en el orden de las muestras que tiene dentro.
- Las cajas de un mismo tramo no están guardadas juntas ni en orden, ni siquiera en el mismo freezer.

### Proyecto Base de datos SQL de muestras de sangre
- Mi idea para el proyecto es digitalizar la información de las muestras de sangre.
- Dentro de cada tramo del estudio se repiten los pacientes, por lo que estos se pueden separar en una tabla de pacientes únicos.
- Cada caja tiene una sección del tramo. Varias cajas son parte de un mismo tramo.
- También se repiten los freezers donde están guardadas las muestras, ya que un solo freezer guarda muchas cajas con muchas muestras dentro.
- Con mi proyecto busco que al necesitar encontrar una muestra física, dentro de las miles que tenemos, podamos encontrar rápidamente donde está localizada.

### _Contenido del repositorio_
| # | Clase | Contenido de la entrega | 
| -------- | ---------| ---------|
|1| Primera entrega Proyecto Final | Script de creación de tablas y Diagrama entidad relación en formato MWB y JPG
|2| Inserción con importación | Script de creación de tablas, script de inserción en tabla "freezer" y "cajas_muestras" y archivos .csv para inserción en "cajas_muestras" y el resto de las tablas
|3| Creación de vistas | Script de creación de tablas, script de inserción a tablas, archivos de inserción .csv, script de 5 vistas
|4| Creación de funciones | Script de creación de tablas, script de inserción a tablas, archivos de insercion .csv, script de 2 funciones
|5|  Creación stored procedures | Script de creacion de tablas, script de insercion a tablas freezer, archivos de inserción .csv, script de creacion de 2 stored procedures
|6| Creación de triggers | Script de creacion de tablas, script de insercion a tablas, archivos de insercion .csv, script de creacion de 4 triggers
|7 | Segunda entrega proyecto final | Script de creación de tablas, Script de inserción en tablas 'Freezzers' y 'cajas_muestras', carpeta con archivos .CSV para inserción por importación, PDF indicando como importar registros, script de creación de vistas, script de creación de funciones, script de creación de stored procedures
|8| Implementación de sentencias | Script de creación de tablas, script de inserción en tablas 'Freezers' y 'cajas_muestras', carpeta con archivos .CSV par inserción por importacion, script de creación de 2 usuarios y sus permisos
|9 | Sentencias del sublenguaje TCL | Script de creación de tablas, script de inserción en tablas 'Freezers' y 'cajas_muestras', carpeta con archivos .CSV para inserción por importación, script con sentencias TCL


## Creado por ✒️
- Jana Daniela Fisdel