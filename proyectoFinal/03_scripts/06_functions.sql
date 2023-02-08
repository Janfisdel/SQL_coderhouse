USE proyecto_chagas;

-- Función que al ingresar un numero de protocolo indica en que caja esta guardada una muestra
DROP FUNCTION IF EXISTS fn_buscar_muestra;

DELIMITER //
CREATE FUNCTION `fn_buscar_muestra` (prot INT)
RETURNS  VARCHAR(100)
DETERMINISTIC
BEGIN
DECLARE respuesta VARCHAR(100);
DECLARE cantDatos INT;
SELECT nombre_caja INTO respuesta FROM cajas_muestras AS cm
INNER JOIN muestras_proyecto AS mp
ON cm.id_caja = mp.ubicacion_caja
WHERE mp.protocolo = prot;
SET cantDatos = (SELECT COUNT(*) FROM muestras_proyecto WHERE protocolo = prot);
IF cantDatos >0 THEN
RETURN respuesta;
ELSE
RETURN 'MUESTRA NO EXISTENTE';
END IF;
END
//

-- Ejemplo para ver funcionamiento de la funcion anterior
SELECT fn_buscar_muestra(53218) AS ubicacion_muestra;

-- Funcion que al ingresar un numero proyecto de paciente devuelve su nombre completo
DROP FUNCTION IF EXISTS fn_buscar_paciente;

DELIMITER //
CREATE FUNCTION fn_buscar_paciente(nro VARCHAR(4))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
	DECLARE nombreyap VARCHAR(100);
    DECLARE cantDatos INT;
    SET cantDatos = (SELECT COUNT(*) FROM pacientes WHERE nro_proyecto = nro);
    IF cantDatos >0 THEN
		SELECT CONCAT('Nombre y apellido: ',nombre_paciente,' ' ,apellido_paciente) INTO nombreyap FROM PACIENTES
		WHERE nro_proyecto = nro;
		RETURN nombreyap;
	ELSE 
		RETURN 'NO HAY PACIENTES CON ESE ID';
	END IF;
END
//

-- Ejemplo para ver funcionamiento de la funcion anterior
SELECT fn_buscar_paciente('T101') AS datos_paciente;

-- Funcion que al ingresar el numero de protocolo de una muestra analiza los resultados de las tres pruebas realizadas
-- Si al menos dos de las pruebas son positivas se indica que el paciente es positivo para la enfermedad de chagas. 
-- Si solo una prueba o ninguna da positiva el resultado es negativo y el paciente no tiene la enfermdedad.
DROP FUNCTION IF EXISTS fn_resultados;

DELIMITER //
CREATE FUNCTION fn_resultados(prot int)
RETURNS varchar(100)
DETERMINISTIC	
BEGIN
    DECLARE cantPositivos  INT;
	DECLARE existeMuestra  INT;
	DECLARE resultadoHAI  CHAR(1);
	DECLARE resultadoIFI CHAR(1);
	DECLARE resultadoADN CHAR(1);
	DECLARE HAIPositivo INT;
	DECLARE IFIPositivo INT;
	DECLARE ADNPositivo INT;
	DECLARE resultado VARCHAR(100);
	SET existeMuestra = (SELECT COUNT(*) FROM muestras_proyecto WHERE protocolo = prot );
	IF existeMuestra = 1 THEN
		SELECT HAI INTO resultadoHAI FROM muestras_proyecto WHERE protocolo = prot ;
		SELECT IFI INTO resultadoIFI FROM muestras_proyecto WHERE protocolo = prot;
		SELECT ADN INTO resultadoADN FROM muestras_proyecto WHERE protocolo = prot;
		if UPPER(resultadoHAI) = "P" THEN
			SET HAIPositivo = 1;
			ELSE	
			SET HAIPositivo = 0;
		END IF;
		if UPPER(resultadoIFI) = "P" THEN
			SET IFIPositivo = 1;
			ELSE 
			SET IFIPositivo =0;
		END IF;
		IF UPPER(resultadoADN) = "P" THEN	
			SET ADNPositivo =1;
			ELSE 
			SET ADNPositivo = 0;
			END IF;
		IF HAIPositivo + IFIPositivo + ADNPositivo >1 THEN
			SET resultado = CONCAT('La muestra n°', prot, ' es POSITIVA para la enfermedad de Chagas');
			RETURN resultado; 
		ELSE 
			SET resultado = CONCAT('La muestra n°', prot, ' es NEGATIVA para la enfermedad de Chagas');
			RETURN resultado;
		END IF;
	ELSE 
		RETURN 'MUESTRA NO EXISTENTE';
	END IF;
END;
//

-- Ejemplo para ver funcionamiento de la funcion anterior
SELECT fn_resultados(48546) AS resultado_chagas;

-- función que permite que el Stored Procedure "SP_ordenar" funcione solamente si se ingrea el nombre de un campo ya existente en la tabla "pacientes"
DROP FUNCTION IF EXISTS FN_p_mensaje;

DELIMITER //
CREATE FUNCTION fn_p_mensaje (p_mensaje VARCHAR(200))
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
    DECLARE v_mensaje VARCHAR(200);
    IF p_mensaje = 'id_paciente' OR p_mensaje = 'nombre_paciente' OR p_mensaje = 'apellido_paciente' OR p_mensaje = 'fecha_nacimiento' OR p_mensaje = 'provincia_paciente' THEN
        SET v_mensaje = 'OK';
    ELSE 
        SET v_mensaje ='ERROR';
    END IF;

    RETURN v_mensaje;
END;
//