use proyecto_sangre;

-- ESTA VISTA MUETRA TODOS LOS PACIENTES QUE SON DE LA PROVINIA DE JUJUY. 
-- Esta vista esta compuesta por la union de la tabla "pacientes" y la tabla "provincias". Devuelve solamente los datos de los pacientes pertenecientes a la provincia de Jujuy.
drop view if exists vw_pacientes_jujuy;
CREATE OR REPLACE VIEW vw_pacientes_jujuy AS
    ( SELECT id_paciente, apellido_paciente, nombre_paciente, fecha_nacimiento
      FROM pacientes JOIN provincias ON (pacientes.provincia_paciente= provincias.id_provincia)
      WHERE provincias.nombre_provincia ='Jujuy'
    );

SELECT * FROM vw_pacientes_jujuy;

-- VISTA DE TODAS LAS CAJAS QUE SE ENCUENTRAN EN EL FREEZER 2
-- Esta vista esta compuesta por la tabla "cajas_muestras" y la tabla "freezers". Devuelve solo los datos de las cajas que se encuentran guardadas en el freezer2
drop view if exists vw_cajas_freezer2;
CREATE OR REPLACE VIEW vw_cajas_freezer2 AS 
	(SELECT nombre_caja, cantidad_muestras 
    FROM cajas_muestras C JOIN freezers F ON (C.ubicacion_freezer = F.id_freezer)
    WHERE F.nombre_freezer = 'Freezer2'
    );
    
    SELECT * FROM vw_cajas_freezer2;
    
-- VISTA DE TODAS LA MUESTRAS DEL PACIENTE T553 CON LOS DATOS DEL PACIENTE
-- Cada paciente tiene muestras de sangre en varios tramos del proyecto, puede que no tenga en todos los tramos
-- Esta vista esta conformada por las tablas "muestras_proyecto" y "pacientes". Solo mostrara los registros de muestras de sangre del paciente "T533", unidos a los datos personales del paciente
drop view if exists vw_muestras_T553;
CREATE OR REPLACE VIEW vw_muestras_T553 AS
   (SELECT * FROM muestras_proyecto  MP JOIN pacientes P ON (MP.paciente = P.id_paciente) WHERE P.id_paciente = 'T553');
   
   SELECT * FROM vw_muestras_T553;
   
   -- VISTA DE MUESTRAS DE SANGRE EN CAJA 16
   -- Esta vista esta conformada por las tablas "muestras_proyecto" y "cajas_muestras"
   -- En esta vista se veran los registros de la tabla "muestras_proyeto" cuya ubicacion sea en la caja 16 
  drop view if exists vw_caja16;
  CREATE OR REPLACE VIEW vw_caja16 AS
  (SELECT id_muestra, paciente, protocolo, fecha_extraccion, tramo_proyecto FROM muestras_proyecto MP JOIN cajas_muestras CM ON (MP.ubicacion_caja = CM.id_caja)
  WHERE CM.nombre_caja = 'Caja 16'
  );
   SELECT * FROM vw_caja16;
   
   -- VISTA DE CAJAS CON MENOS DE 50 MUESTRAS
   -- En esta vista se incluye la tabla "cajas_muestras"
   -- Se mostraran los datos de solo aquellas cajas en cuyo interior solo esten guardadas menos de 50 muestras de sangre.
   drop view if exists vw_cajas_50muestras;
    CREATE OR REPLACE VIEW vw_cajas_50muestras AS
		(SELECT nombre_caja, ubicacion_freezer, cantidad_muestras
        FROM cajas_muestras
        WHERE cantidad_muestras < 50
        ORDER BY cantidad_muestras ASC
		);
        
	SELECT * FROM vw_cajas_50muestras;
    
    