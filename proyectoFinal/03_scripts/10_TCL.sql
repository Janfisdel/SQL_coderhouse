USE proyecto_sangre;

-- uso de ROLLBACK Y COMMIT luego de eliminar registros en tabla 'muestras_proyecto'
START TRANSACTION;
DELETE FROM muestras_proyecto
WHERE id_muestra>1840;
ROLLBACK;
COMMIT;

-- reinserción de registros en tabla 'muestras_proyecto'
/*
INSERT INTO muestras_proyecto values (1841, 467,	144329, 38,	'2006-09-26', 4, 'P', 'N', 'P'),
									 (1842, 468,	137391,	38,	'2006-03-28', 4, 'P', 'P', 'P'),
									 (1843, 469, 132443, 38, '2005-11-15', 4, 'N', 'N', 'N'),
									 (1844, 470,	135167,	38,	'2006-04-27', 4, 'P', 'N', 'N');
*/



-- uso de SAVEPOINT en tabla 'pacientes'
START TRANSACTION;
INSERT INTO pacientes (nro_proyecto, nombre_paciente, apellido_paciente, fecha_nacimiento, provincia_paciente, obra_social_paciente, medicacion) VALUES ('T576', 'Uriel', 'Pereyra','1985-05-07', 2, 5, 'si'),
							 ('T577', 'Agustina', 'Becerra', '1999-10-07', 8, 15, 'si'),
                             ('T578', 'Natalia', 'Perea', '2000-07-12', 9, 2, 'no'),
                             ('T579', 'Camilo', 'Torres', '1987-11-14', 5, 4, 'si');
savepoint svp_1;
INSERT INTO pacientes (nro_proyecto, nombre_paciente, apellido_paciente, fecha_nacimiento, provincia_paciente, obra_social_paciente, medicacion) VALUES ('T580', 'Abel', 'Soleo','1999-05-09', 1, 14, 'no'),
							 ('T581', 'Soledad', 'Valenzuela', '1977-12-30', 7, 2, 'si'),
                             ('T582', 'Paulo', 'Alejandro', '2001-01-12', 3, 9, 'si'),
                             ('T583', 'Emanuel', 'Mena', '1990-10-14', 13, 2, 'no');
savepoint svp_2;
RELEASE SAVEPOINT svp_1;
ROLLBACK;
COMMIT;


