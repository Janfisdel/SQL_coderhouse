use proyecto_sangre;

-- PROCEDIMIENTO PARA ORDENAR LA TABLA DE PACIENTES
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
SET @P_orden ='ASC';

CALL SP_ordenar(@P_campo, @P_orden, @P_mensaje);


-- INSERTAR O ELIMINAR REGISTROS DE TABLA FREEZERS
drop procedure if exists SP_insertar_eliminar_registro

DELIMITER //
CREATE PROCEDURE SP_insertar_eliminar_registro(IN P_accion varchar(40), IN P_id int, IN P_nombre varchar(10), IN P_ubicacion varchar(60))
BEGIN 
    IF P_accion = UPPER('eliminar') THEN    
        SET @borrar = CONCAT('DELETE FROM freezers WHERE id_freezer = ', P_id);
        PREPARE runSQL  FROM @borrar;
        EXECUTE runSQL;
        DEALLOCATE PREPARE runSQL;
    ELSE IF P_accion = UPPER('insertar')THEN
        INSERT INTO freezers  VALUES (P_id, P_nombre, P_ubicacion);
        END IF;
    END IF;
END;
//

SET @P_accion = 'insertar';
SET @P_id = 555;
SET @P_nombre = 'F5';
SET @P_ubicacion = 'Laboratorio';

CALL SP_insertar_eliminar_registro(@P_accion, @P_id , @P_nombre, @P_ubicacion);