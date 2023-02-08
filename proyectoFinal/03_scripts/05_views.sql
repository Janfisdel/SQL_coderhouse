USE proyecto_chagas;

-- Vista de pacientes de la provincia de Jujuy
DROP VIEW IF EXISTS vw_pacientes_jujuy;
CREATE OR REPLACE VIEW vw_pacientes_jujuy AS
    (SELECT nro_proyecto, apellido_paciente, nombre_paciente, fecha_nacimiento
    FROM pacientes pa JOIN provincias pr ON (pa.provincia_paciente = pr.id_provincia)
    WHERE pr.nombre_provincia = 'JUJUY'
    ORDER BY apellido_paciente ASC
    );

SELECT * FROM vw_pacientes_jujuy;

-- Vista de todos los pacientes que reciben medicacion
DROP VIEW IF EXISTS vw_pacientes_medicacion;
CREATE OR REPLACE VIEW vw_pacientes_medicacion AS
	(SELECT id_paciente, nro_proyecto, apellido_paciente, nombre_paciente, nombre_provincia
		FROM pacientes pa JOIN provincias pr ON (pa.provincia_paciente = pr.id_provincia)
        WHERE pa.medicacion = 'si'
        ORDER BY id_paciente ASC
        );

SELECT * FROM vw_pacientes_medicacion;

-- Vista de todas las muestras guardadas en caja 16
DROP VIEW IF EXISTS vw_caja16;
CREATE OR REPLACE VIEW vw_caja16 AS
    (SELECT id_muestra, paciente, protocolo, fecha_extraccion, tramo 
     FROM muestras_proyecto MP
     JOIN cajas_muestras CM ON (MP.ubicacion_caja = CM.id_caja)   
     WHERE CM.nombre_caja ='Caja16' 
    );

SELECT * FROM vw_caja16;

-- Vista de todas las cajas con menos de 50 muestras guardadas
DROP VIEW IF EXISTS vw_cajas_50muestras;
CREATE OR REPLACE VIEW vw_cajas_50muestras AS
    (SELECT nombre_caja, ubicacion_freezer, cantidad_muestras
     FROM cajas_muestras 
     WHERE cantidad_muestras < 50
     ORDER BY cantidad_muestras ASC
    );

SELECT * FROM vw_cajas_50muestras;

-- vista solo devuelve las muestras positivas 
DROP VIEW IF EXISTS vw_muestras_positivas;
CREATE OR REPLACE VIEW vw_muestras_positivas AS
    (SELECT id_muestra, protocolo, ubicacion_caja, tramo, nombre_paciente, apellido_paciente
    FROM muestras_proyecto mp JOIN pacientes p ON (mp.paciente = p.id_paciente)
    WHERE (HAI ="P" AND IFI ="P") OR (HAI ="P" AND ADN ="P") OR (IFI= "P" AND ADN ="P")
    );

SELECT * FROM vw_muestras_positivas;

-- vista solo devuelve las muestras negativas 
DROP VIEW IF EXISTS vw_muestras_negativas;
CREATE OR REPLACE VIEW vw_muestras_negativas AS
    (SELECT id_muestra, protocolo, ubicacion_caja, tramo, nombre_paciente, apellido_paciente
    FROM muestras_proyecto mp JOIN pacientes p ON (mp.paciente = p.id_paciente)
    WHERE (HAI ="N" AND IFI ="N") OR (HAI ="N" AND ADN ="N") OR (IFI= "N" AND ADN ="N")
    );

SELECT * FROM vw_muestras_negativas;



