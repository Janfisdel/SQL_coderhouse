USE mysql;

-- Creacion de usuario "doctor" 
CREATE USER IF NOT EXISTS 'user_doctor'@'localhost' IDENTIFIED BY 'abc123';

-- Creacion de usuario "administrativo" 
CREATE USER IF NOT EXISTS 'user_administrativo'@'localhost' IDENTIFIED BY 'abc123';

-- PERMISOS DE SOLO LECTURA PARA USER_ADMINISTRATIVO EN TODAS LAS TABLAS DE "PROYECTO_SANGRE"
GRANT SELECT ON proyecto_chagas.* TO 'user_administrativo'@'localhost';

-- PERMISOS DE LECTURA, INSERSION Y MODIFICACION PARA USER_DOCTOR EN TODAS LAS TABLAS DE "PROYECTO_SANGRE"
GRANT SELECT, INSERT, UPDATE ON proyecto_chagas.* TO 'user_doctor'@'localhost';
