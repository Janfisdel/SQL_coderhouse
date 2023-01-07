use proyecto_sangre;

-- Insercióm de registros en la tabla FREEZERS
INSERT INTO freezers(nombre_freezer, ubicacion_edificio) values ('Freezer1', 'Clinica - segundo piso'),
														        ('Freezer2', 'Laboratorio - Tercer piso'),
                                                                ('Freezer3', 'Laboratorio - Primer piso'),
                                                                ('Freezer4', 'Clinica - Tercer piso')
																;
                                                                
 -- agrego algunos registros mediante un insert y el resto desde un archivo importado .csv
INSERT INTO cajas_muestras(nombre_caja, ubicacion_freezer, cantidad_muestras) values ('Caja1', 1, 50),
																					 ('Caja2', 1, 50),
																					 ('Caja3', 2, 50),
                                                                                     ('Caja4', 4, 50)
                                                                                     ;
																					
-- para el resto de las tablas las inserciones de datos se importan desde un archivo externo .CSV