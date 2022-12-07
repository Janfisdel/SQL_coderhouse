use proyecto_sangre;

-- VISTA DE TODOS LOS PACIENTES DE LA PROVINCIA DE JUJUY
CREATE OR REPLACE VIEW vw_pacientes_jujuy AS
    ( SELECT id_paciente, apellido_paciente, nombre_paciente, fecha_nacimiento
      FROM pacientes JOIN provincias ON (pacientes.provincia_paciente= provincias.id_provincia)
      WHERE provincias.nombre_provincia ='Jujuy'
    );

SELECT * FROM vw_pacientes_jujuy;

-- VISTA DE TODAS LAS CAJAS QUE SE ENCUENTRAN EN EL FREEZER 2
CREATE OR REPLACE VIEW vw_cajas_freezer2 AS 
	(SELECT nombre_caja, cantidad_muestras 
    FROM cajas_muestras C JOIN freezers F ON (C.ubicacion_freezer = F.id_freezer)
    WHERE F.nombre_freezer = 'Freezer2'
    );
    
    SELECT * FROM vw_cajas_freezer2;
    
-- VISTA DE TODAS LA MUESTRAS DEL PACIENTE T553
CREATE OR REPLACE VIEW vw_muestras_T553 AS
   (SELECT paciente, protocolo, ubicacion_caja, fecha_extraccion
   FROM tramo_s0
   WHERE paciente = 'T553'
   UNION
   SELECT paciente, protocolo, ubicacion_caja, fecha_extraccion
   FROM tramo_s1
   WHERE paciente = 'T553'
   UNION
   SELECT paciente, protocolo, ubicacion_caja, fecha_extraccion
   FROM tramo_s2 
   WHERE paciente = 'T553'
   UNION
   SELECT paciente, protocolo, ubicacion_caja, fecha_extraccion
   FROM tramo_s3 
   WHERE paciente = 'T553'
   );
   
   SELECT * FROM vw_muestras_T553;
   
   -- VISTA DE MUESTRAS EN CAJA 16
   -- EN REALIDAD POR VER LAS TABLAS SE QUE EN QUE TRAMO ESTA ESA CAJA PERO CON UNA UNION BUSCO EN TODOS LOS TRAMOS COMO SI NO SUPIERA EN QUE TRAMO ESTA
   -- EL RESULTADO DE LA VISTA ES EN UN SOLO TRAMO
   
   CREATE OR REPLACE vw_caja16 AS
  (SELECT paciente, protocolo, fecha_extraccion
  FROM tramo_s0 S0 JOIN cajas_muestras CM ON (S0.ubicacion_caja = CM.id_caja)
  WHERE CM.nombre_caja = 'Caja16'
  UNION
  SELECT paciente, protocolo, fecha_extraccion
  FROM tramo_s1 S1 JOIN cajas_muestras CM ON (S1.ubicacion_caja = CM.id_caja)
  WHERE CM.nombre_caja = 'Caja16'
  UNION
  SELECT paciente, protocolo, fecha_extraccion
  FROM tramo_s2 S2 JOIN cajas_muestras CM ON (S2.ubicacion_caja = CM.id_caja)
  WHERE CM.nombre_caja = 'Caja16'
  UNION
  SELECT paciente, protocolo, fecha_extraccion
  FROM tramo_s3 S3 JOIN cajas_muestras CM ON (S3.ubicacion_caja = CM.id_caja)
  WHERE CM.nombre_caja = 'Caja16'
  );
   SELECT * FROM vw_caja16;
   
   -- VISTA DE CAJAS CON MENOS DE 50 MUESTRAS
    CREATE OR REPLACE VIEW vw_cajas_50muestras AS
		(SELECT nombre_caja, ubicacion_freezer, cantidad_muestras
        FROM cajas_muestras
        WHERE cantidad_muestras < 50
        ORDER BY cantidad_muestras ASC
		);
        
	SELECT * FROM vw_cajas_50muestras;
    
    
