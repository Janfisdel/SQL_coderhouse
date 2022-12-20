-- El proyecto es un banco de muestras de sangre de un estudio para la deteccion de la enfermedad de Chagas
drop schema if exists proyecto_sangre;
create schema if not exists proyecto_sangre;
use proyecto_sangre;

-- tabla de provincias del pais 
drop table if exists provincias;
create table if not exists PROVINCIAS(
    id_provincia int not null auto_increment,
    nombre_provincia varchar(50) not null,
    primary key(id_provincia)
);

-- Listado de todos los pacientes en el tratamiento con sus datos personales y un numero que se le agregó para identificarlos
drop table if exists pacientes;
create table if not exists PACIENTES(
    id_paciente varchar(4) not null,
    nombre_paciente varchar(50) not null,
    apellido_paciente varchar(50) not null,
    fecha_nacimiento date not null,
    provincia_paciente int not null,
    primary key(id_paciente),
    CONSTRAINT `fk_provincia` foreign key(provincia_paciente) references provincias(id_provincia)
);

-- Esta tabla indica la cuantos freezers se posee y su ubicacion. 
drop table if exists freezers;
create table if not exists FREEZERS(
    id_freezer int not null primary key,
    nombre_freezer varchar(10),
    ubicacion_edificio varchar(60)
);

-- Esta tabla indica cuantas cajas hay, en que freezer se guardan y cuantas muestras de sangre hay dentro de cada caja
drop table if exists cajas_muestras;
create table if not exists CAJAS_MUESTRAS(
    id_caja int not null auto_increment,
    nombre_caja varchar(10),
    ubicacion_freezer int not null,
    cantidad_muestras int not null,
    primary key(id_caja),
    CONSTRAINT `fk_cajas` foreign key(ubicacion_freezer) references freezers(id_freezer)
     
);

-- Tabla con todas las muestras del proyecto. Cada paciente tiene mas de una muestra, como mucho una en cada proyecto.
-- No todos los paciente tienen muestras en todos los tramos

drop table if exists  muestras_proyecto;
create table if not exists muestras_proyecto(
    id_muestra int not null auto_increment,
    paciente varchar(4) not null,
    protocolo int not null,
    ubicacion_caja int not null,
    fecha_extraccion date,
    tramo_proyecto varchar(2) not null,
    primary key (id_muestra, protocolo),
    CONSTRAINT `fk_muestra` foreign key(ubicacion_caja) references cajas_muestras(id_caja),
    CONSTRAINT `fk_pacientes` foreign key(paciente) references pacientes(id_paciente)
);