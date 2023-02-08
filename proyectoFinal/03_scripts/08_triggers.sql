USE proyecto_chagas;

-- Trigger de insert en tabla pacientes. guarda informacion de los registros nuevos en LOG y solo la tarea realizada en LOG2
DROP TRIGGER IF EXISTS trg_pacientes_insert;

DELIMITER //
CREATE TRIGGER trg_pacientes_insert BEFORE INSERT ON pacientes
FOR EACH ROW
BEGIN
INSERT INTO LOG_AUDITORIA(nombre_accion, nombre_tabla, campos_nuevos, usuario, fecha_modificacion, hora_modificacion)
VALUES('INSERT', 'pacientes', CONCAT('id_paciente:', NEW.id_paciente, ', nro_proyecto:', NEW.nro_proyecto, ', nombre_paciente:', NEW.nombre_paciente, ', apellido_paciente:', NEW.apellido_paciente, ', fecha_nacimiento:', NEW.fecha_nacimiento, ', provincia_paciente:', NEW.provincia_paciente), CURRENT_USER(), DATE(NOW()), TIME(NOW()) );

INSERT INTO LOG_AUDITORIA2(nombre_accion, nombre_tabla, usuario, fecha_modificacion, hora_modificacion)
VALUES ('INSERT', 'pacientes', CURRENT_USER(), DATE(NOW()), TIME(NOW()));

END;
//

-- Trigger de delete en tabla pacientes. guarda informacion de los registros elimados en LOG y solo la tarea realizada en LOG2
DROP TRIGGER IF EXISTS trg_pacientes_delete;

DELIMITER //
CREATE TRIGGER trg_pacientes_delete AFTER DELETE ON pacientes
FOR EACH ROW
BEGIN
INSERT INTO LOG_AUDITORIA(nombre_accion, nombre_tabla, campos_anterior, usuario, fecha_modificacion, hora_modificacion)
VALUES('DELETE', 'pacientes', CONCAT('id_paciente:', OLD.id_paciente, ', nro_proyecto:', OLD.nro_proyecto, ', nombre_paciente:', OLD.nombre_paciente, ', apellido_paciente:', OLD.apellido_paciente, ', fecha_nacimiento:', OLD.fecha_nacimiento, ', provincia_paciente:', OLD.provincia_paciente), CURRENT_USER(), DATE(NOW()), TIME(NOW()) );

INSERT INTO LOG_AUDITORIA2(nombre_accion, nombre_tabla, usuario, fecha_modificacion, hora_modificacion)
VALUES ('DELETE', 'pacientes', CURRENT_USER(), DATE(NOW()), TIME(NOW()));

END;
//

-- Trigger de update en tabla pacientes. guarda informacion de los registros modificados en LOG y solo la tarea realizada en LOG2
DROP TRIGGER IF EXISTS trg_pacientes_update;

DELIMITER //
CREATE TRIGGER trg_pacientes_update BEFORE UPDATE ON pacientes
FOR EACH ROW
BEGIN
INSERT INTO LOG_AUDITORIA(nombre_accion, nombre_tabla, campos_nuevos, campos_anterior, usuario, fecha_modificacion, hora_modificacion)
VALUES('UPDATE', 'pacientes', CONCAT('id_paciente:', NEW.id_paciente, ', nro_proyecto:', NEW.nro_proyecto, ', nombre_paciente:', NEW.nombre_paciente, ', apellido_paciente:', NEW.apellido_paciente, ', fecha_nacimiento:', NEW.fecha_nacimiento, ', provincia_paciente:', NEW.provincia_paciente),  CONCAT('id_paciente:', OLD.id_paciente, ', nro_proyecto:', OLD.nro_proyecto, ', nombre_paciente:', OLD.nombre_paciente, ', apellido_paciente:', OLD.apellido_paciente, ', fecha_nacimiento:', OLD.fecha_nacimiento, ', provincia_paciente:', OLD.provincia_paciente), CURRENT_USER(), DATE(NOW()), TIME(NOW()) );

INSERT INTO LOG_AUDITORIA2(nombre_accion, nombre_tabla, usuario, fecha_modificacion, hora_modificacion)
VALUES ('UPDATE', 'pacientes', CURRENT_USER(), DATE(NOW()), TIME(NOW()));

END;
//

-- Trigger de insert en tabla muestras_proyecto. guarda informacion de los registros nuevos en LOG y solo la tarea realizada en LOG2
DROP TRIGGER IF EXISTS trg_muestras_insert;

