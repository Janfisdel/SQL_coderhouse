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
|1| Primera entrega Proyecto Final | Script de creacion de tablas y Diagrama entidad relacion en formato MWB y JPG



## Creado por ✒️
- Jana Daniela Fisdel