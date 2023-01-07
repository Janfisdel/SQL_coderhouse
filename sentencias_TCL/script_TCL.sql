use proyecto_sangre;

-- uso de ROLLBACK Y COMMIT luego de eliminar registros en tabla 'muestras_proyecto'
START TRANSACTION;
DELETE FROM muestras_proyecto
WHERE id_muestra>1843;
-- ROLLBACK;
-- COMMIT;

-- reinserción de registros en tabla 'muestras_proyecto'
/*
INSERT INTO muestras_proyecto values (1844, 'T570', 137391, 38, '2006-03-28', 'S3'),
							  (1845, 'T571', 132443, 38, '2005-11-15, 'S3'),
							  (1846, 'T572', 135167, 38, '2006-04-27', 'S3')                              
                              ;
*/

-- uso de SAVEPOINT en tabla 'pacientes'
START TRANSACTION;
INSERT INTO pacientes VALUES ('T576', 'Uriel', 'Pereyra','1985-05-07', 2),
							 ('T577', 'Agustina', 'Becerra', '1999-10-07', 8),
                             ('T578', 'Natalia', 'Perea', '2000-07-12', 9),
                             ('T579', 'Camilo', 'Torres', '1987-11-14', 5);
savepoint svp_1;
INSERT INTO pacientes VALUES ('T580', 'Abel', 'Soleo','1999-05-09', 1),
							 ('T581', 'Soledad', 'Valenzuela', '1977-12-30', 7),
                             ('T582', 'Paulo', 'Alejandro', '2001-01-12', 3),
                             ('T583', 'Emanuel', 'Mena', '1990-10-14', 13);
savepoint svp_2;
-- RELEASE SAVEPOINT svp_1;
-- COMMIT;


