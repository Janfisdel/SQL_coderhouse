-- Esta función busca la ubicacion de una muestra de sangre segun su numero de protocolo
-- Indicando el numero de protocolo de la muestra (que es unico) se unen las tablas "muestras_proyecto"  y "cajas_muestras" y devuelve el nombre de la caja donde esta alojada esa muestra
-- Si se ingresa un numero de protocolo no existen se devuelve "MUESTRA NO EXISTENTE"
drop function if exists FN_BUSCAR_MUESTRA;
DELIMITER //
CREATE FUNCTION `fn_buscar_muestra` (prot int)
RETURNS  varchar(100)
DETERMINISTIC
BEGIN
DECLARE respuesta varchar(100);
DECLARE cantDatos int;
SELECT nombre_caja INTO respuesta FROM cajas_muestras as cm
INNER JOIN muestras_proyecto as mp
ON cm.id_caja = mp.ubicacion_caja
WHERE mp.protocolo = prot;
SET cantDatos = (SELECT COUNT(*) FROM muestras_proyecto WHERE protocolo = prot);
If cantDatos >0 THEN
RETURN respuesta;
ELSE
RETURN 'MUESTRA NO EXISTENTE';
END IF;
END
//

SELECT fn_buscar_muestra(53218) AS ubicacion_muestra;

-- Funcion que al ingresar un numero de ID de paciente devuelve su nombre completo
-- Esta funcion trabaja sobre la tabla "pacientes". Al ingresar ID de un paciente lo busca en la tabla y concatena el nombre y apellido de dicho paciente.
-- Si se ingresa un ID que no se encuentra en la tabla devuelve "NO HAY PACIENTES CON ESE ID"
drop function if exists fn_buscar_paciente;

DELIMITER //
CREATE FUNCTION FN_BUSCAR_PACIENTE(id varchar(4))
RETURNS varchar(100)
DETERMINISTIC
BEGIN
	DECLARE nombreyap varchar(100);
    DECLARE cantDatos int;
    SET cantDatos = (SELECT COUNT(*) FROM pacientes WHERE id_paciente = id);
    IF cantDatos >0 THEN
		SELECT CONCAT('Nombre y apellido: ',nombre_paciente,' ' ,apellido_paciente) INTO nombreyap FROM PACIENTES
		WHERE id_paciente = id;
		RETURN nombreyap;
	ELSE 
		RETURN 'NO HAY PACIENTES CON ESE ID';
	END IF;
END
//

SELECT fn_buscar_paciente('T102') AS datos_paciente;

