-- El proyecto es un banco de muestras de sangre de un estudio para la deteccion de la enfermedad de Chagas
drop schema if exists proyecto_sangre;
create schema if not exists proyecto_sangre;
use proyecto_sangre;


-- Esta tabla indica la cuantos freezers se posee y su ubicacion. 
drop table if exists freezers;
create table if not exists FREEZERS(
    id_freezer int not null primary key,
    nombre_freezer varchar(10),
    ubicacion_edificio varchar(60)
);
