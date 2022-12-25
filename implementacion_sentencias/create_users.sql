use mysql;

-- CREACION DE DOS USUARIOS
CREATE USER if not exists 'user_lector'@'localhost' identified by 'abc123';
CREATE USER if not exists 'user_editor'@'localhost' identified by 'abc123';

-- PERMISOS DE SOLO LECTURA PARA USER_LECTOR EN TODAS LAS TABLAS DE "PROYECTO_SANGRE"
GRANT SELECT ON proyecto_sangre.* TO 'user_lector'@'localhost';

-- PERMISOS DE LECTURA, INSERSION Y MODIFICACION PARA USER_EDITOR EN TODAS LAS TABLAS DE "PROYECTO_SANGRE"
GRANT SELECT, INSERT, UPDATE ON proyecto_sangre.* TO 'user_editor'@'localhost';


