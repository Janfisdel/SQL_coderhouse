USE proyecto_chagas;

-- tabla de provincias de Argentina
DROP TABLE IF EXISTS provincias;
CREATE TABLE IF NOT EXISTS provincias(
    id_provincia INT NOT NULL auto_increment,
    nombre_provincia VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_provincia)
);

-- Tabla de Obras sociales
DROP TABLE IF EXISTS obra_social;
CREATE TABLE IF NOT EXISTS obra_social(
    id_obra_social INT NOT NULL auto_increment,
    nombre_obra_social VARCHAR(100) NOT NULL,
    PRIMARY KEY(id_obra_social)
);

-- Tabla de freezers donde se guardan cajas con muestra de sangre. 
DROP TABLE IF EXISTS freezers;
CREATE TABLE IF NOT EXISTS freezers(
    id_freezer INT NOT NULL auto_increment,
    nombre_freezer VARCHAR(10) NOT NULL,
    ubicacion_edificio VARCHAR(60) NOT NULL,
    PRIMARY KEY(id_freezer)
);

-- Tabla de cajas donde se guardan tubos con muestras de sangre
DROP TABLE IF EXISTS cajas_muestras;
CREATE TABLE IF NOT EXISTS cajas_muestras(
    id_caja INT NOT NULL auto_increment,
    nombre_caja VARCHAR(10) NOT NULL,
    ubicacion_freezer INT NOT NULL,
    cantidad_muestras INT NOT NULL,
    PRIMARY KEY(id_caja),
    CONSTRAINT `fk_cajas` FOREIGN KEY(ubicacion_freezer) REFERENCES freezers(id_freezer)
);

-- Tabla de pacientes en el tratamiento con sus datos personales 
DROP TABLE IF EXISTS pacientes;
CREATE TABLE IF NOT EXISTS pacientes(
    id_paciente INT NOT NULL auto_increment,
    nro_proyecto CHAR(4) NOT NULL,
    apellido_paciente VARCHAR(50) NOT NULL,
    nombre_paciente VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    provincia_paciente INT NOT NULL,
    obra_social_paciente INT NOT NULL,
    medicacion CHAR(2) NOT NULL,
    PRIMARY KEY(id_paciente),
    CONSTRAINT `fk_provincia_paciente` FOREIGN KEY(provincia_paciente) REFERENCES provincias(id_provincia),
    CONSTRAINT `fk_obra_social` FOREIGN KEY(obra_social_paciente) REFERENCES obra_social(id_obra_social)
);

-- Tabla de tramos del proyecto, cada paciente tiene muestras en diferentes tramos del proyecto para evaluar su progreso en el tratamiento
DROP TABLE IF EXISTS tramos_proyecto;
CREATE TABLE IF NOT EXISTS tramos_proyecto(
    id_tramo INT NOT NULL auto_increment,
    nombre_tramo CHAR(2) NOT NULL,
    PRIMARY KEY(id_tramo)
);

-- Tabla de muestras de sangre del proyecto. Cada paciente tiene mas de una muestra, como mucho una en cada tramo.
-- No todos los paciente tienen muestras en todos los tramos
DROP TABLE IF EXISTS muestras_proyecto;
CREATE TABLE IF NOT EXISTS muestras_proyecto(
    id_muestra INT NOT NULL auto_increment,
    paciente INT NOT NULL,
    protocolo INT NOT NULL,
    ubicacion_caja INT NOT NULL,
    fecha_extraccion DATE,
    tramo INT NOT NULL,
    HAI CHAR(1) NOT NULL,
    IFI CHAR(1) NOT NULL,
    ADN CHAR(1) NOT NULL,
    PRIMARY KEY(id_muestra),
    CONSTRAINT `fk_muestra` FOREIGN KEY(ubicacion_caja) REFERENCES cajas_muestras(id_caja),
    CONSTRAINT `fk_pacientes` FOREIGN KEY(paciente) REFERENCES pacientes(id_paciente),
    CONSTRAINT `fk_tramo` FOREIGN KEY(tramo) REFERENCES tramos_proyecto(id_tramo)
);

-- Tabla para auditoria. Se guardan las modificaciones realizadas en las tablas
DROP TABLE IF EXISTS log_auditoria;
CREATE TABLE IF NOT EXISTS log_auditoria(
    id_log INT auto_increment,
    nombre_accion VARCHAR(15) NOT NULL,
    nombre_tabla VARCHAR(50) NOT NULL,
    campos_nuevos TEXT,
    campos_anterior TEXT,
    usuario VARCHAR(100) NOT NULL,
    fecha_modificacion DATE NOT NULL,
    hora_modificacion time NOT NULL,
    PRIMARY KEY(id_log)
);

-- Tabla para auditoria. No se guardan las modificaciones realizadas en las tablas
DROP TABLE IF EXISTS log_auditoria2;
CREATE TABLE IF NOT EXISTS log_auditoria2(
    id_log INT auto_increment,
    nombre_accion VARCHAR(15) NOT NULL,
    nombre_tabla VARCHAR(50) NOT NULL,
    usuario VARCHAR(100) NOT NULL,
    fecha_modificacion DATE NOT NULL,
    hora_modificacion TIME NOT NULL,
    PRIMARY KEY(id_log)
);