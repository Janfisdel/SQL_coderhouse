USE proyecto_chagas;

-- inserción de registros en tabla provincias
INSERT INTO provincias (nombre_provincia) VALUES ('BUENOS AIRES'),          
                                                 ('CIUDAD AUTONOMA DE BUENOS AIRES'),
                                                 ('CATAMARCA'),
                                                 ('CHACO'),
                                                 ('CHUBUT'),
                                                 ('CORDOBA'),
                                                 ('CORRIENTES'),
                                                 ('ENTRE RIOS'),
                                                 ('FORMOSA'),
                                                 ('JUJUY'),
                                                 ('LA PAMPA'),
                                                 ('LA RIOJA'),
                                                 ('MENDOZA'),
                                                 ('MISIONES'),
                                                 ('NEUQUEN'),
                                                 ('RIO NEGRO'),
                                                 ('SALTA'),
                                                 ('SAN JUAN'),
                                                 ('SAN LUIS'),
                                                 ('SANTA CRUZ'),
                                                 ('SANTA FE'),
                                                 ('SANTIAGO DEL ESTERO'),
                                                 ('TIERRA DEL FUEGO'),
                                                 ('TUCUMAN');


-- inserción de registros en tabla obra_social
INSERT INTO obra_social(nombre_obra_social) VALUES  ('Avalian'),
                                                    ('Galeno'),
                                                    ('Hospital Italiano'),
                                                    ('Medicus'),
                                                    ('Medife'),
                                                    ('Obsba'),
                                                    ('Omint'),
                                                    ('Osde'),
                                                    ('Osplad'),
                                                    ('Premedic'),
                                                    ('Sancor'),
                                                    ('Swiss Medical'),
                                                    ('Union Personal'),
                                                    ('Otra'),
                                                    ('No posee');             

-- inserción de registros en tabla freezers
INSERT INTO freezers(nombre_freezer, ubicacion_edificio) VALUES ('Freezer1', 'Segundo piso - Clinica'),
                                                                ('Freezer2', 'Tercer piso - Laboratorio'),
                                                                ('Freezer3', 'Primer piso - Laboratorio'),
                                                                ('Freezer4', 'Tercer piso - Clinica'),
																('Freezer5', 'Primer piso - Clinica');

-- inserción de registros en tabla tramos_proyecto
INSERT INTO tramos_proyecto (nombre_tramo) VALUES ('S0'),   
                                                  ('S1'),
                                                  ('S2'),
                                                  ('S3');
