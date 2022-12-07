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

-- Todas las tablas siguientes son similares. Cada una representa un tramo del estudio en el que se tomó muestras de casi todos los pacientes. 
-- Cada tramo incluye muchas muestas de sangre que estan guardadas en difentes cajas ( de la tabla anterior). 
-- En este caso ejemplifiqué con 3 tablas, para 3 tramos pero hay mas de 20 tramos en total.

drop table if exists tramo_S0;
create table if not exists tramo_S0(
    id_muestraS0 int not null auto_increment,
    paciente varchar(4) not null,
    protocolo int not null,
    ubicacion_caja int not null,
    fecha_extraccion date,
    primary key (id_muestraS0, protocolo),
    CONSTRAINT `fk_muestraS0` foreign key(ubicacion_caja) references cajas_muestras(id_caja),
    CONSTRAINT `fk_pacientesS0` foreign key(paciente) references pacientes(id_paciente)
);

drop table if exists tramo_S1;
create table if not exists tramo_S1(
    id_muestraS1 int not null auto_increment,
    paciente varchar(4) not null,
    protocolo int not null,
    ubicacion_caja int not null,
    fecha_extraccion date,
    primary key (id_muestraS1, protocolo),
    CONSTRAINT `fk_muestraS1` foreign key(ubicacion_caja) references cajas_muestras(id_caja),
    CONSTRAINT `fk_pacientesS1` foreign key(paciente) references pacientes(id_paciente)
);

drop table if exists tramo_S2;
create table if not exists tramo_S2(
    id_muestraS2 int not null auto_increment,
    paciente varchar(4) not null,
    protocolo int not null,
    ubicacion_caja int not null,
    fecha_extraccion date,
    primary key (id_muestraS2, protocolo),
    CONSTRAINT `fk_muestraS2` foreign key(ubicacion_caja) references cajas_muestras(id_caja),
    CONSTRAINT `fk_pacientesS2` foreign key(paciente) references pacientes(id_paciente)
);

drop table if exists tramo_S3;
create table if not exists tramo_S3(
    id_muestraS3 int not null auto_increment,
    paciente varchar(4) not null,
    protocolo int not null,
    ubicacion_caja int not null,
    fecha_extraccion date,
    primary key (id_muestraS3, protocolo),
    CONSTRAINT `fk_muestraS3` foreign key(ubicacion_caja) references cajas_muestras(id_caja),
    CONSTRAINT `fk_pacientesS3` foreign key(paciente) references pacientes(id_paciente)
);
