use proyecto_sangre;

-- Creación de tabla para auditoria genérica con los registros modificados
drop table if exists LOG_AUDITORIA;

CREATE TABLE IF NOT EXISTS LOG_AUDITORIA
(id_log INT AUTO_INCREMENT,
nombre_accion varchar(15),
nombre_tabla varchar(50),
campos_nuevos text,
campos_anterior text,
usuario varchar(100),
fecha_modificacion date,
hora_modificacion time,
primary key(id_log)
);

-- Creacion de tabla genérica sin datos de los registros
drop table if exists LOG_AUDITORIA2;

CREATE TABLE IF NOT EXISTS LOG_AUDITORIA2
(id_log INT AUTO_INCREMENT,
nombre_accion varchar(15),
nombre_tabla varchar(50),
usuario varchar(100),
fecha_modificacion date,
hora_modificacion time,
primary key(id_log)
);

drop trigger if exists TRG_pacientes_insert;
-- Trigger de insert en tabla pacientes. guarda informacion de los registros nuevos
DELIMITER //
CREATE TRIGGER TRG_pacientes_insert before insert on pacientes
for each row
begin
INSERT INTO LOG_AUDITORIA(nombre_accion, nombre_tabla, campos_nuevos, usuario, fecha_modificacion, hora_modificacion)
VALUES('INSERT', 'pacientes', concat('id_paciente:', NEW.id_paciente, ' nombre_paciente:', NEW.nombre_paciente, ' apellido_paciente:', NEW.apellido_paciente, ' fecha_nacimiento:', NEW.fecha_nacimiento, ' provincia_paciente:', NEW.provincia_paciente), CURRENT_USER(), date(now()), time(now()) );

end;
//


drop trigger if exists TRG_pacientes_delete;
-- Trigger de delete en tabla pacientes no guarda la informacion que se borra
DELIMITER //
CREATE TRIGGER TRG_pacientes_delete after delete on pacientes
for each row
begin
INSERT INTO LOG_AUDITORIA2(nombre_accion, nombre_tabla, usuario, fecha_modificacion, hora_modificacion)
VALUES('DELETE', 'pacientes', CURRENT_USER(), date(now()), time(now()) );

end;
//

drop trigger if exists TRG_muestras_update;
-- Trigger de update en tabla muestras_proyecto. guarda informacion de modificaciones en los registros existentes

DELIMITER //
CREATE TRIGGER TRG_muestras_update before update on muestras_proyecto
for each row
begin
    INSERT INTO LOG_AUDITORIA(nombre_accion, nombre_tabla, campos_anterior, campos_nuevos, usuario, fecha_modificacion, hora_modificacion)
    VALUES('UPDATE', 'muestras_proyecto', concat('id_muestra:', OLD.id_muestra, ' paciente:', OLD.paciente, ' protocolo:', OLD.protocolo, ' ubicacion_caja:', OLD.ubicacion_caja, ' fecha_extraccion:', OLD.fecha_extraccion, ' tramo_proyecto:', OLD.tramo_proyecto ), concat('id_muestra:', NEW.id_muestra, ' paciente:', NEW.paciente, ' protocolo:', NEW.protocolo, ' ubicacion_caja:', NEW.ubicacion_caja, ' fecha_extraccion:', NEW.fecha_extraccion, ' tramo_proyecto:', NEW.tramo_proyecto ), CURRENT_USER(), date(now()), time(now()) );

end;
//

drop trigger if exists TRG_muestras_delete;
-- Trigger de delete en tabla muestras_proyecto. no guarda la informacion que se borra
DELIMITER //
CREATE TRIGGER TRG_muestras_delete after delete on muestras_proyecto
for each row
begin
    INSERT INTO LOG_AUDITORIA2(nombre_accion, nombre_tabla, usuario, fecha_modificacion, hora_modificacion)
    VALUES('DELETE', 'muestras_proyecto', CURRENT_USER(), date(now()), time(now()) );
end;
//


insert into pacientes values ('T668', 'Juan', 'Castro', '1993-05-10', 3);
delete from pacientes where id_paciente = 'T668';
update muestras_proyecto SET paciente = 'T184' where id_muestra = 1000; -- es T084
insert into muestras_proyecto (paciente, protocolo, ubicacion_caja, fecha_extraccion, tramo_proyecto) values('T574', 135169, 38, '2006-04-27', 'S3');
delete from muestras_proyecto where protocolo = 135169;

SELECT * FROM LOG_AUDITORIA;
SELECT * FROM LOG_AUDITORIA2;
SELECT * FROM pacientes;
SELECT * FROM muestras_proyecto;

