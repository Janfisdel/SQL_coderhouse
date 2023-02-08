USE proyecto_chagas;

-- PROCEDIMIENTO PARA ORDENAR LA TABLA DE PACIENTES
DROP PROCEDURE IF EXISTS sp_ordenar;

DELIMITER //
CREATE PROCEDURE sp_ordenar (INOUT P_campo VARCHAR(50), INOUT P_orden VARCHAR(4), INOUT P_mensaje VARCHAR(200))
BEGIN
    DECLARE v_mensaje VARCHAR(200);
    SELECT fn_p_mensaje(P_campo) INTO @P_mensaje;
    IF @P_mensaje = 'OK' THEN
        SET @t1 = CONCAT('SELECT * FROM pacientes U ORDER BY ', P_campo, ' ', P_orden);
        PREPARE runSQL FROM @t1;
        EXECUTE runSQL;
        DEALLOCATE PREPARE runSQL;
    ELSE SET v_mensaje = @P_mensaje;
    END IF;
END;
//

-- Ejemplo para ver funcionamiento del procedimiento anterior
SET @P_campo ='apellido_paciente';
SET @P_orden ='DESC';

CALL sp_ordenar(@P_campo, @P_orden, @P_mensaje);

-- INSERTAR O ELIMINAR REGISTROS DE TABLA FREEZERS
DROP PROCEDURE IF EXISTS sp_insertar_eliminar_registro;

DELIMITER //
CREATE PROCEDURE SP_insertar_eliminar_registro(IN P_accion VARCHAR(40), IN P_id INT, IN P_nombre VARCHAR(10), IN P_ubicacion VARCHAR(60))
BEGIN 
    IF UPPER(P_accion) = 'ELIMINAR' THEN    
        SET @borrar = CONCAT('DELETE FROM freezers WHERE id_freezer = ', P_id);
        PREPARE runSQL  FROM @borrar;
        EXECUTE runSQL;
        DEALLOCATE PREPARE runSQL;
    ELSE IF UPPER(P_accion) = 'INSERTAR' THEN
        INSERT INTO freezers(nombre_freezer, ubicacion_edificio)  VALUES (P_nombre, P_ubicacion);
        END IF;
    END IF;
END;
//

-- Ejemplo para ver funcionamiento del procedimiento anterior
SET @P_accion = 'insertar';
SET @P_id = 6;
SET @P_nombre = 'Freezer6';
SET @P_ubicacion = 'Laboratorio';

CALL sp_insertar_eliminar_registro(@P_accion, @P_id , @P_nombre, @P_ubicacion);

-- procedimiento para ver todos las muestras de un mismo paciente a partir de su numero de proyecto
DROP PROCEDURE IF EXISTS sp_muestras_paciente;

DELIMITER //
CREATE PROCEDURE SP_muestras_paciente (IN P_paciente CHAR(4))
BEGIN 
	SELECT id_muestra, protocolo, ubicacion_caja, fecha_extraccion, tramo, HAI, IFI, ADN, apellido_paciente, nombre_paciente 
    FROM muestras_proyecto MP JOIN pacientes P ON (MP.paciente = P.id_paciente) 
    WHERE P.nro_proyecto =  P_paciente;
END;

-- Ejemplo para ver funcionamiento del procedimiento anterior
SET @P_paciente = 'T532';
CALL sp_muestras_paciente(@P_paciente);
  