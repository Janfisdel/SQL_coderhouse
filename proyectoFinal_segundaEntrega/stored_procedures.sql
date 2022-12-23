use proyecto_sangre;

-- Funcion para controlar que se ingrese el nombre correcto de los campos que pueden ingresar en el procedimiento
drop function if exists FN_p_mensaje;
DELIMITER //
CREATE FUNCTION FN_p_mensaje (p_mensaje varchar(200))
RETURNS varchar(200)
DETERMINISTIC
BEGIN
    DECLARE v_mensaje varchar(200);
    IF p_mensaje = 'id_paciente' or p_mensaje = 'nombre_paciente' or p_mensaje = 'apellido_paciente' or p_mensaje = 'fecha_nacimiento' or p_mensaje = 'provincia_paciente' THEN
        SET v_mensaje = 'OK';
    ELSE 
        SET v_mensaje ='ERROR';
    END IF;

    RETURN v_mensaje;
END;
//

-- PROCEDIMIENTO PARA ORDENAR LA TABLA DE PACIENTES
-- Este procedimiento trabaja sobre la tabla "pacientes". Permite ordenar la tabla a partir de un campo en especifico y elegir si se quiere que sea ascendente o descentende
-- Si se ingresa un nombre de campo incorrecto o no se agregan los terminos "ASC", "DESC" o un orden vacio en el parametro "P_orden" el procedimiento no devolverá nada
drop procedure if exists SP_ordenar;

DELIMITER //
CREATE PROCEDURE SP_ordenar (INOUT P_campo varchar(50), INOUT P_orden varchar(4), INOUT P_mensaje varchar(200))
BEGIN
    DECLARE v_mensaje varchar(200);
    select FN_p_mensaje(P_campo) into @P_mensaje;
    IF @P_mensaje = 'OK' THEN
				SET @t1 = CONCAT('SELECT * FROM pacientes U ORDER BY ', P_campo, ' ', P_orden);
				PREPARE runSQL FROM @t1;
				EXECUTE runSQL;
				DEALLOCATE PREPARE runSQL;
    ELSE SET v_mensaje = @P_mensaje;
    
    END IF;
END;
//

SET @P_campo ='apellido_paciente';
SET @P_orden ='DESC';

CALL SP_ordenar(@P_campo, @P_orden, @P_mensaje);


-- INSERTAR O ELIMINAR REGISTROS DE TABLA FREEZERS
-- Este procedimiento trabaja sobre la tabla "Freezers". Se debe seleccionar si se quiere insertar o eliminar un registro. 
-- Para eliminar es necesario solo ingresar el valor de ID de un freezer. Para insertar se debe indicar el ID, el nombre y la ubicacion del nuevo freezer
-- Si se indica una tarea que no sea insertar o eliminar el procedimiento no hace ninguna tarea
drop procedure if exists SP_insertar_eliminar_registro;

DELIMITER //
CREATE PROCEDURE SP_insertar_eliminar_registro(IN P_accion varchar(40), IN P_id int, IN P_nombre varchar(10), IN P_ubicacion varchar(60))
BEGIN 
    IF P_accion = UPPER('eliminar') THEN    
        SET @borrar = CONCAT('DELETE FROM freezers WHERE id_freezer = ', P_id);
        PREPARE runSQL  FROM @borrar;
        EXECUTE runSQL;
        DEALLOCATE PREPARE runSQL;
        SELECT * FROM freezers;
    ELSE IF P_accion = UPPER('insertar')THEN
        INSERT INTO freezers  VALUES (P_id, P_nombre, P_ubicacion);
        SELECT * FROM freezers;
        END IF;
    END IF;
END;
//

SET @P_accion = 'insertar';
SET @P_id = 555;
SET @P_nombre = 'F5';
SET @P_ubicacion = 'Laboratorio';

CALL SP_insertar_eliminar_registro(@P_accion, @P_id , @P_nombre, @P_ubicacion);
