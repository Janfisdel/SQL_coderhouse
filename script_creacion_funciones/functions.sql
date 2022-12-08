use proyecto_sangre;

-- Funcion que al ingresar el numero de protocolo indica en que caja esta guardada
drop function if exists FN_BUSCAR_MUESTRA;

DELIMITER //
CREATE FUNCTION `fn_buscar_muestra` (prot int)
RETURNS  varchar(100)
DETERMINISTIC
BEGIN
DECLARE ubicacion int;
DECLARE caja varchar(10);
DECLARE respuesta varchar(100);
DECLARE sinDatos varchar(100);
SELECT ubicacion_caja INTO ubicacion FROM tramo_S0
WHERE protocolo = prot;
SELECT nombre_caja INTO respuesta FROM cajas_muestras
WHERE id_caja = ubicacion;
IF respuesta != null THEN
	RETURN respuesta;
   ELSE 
	SELECT ubicacion_caja INTO ubicacion FROM tramo_S1
	WHERE protocolo = prot;
	SELECT nombre_caja INTO respuesta FROM cajas_muestras
	WHERE id_caja = ubicacion;
    IF respuesta != null THEN
		RETURN respuesta;
	ELSE 
		SELECT ubicacion_caja INTO ubicacion FROM tramo_S2
		WHERE protocolo = prot;
		SELECT nombre_caja INTO respuesta FROM cajas_muestras
		WHERE id_caja = ubicacion;
        IF respuesta != null THEN
			RETURN respuesta;
		ELSE 
			SELECT ubicacion_caja INTO ubicacion FROM tramo_S3
			WHERE protocolo = prot;
			SELECT nombre_caja INTO respuesta FROM cajas_muestras
			WHERE id_caja = ubicacion;
			RETURN respuesta;
            /*ESTA Es LA PARTE QUE SI PONGO LA FUNCION ME DA ERROR PORQUE SOLO ME LEE ESTA PARTE COMO SI NO HUBIERA ENCONTRADO DATOS
            EL RETURN DE LA LINEA 40 NO IRIA
				IF respuesta != null
					RETURN respuesta;
				ELSE 
					SET respuesta = 'La muestra no pertenece al proyecto';
                    RETURN respuesta;
				END IF;
            */
		END IF;
	END IF;
END IF;
END //

SELECT fn_buscar_muestra(100216) AS ubicacion_muestra;

-- Funcion que al ingresar un numero de ID de paciente devuelve su nombre completo

drop function if exists fn_buscar_paciente;

DELIMITER //
CREATE FUNCTION FN_BUSCAR_PACIENTE(id varchar(4))
RETURNS varchar(200)
DETERMINISTIC
BEGIN
	DECLARE nombre varchar(50);
    DECLARE apellido varchar(50);
	DECLARE respuesta varchar(200);
    DECLARE sinDatos varchar(200);
    SELECT nombre_paciente INTO nombre FROM PACIENTES
    WHERE id_paciente = id;
    SELECT apellido_paciente INTO apellido FROM PACIENTES
    WHERE id_paciente = id;
    
    SET respuesta = CONCAT('Nombre y apellido: ', nombre, ' ',  apellido);
	RETURN respuesta;
	
END
//

SELECT fn_buscar_paciente('T018');