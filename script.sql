/*----------------DDL-------------------------*/
SHOW DATABASES; /*Mostrar las bases de datos*/
CREATE DATABASE sistema_ventas; /*Crear base de datos*/
USE sistema_ventas; /*Seleccionar base de datos*/
/*Motor de almacenamiento MyISAM, InnoDB ( ENGINE=MYISAM;)*/

DROP TABLE IF EXISTS ventas; 
DROP TABLE IF EXISTS productos; 
DROP TABLE IF EXISTS sedes; 
DROP TABLE IF EXISTS usuarios; 


CREATE TABLE sedes (
    id INT UNSIGNED AUTO_INCREMENT, 
    nombre VARCHAR(200) NOT NULL, 
    calle VARCHAR(10) NOT NULL,
    carrera VARCHAR(10) NOT NULL,
    nomenclatura VARCHAR(10) NOT NULL, 
    barrio VARCHAR(50), 
    ciudad VARCHAR(100) NOT NULL, 
    descripcion TEXT,
    CONSTRAINT `pk_id_sedes` PRIMARY KEY(id) 
); 

ALTER TABLE sedes ADD CONSTRAINT `uq_nombre_sedes` UNIQUE(nombre);

/* INSERT INTO */
INSERT INTO sedes (nombre, calle, carrera, nomenclatura, ciudad)
VALUES ('calle 3', 'Natura sede bogota', 'Carrera 3', 'NSD3', 'Medellín3'),
('Natura sede bogota','calle 2', 'Carrera 2', 'NSD2', 'Medellín2');,
('Natura sede bogota','calle 4', 'Carrera 4', 'NSD4', 'Medellín4');

/* SELECT */
SELECT * FROM sedes;
SELECT id,nombre,calle FROM sedes;

/* DELETE */
DELETE FROM sedes 
WHERE nombre = 'Natura sede bogota';

DELETE FROM sedes 
WHERE nombre = 'Natura sede bogota' AND calle = 'calle 2';

DELETE FROM sedes 
WHERE nombre = 'Natura sede bogota' OR calle = 'calle 2';

DELETE FROM sedes 
WHERE nombre IN ('value1', 'value2')

/* UPDATE */

UPDATE sedes 
SET nombre = 'Natura sede bogota', calle = 'calle 70', carrera = 'Carrera 3', nomenclatura = 'NSD2', barrio = 'Kenedy', ciudad = 'Medellín', descripcion = 'Buena sede'
WHERE id = 12;

CREATE TABLE productos (
    id INT UNSIGNED AUTO_INCREMENT, 
    nombre VARCHAR(255) NOT NULL, 
    descripcion VARCHAR(500), 
    numero_pasillo INT UNSIGNED NOT NULL, 
    estanteria VARCHAR(5) NOT NULL, 
    nivel INT NOT NULL, 
    precio FLOAT(6,3) UNSIGNED NOT NULL, 
    stock INT UNSIGNED, 
    id_sede INT UNSIGNED NOT NULL, 
    CONSTRAINT `pk_id_productos` PRIMARY KEY(id), 
    CONSTRAINT `fk_id_sede_productos` FOREIGN KEY (id_sede) REFERENCES sedes(id) 
);

ALTER TABLE productos ADD CONSTRAINT `uq_nombre_productos` UNIQUE(nombre);


CREATE TABLE usuarios (
    id INT UNSIGNED AUTO_INCREMENT, 
    documento VARCHAR(100) NOT NULL,
    nombre VARCHAR(200) NOT NULL, 
    apellido VARCHAR(100) NOT NULL,
    sexo ENUM('Femenino', 'Masculino'), 
    tipo_documento ENUM('CC','CE','TI') NOT NULL, 
    fecha_nacimiento DATE, 
    nacionalidad ENUM('Colombiano', 'Venezolanos', 'Colombo-Venzolano'), 
    fecha_creacion TIMESTAMP NOT NULL, 
    CONSTRAINT `pk_id_usuarios` PRIMARY KEY(id) 
);

CREATE TABLE ventas ( 
    id INT UNSIGNED AUTO_INCREMENT, 
    fecha DATE, 
    id_vendedor INT UNSIGNED, 
    id_cliente INT UNSIGNED, 
    id_sede INT UNSIGNED, 
    CONSTRAINT `pk_id_ventas` PRIMARY KEY(id), 
    CONSTRAINT `fk_id_vendedor_ventas` FOREIGN KEY (id_vendedor) REFERENCES usuarios(id) , 
    CONSTRAINT `fk_id_cliente_ventas` FOREIGN KEY (id_cliente) REFERENCES usuarios(id), 
    CONSTRAINT `fk_id_sede_ventas` FOREIGN KEY (id_sede) REFERENCES sedes(id) 
);