DELIMITER //
CREATE TRIGGER trg_muestras_insert AFTER INSERT ON muestras_proyecto
FOR EACH ROW
BEGIN
INSERT INTO LOG_AUDITORIA(nombre_accion, nombre_tabla, campos_nuevos, usuario, fecha_modificacion, hora_modificacion)
VALUES('INSERT', 'muestras_proyecto', CONCAT('id_muestra:', NEW.id_muestra, ', paciente:', NEW.paciente, ', protocolo:', NEW.protocolo, ', ubicacion_caja:', NEW.ubicacion_caja, ', fecha_extraccion:', NEW.fecha_extraccion, ', tramo:', NEW.tramo, ', HAI:', NEW.HAI, ', IFI:', NEW.IFI, ', ADN:', NEW.ADN), CURRENT_USER(), DATE(NOW()), TIME(NOW()) );

INSERT INTO LOG_AUDITORIA2(nombre_accion, nombre_tabla, usuario, fecha_modificacion, hora_modificacion)
VALUES ('INSERT', 'muestras_proyecto', CURRENT_USER(), DATE(NOW()), TIME(NOW()));

END;
//

-- Trigger de update en tabla muestras_proyecto. guarda informacion de los registros nuevos y viejos en LOG y solo la tarea realizada en LOG2
DROP TRIGGER IF EXISTS trg_muestras_update;

DELIMITER //
CREATE TRIGGER trg_muestras_update AFTER UPDATE ON muestras_proyecto
FOR EACH ROW
BEGIN
INSERT INTO LOG_AUDITORIA(nombre_accion, nombre_tabla, campos_nuevos, campos_anterior, usuario, fecha_modificacion, hora_modificacion)
VALUES('UPDATE', 'muestras_proyecto', CONCAT('id_muestra:', NEW.id_muestra, ', paciente:', NEW.paciente, ', protocolo:', NEW.protocolo, ', ubicacion_caja:', NEW.ubicacion_caja, ', fecha_extraccion:', NEW.fecha_extraccion, ', tramo:', NEW.tramo, ', HAI:', NEW.HAI, ', IFI:', NEW.IFI, ', ADN:', NEW.ADN), CONCAT('id_muestra:', OLD.id_muestra, ', paciente:', OLD.paciente, ', protocolo:', OLD.protocolo, ', ubicacion_caja:', OLD.ubicacion_caja, ', fecha_extraccion:', OLD.fecha_extraccion, ', tramo:', OLD.tramo, ', HAI:', OLD.HAI, ', IFI:', OLD.IFI, ', ADN:', OLD.ADN),  CURRENT_USER(), DATE(NOW()), TIME(NOW()) );

INSERT INTO LOG_AUDITORIA2(nombre_accion, nombre_tabla, usuario, fecha_modificacion, hora_modificacion)
VALUES ('UPDATE', 'muestras_proyecto', CURRENT_USER(), DATE(NOW()), TIME(NOW()));

END;
//

-- Trigger de delete en tabla muestras_proyecto. guarda informacion de los registros eliminados en LOG y solo la tarea realizada en LOG2
DROP TRIGGER IF EXISTS trg_muestras_delete;

DELIMITER //
CREATE TRIGGER trg_muestras_delete BEFORE DELETE ON muestras_proyecto
FOR EACH ROW
BEGIN
INSERT INTO LOG_AUDITORIA(nombre_accion, nombre_tabla, campos_anterior, usuario, fecha_modificacion, hora_modificacion)
VALUES('DELETE', 'muestras_proyecto', CONCAT('id_muestra:', OLD.id_muestra, ', paciente:', OLD.paciente, ', protocolo:', OLD.protocolo, ', ubicacion_caja:', OLD.ubicacion_caja, ', fecha_extraccion:', OLD.fecha_extraccion, ', tramo:', OLD.tramo, ', HAI:', OLD.HAI, ', IFI:', OLD.IFI, ', ADN:', OLD.ADN),  CURRENT_USER(), DATE(NOW()), TIME(NOW()) );

INSERT INTO LOG_AUDITORIA2(nombre_accion, nombre_tabla, usuario, fecha_modificacion, hora_modificacion)
VALUES ('DELETE', 'muestras_proyecto', CURRENT_USER(), DATE(NOW()), TIME(NOW()));

END;
//

-- Ejemplos para prueba de triggers
INSERT INTO pacientes(nro_proyecto, apellido_paciente, nombre_paciente, fecha_nacimiento, provincia_paciente, obra_social_paciente, medicacion) VALUES ('T668', 'CASTRO', 'Juan', '1993-05-10', 3, 1, 'si');
UPDATE pacientes SET nro_proyecto = 'T669' WHERE nro_proyecto = 'T668';
DELETE FROM pacientes WHERE nro_proyecto = 'T669';

INSERT INTO muestras_proyecto (paciente, protocolo, ubicacion_caja, fecha_extraccion, tramo, HAI, IFI, ADN) VALUES(470, 135169, 38, '2006-04-27', 3, 'P', 'N', 'P');
UPDATE muestras_proyecto SET protocolo= '68499' WHERE protocolo = 135169 ; 
DELETE FROM muestras_proyecto WHERE protocolo = 68499;