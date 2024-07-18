/* CREATE DATABASE prueba_biblioteca;
use prueba_biblioteca;

-- 1 ° Declarar una primary key
CREATE TABLE socios (
id_soc  INT auto_increment primary key not null,
cod_soc VARCHAR(10) NOT NULL,
dni       VARCHAR(15) NOT NULL, 
nom_soc   VARCHAR(70) NOT NULL,
apell_soc VARCHAR(70) NOT NULL,
tel_soc   VARCHAR(60) NOT NULL
);

-- 2 ° Declarar una primary key
CREATE TABLE socios (
id_soc  INT auto_increment not null,
cod_soc VARCHAR(10) NOT NULL,
dni       VARCHAR(15) NOT NULL, 
nom_soc   VARCHAR(70) NOT NULL,
apell_soc VARCHAR(70) NOT NULL,
tel_soc   VARCHAR(60) NOT NULL,
primary key (id_soc)
); */

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE DATABASE biblioteca;
use biblioteca;

CREATE TABLE socios (
id_soc  INT auto_increment primary key not null,
cod_soc VARCHAR(10) NOT NULL,
dni       VARCHAR(15) NOT NULL, 
nom_soc   VARCHAR(70) NOT NULL,
apell_soc VARCHAR(70) NOT NULL,
tel_soc   VARCHAR(60) NOT NULL
);

CREATE TABLE autores (
id_autor  INT auto_increment primary key not null,
nom_aut   VARCHAR(70) NOT NULL,
apell_aut VARCHAR(70) NOT NULL,
pais      VARCHAR(50) NOT NULL
);

CREATE TABLE articulos (
id_articulo  INT auto_increment primary key not null,
cod_artic    INT  NOT NULL,
nom_artic    VARCHAR(100) NOT NULL, 
tipo         VARCHAR(50) NOT NULL,
cantidad     INT NOT NULL,
id_autor     INT NOT NULL,
foreign key (id_autor) references autores(id_autor)
);

CREATE TABLE deterioros (
id_deteriodo  INT auto_increment primary key not null,
comentario    VARCHAR(200) NOT NULL,
id_articulo   INT NOT NULL,
foreign key (id_articulo) references articulos(id_articulo)

);

CREATE TABLE prestamos (
id_prest     INT auto_increment primary key not null,
fecha_pres   DATE NOT NULL,
fecha_top    DATE NOT NULL,
fecha_dev    DATE NOT NULL,
id_soc       INT NOT NULL,
id_articulo  INT NOT NULL,
foreign key (id_soc) references socios(id_soc),
foreign key (id_articulo) references articulos(id_articulo)
);


-- IMPORTACION DE DATOS
    INSERT INTO deterioros (id_deteriodo, comentario, id_articulo)
        VALUES
            (1,'Rotura de tapa',1),
            (2,'Rotura de tapa',2),
            (3,'Rotura de tapa',3),
            (4,'Rotura de tapa',4),
            (5,'Rotura de Hoja',5),
            (6,'Rotura de Hoja',6),
            (7,'Rotura de Hoja',7),
            (8,'Rotura de Hoja',8),
            (9,'Rotura de Hoja',9);

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

-- VISTAS
USE  BIBLIOTECA;

-- Total de prestamos por socio
CREATE OR REPLACE VIEW Tot_prestamos_x_socio AS 
SELECT  s.APELLIDO, s.NOMBRE, count(p.id) AS 'TOTAL DE PRESTAMOS'
FROM  prestamos AS p
INNER JOIN socios AS s ON s.id = p.socio_id
GROUP BY s.apellido, s.nombre
ORDER BY s.apellido, s.nombre;

-- Total de prestamos por socio por anio actual
CREATE OR REPLACE VIEW Tot_prestamos_socio_anio_actual AS 
SELECT  p.fecha_prestamo AS FECHA ,s.APELLIDO, s.NOMBRE, count(p.id) AS 'TOTAL DE PRESTAMOS'
FROM  prestamos AS p
INNER JOIN socios AS s ON s.id = p.socio_id
WHERE YEAR(p.fecha_prestamo) = '2021'
GROUP BY s.apellido, s.nombre
ORDER BY p.fecha_prestamo DESC;

-- Total de libros por anio 
CREATE OR REPLACE VIEW Tot_Libros_x_año AS 
select nombre as 'LIBRO', ano as 'AÑO' , count(id) as 'TOTAL DE LIBROS'
from articulos a
group by a.nombre, a.ano 
order by a.ano desc;

-- Total de prestamos por libro
CREATE OR REPLACE VIEW Tot_prestamos_x_libros AS 
SELECT   a.nombre as LIBROS ,  count(a.id) AS 'TOTAL DE PRESTAMOS'
FROM  articulos AS a
INNER JOIN prestamos AS p ON a.id = p.id
group by a.nombre;

-- Tot_autores_x_pais
CREATE OR REPLACE VIEW Tot_autores_x_pais AS 
SELECT  au.PAIS, au.APELLIDO, au.NOMBRE ,count(id) AS 'TOTAL DE AUTORES'
FROM  autores AS au
GROUP BY au.pais
ORDER BY count(id) desc;

--     ------------------------------------------------------------------------------------------------------------------------------------------------------

-- FUNCIONES
USE  BIBLIOTECA;
-- En esta Funcion ingresaremos el parametro de entrada DNI de la tabla SOCIOS para obtener el email del mismo.

DELIMITER $$
CREATE FUNCTION `get_mail_socios` (p_dni varchar(15))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
      DECLARE v_email VARCHAR(100);
      
      SELECT email
      INTO v_email
      FROM socios
      WHERE 
		dni = p_dni;
	  RETURN v_email;
END$$
DELIMITER ;

-- Prueba de funcion
-- select biblioteca.get_mail_socios('49525672');

-- ------------------------------------------------------------------------ ----------------------------------------------------------------------------

-- En esta Funcion ingresaremos el parametro de entrada DNI de la tabla SOCIOS para obtener
-- la edad comparando el año actual y su fecha de nacimiento.

DELIMITER $$
CREATE FUNCTION `get_years_from_socios` (p_dni varchar(15))
RETURNS INT(3)
DETERMINISTIC
BEGIN 
      -- Declaracion de variables Fecha de cumpleaños y años de cumpleaños
      DECLARE v_birthday DATE;
      DECLARE v_years INT(3);
      
      -- obtener la fecha de cumpleaños del socio
      SELECT fecha_nacimiento
      INTO v_birthday
      FROM socios
      WHERE dni = p_dni;

      -- Obtener el año de cumpleaños
	  SET v_years = YEAR(CURDATE()) - YEAR(v_birthday);

      -- Valido si cumplio años o no en el año en curso.  
      IF MONTH(CURDATE()) <= MONTH(v_birthday) THEN
		IF (DAY(CURDATE()) < DAY(v_birthday))  THEN
			SET v_years = v_years - 1;
        END IF;
	END IF;    
    RETURN v_years;
END$$
DELIMITER ;

-- Prueba de funcion
-- select biblioteca.get_years_from_socios('49525672');

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Stored Procedures 1 
-- Procedimiento de validacion de prestamos existente, actualizacion de fecha de prestamo e insercion de registro -- de Deterioro


DELIMITER $$
CREATE PROCEDURE sp_actualiza_deterioros (IN p_prestamo_id INT, IN p_deterioro tinytext)
BEGIN
    DECLARE v_prestamo_id INT;
    DECLARE v_articulo_id INT;

    -- Valido que el prestamo exista en la tabla.
	SELECT id
    INTO v_prestamo_id
    FROM prestamos
    WHERE id = p_prestamo_id;

	-- Si el prestamo No Existe en la tabla, devolvemos un error    
	IF (v_prestamo_id <> NULL AND v_prestamo_id != p_prestamo_id ) THEN
		SELECT 'El prestamo ingresado no se encuentra en la base de datos' AS error;
    ELSE
	-- Actualizamos la Fecha de devolucion del prestamo con la fecha de Hoy
	   UPDATE prestamos
       SET fecha_devolucion = CURDATE()
       WHERE id = p_prestamo_id;
    
       IF (p_deterioro != '') THEN
		  -- Obtengo el articulo ID del prestamo. 
          SELECT articulo_id
          INTO v_articulo_id
          FROM prestamos
          WHERE id = p_prestamo_id;
	
		  INSERT INTO deterioros VALUES (NULL, v_articulo_id , p_deterioro);
       END IF;
	END IF;

END$$
DELIMITER ;

-- Prueba de SP
-- call sp_actualiza_deterioros(3,'Tiene doblada la tapa');

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Stored Procedures 2 
-- Procedimiento Ordenamiento de Artículos Dependiendo del campo que se elija Con Opción de Visualizarlo de Forma Descendente o Ascendente

DELIMITER //
-- INGRESO DE PARAMETROS DE ENTRADA DE CAMPOS DE LA TABLA DE ARTICULOS

CREATE PROCEDURE ordenamiento_articulos (IN p_campo_a_ordenar varchar (20), IN orden BOOLEAN)
-- ORDEN = 1 -> ASC
-- ORDEN = 0 -> DESC

-- CONDICION DE CONSULTAR LA TABLA DE ARTICULOS, CONCATENA LA CONSULTA Y REALIZA EL ORDENAMIENTOS DE LOS CAMPOS QUE SE ELIJE 
BEGIN
	IF p_campo_a_ordenar <> "" AND orden = 1 THEN
		SET @ordenar = concat("ORDER BY ", p_campo_a_ordenar);
	ELSEIF p_campo_a_ordenar <> "" AND orden = 0 THEN
		SET @ordenar = concat("ORDER BY ", p_campo_a_ordenar, ' DESC');
	ELSE
		SET @ordenar = " ";
	END IF;
	SET @clausula_select = concat ("SELECT * FROM ARTICULOS ", @ordenar);
    
-- PROCESO DE EJECUCION 
	PREPARE ejecucion FROM @clausula_select;
    EXECUTE ejecucion;
    DEALLOCATE PREPARE ejecucion;
END //
DELIMITER ;

-- Prueba de SP
-- call biblioteca.ordenamiento_articulos('nombre', 1);


-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TRIGGER DE INSERCION DE LOG_PRESTAMOS

USE biblioteca;

-- TABLA DE LOG PRESTAMOS, SE INGRESARAN LOS MOVIMIENTOS TRANSACCIONALES
CREATE TABLE logs_prestamos (
  id int unsigned NOT NULL AUTO_INCREMENT,
  accion varchar(45) NOT NULL,
  usuario varchar(45) NOT NULL,
  detalle varchar(100) DEFAULT NULL,
  fecha datetime NOT NULL,
  PRIMARY KEY (id)
) 

-- LOG DE INSERCION DE AUDITORIA DE REGISTRACION DE PRESTAMOS. DEFINIENDO LA ACCION, USUARIO, DETALLE, FECHA ACTUAL
DELIMITER $$
CREATE TRIGGER Logs_after_prestamos
AFTER INSERT ON prestamos
FOR EACH ROW
BEGIN

		INSERT INTO logs_prestamos (id, accion, usuario, detalle, fecha) 
		VALUES 
		(NULL, 'INSERT', SYSTEM_USER(), CONCAT('Se Inserto el prestamo ', NEW.id, ' para el socio ', NEW.socio_id), NOW());

END $$
DELIMITER ;


-- PRUEBA DE TRIGGER
-- INSERTO MANUALMENTE UN REGISTRO EN TABLA PRESTAMOS 

-- INSERT INTO prestamos (articulo_id, socio_id, fecha_prestamo, fecha_tope) 
-- VALUES (1,15, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 10 DAY));

-- CONSULTO LA TABLA AUDITORIA PRESTAMOS
-- SELECT * FROM logs_prestamos;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------ 

-- TRIGGER DE ELIMINACION DE LOG_PRESTAMOS
USE biblioteca;

-- LOG DE INSERCION DE AUDITORIA DE ELIMINACION DE PRESTAMOS. DEFINIENDO LA ACCION, USUARIO, DETALLE, FECHA ACTUAL

DELIMITER $$
CREATE TRIGGER Log_before_delete_prestamos
BEFORE DELETE ON PRESTAMOS
FOR EACH ROW
BEGIN
INSERT INTO logs_prestamos(accion, usuario, detalle, fecha)
VALUES ('DELETE', SYSTEM_USER(), CONCAT('se elimino el prestamo con Id  ', OLD.id), NOW());

END $$
DELIMITER ;


-- PRUEBA DE TRIGGER
-- ELIMINACION MANUALMENTE DE UN REGISTRO EN TABLA PRESTAMOS 

-- DELETE FROM prestamos where socio_id = 15 and fecha_prestamo = curdate()

-- CONSULTO LA TABLA AUDITORIA PRESTAMOS
-- SELECT * FROM logs_prestamos;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- DCL -- PERMISOS
USE biblioteca;

-- CREO MIS DOS USUARIOS
CREATE USER usuarioLectura@localhost IDENTIFIED BY '1234';
CREATE USER usuarioConPermisos@localhost IDENTIFIED BY '12345';

-- VERIFICO QUE EXISTAN
SELECT * FROM mysql.user WHERE user = 'usuarioLectura';
SELECT * FROM mysql.user WHERE user = 'usuarioConPermisos';


-- ASIGNO PERMISOS A CADA UNO DE ELLOS

-- PERMISOS DE SOLO LECTURA PARA usuarioLectura
GRANT SELECT ON biblioteca.articulos TO usuarioLectura@localhost;
GRANT SELECT ON biblioteca.autores TO usuarioLectura@localhost;
GRANT SELECT ON biblioteca.deterioros TO usuarioLectura@localhost;
GRANT SELECT ON biblioteca.prestamos TO usuarioLectura@localhost;
GRANT SELECT ON biblioteca.socios TO usuarioLectura@localhost;

-- VERIFICIO LOS PERMISOS OTORGADOS
SHOW GRANTS FOR usuarioLectura@localhost;


-- PERMISOS DE LECTURA, INSERT Y UPDATE PARA usuarioConPermisos

GRANT SELECT, UPDATE, INSERT ON biblioteca.articulos TO usuarioConPermisos@localhost;
GRANT SELECT, UPDATE, INSERT ON biblioteca.autores TO usuarioConPermisos@localhost;
GRANT SELECT, UPDATE, INSERT ON biblioteca.deterioros TO usuarioConPermisos@localhost;
GRANT SELECT, UPDATE, INSERT ON biblioteca.prestamos TO usuarioConPermisos@localhost;
GRANT SELECT, UPDATE, INSERT ON biblioteca.articulos TO usuarioConPermisos@localhost;

-- VERIFICIO LOS PERMISOS OTORGADOS
SHOW GRANTS FOR usuarioConPermisos@localhost;


-- ------------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- TCL -- TRANSACCIONES

use biblioteca;
-- CONSULTO EL AUTOCOMMIT EN QUE ESTADO ESTA
SELECT @@autocommit;

-- ACTUALIZO SU ESTADO
SET @@autocommit = FALSE; SET @@autocommit = 0;

-- 1 ) ELIMINACION DE REGISTROS , REVERSION CON ROLLBACK, ACTUALIZACION CON COMMIT 
   
START TRANSACTION;
    DELETE FROM biblioteca.logs_prestamos where id = 1;
    DELETE FROM biblioteca.logs_prestamos where id = 2;
    
-- VALIDAR EL REVERSION    
ROLLBACK ;

-- APLICAR LA TRANSACCION 
COMMIT;

-- CONSULTO LA TABLA LOG PRESTAMOS
SELECT * FROM biblioteca.logs_prestamos; 




-- 2 )  INSERCION DE REGISTRACION TRANSACCIONALES CON SAVEPOINT, REVERSION DE SAVEPOINT
START TRANSACTION;
INSERT INTO biblioteca.logs_prestamos (id,accion,usuario, detalle, fecha) VALUES 
(NULL, 'INSERT', 'root@localhost', 'Se Inserto el prestamo65para el socio15', '2023-01-12 14:00:22');
INSERT INTO biblioteca.logs_prestamos (id,accion,usuario, detalle, fecha) VALUES 
(NULL, 'INSERT', 'root@localhost', 'Se Inserto el prestamo65para el socio15', '2023-01-12 14:00:22');
INSERT INTO biblioteca.logs_prestamos (id,accion,usuario, detalle, fecha) VALUES 
(NULL, 'INSERT', 'root@localhost', 'Se Inserto el prestamo65para el socio15', '2023-01-12 14:00:22');
INSERT INTO biblioteca.logs_prestamos (id,accion,usuario, detalle, fecha) VALUES 
(NULL, 'INSERT', 'root@localhost', 'Se Inserto el prestamo65para el socio15', '2023-01-12 14:00:22');
INSERT INTO biblioteca.logs_prestamos (id,accion,usuario, detalle, fecha) VALUES 
(NULL, 'INSERT', 'root@localhost', 'Se Inserto el prestamo65para el socio15', '2023-01-12 14:00:22');
INSERT INTO biblioteca.logs_prestamos (id,accion,usuario, detalle, fecha) VALUES 
(NULL, 'INSERT', 'root@localhost', 'Se Inserto el prestamo65para el socio15', '2023-01-12 14:00:22');
SAVEPOINT ACTUALIZACION1;

INSERT INTO biblioteca.logs_prestamos (id,accion,usuario, detalle, fecha) VALUES 
(NULL, 'INSERT', 'root@localhost', 'Se Inserto el prestamo65para el socio15', '2023-01-12 14:00:22');
INSERT INTO biblioteca.logs_prestamos (id,accion,usuario, detalle, fecha) VALUES 
(NULL, 'INSERT', 'root@localhost', 'Se Inserto el prestamo65para el socio15', '2023-01-12 14:00:22');
INSERT INTO biblioteca.logs_prestamos (id,accion,usuario, detalle, fecha) VALUES 
(NULL, 'INSERT', 'root@localhost', 'Se Inserto el prestamo65para el socio15', '2023-01-12 14:00:22');
SAVEPOINT ACTUALIZACION2;

ROLLBACK TO ACTUALIZACION1;

-- PRUEBA
-- SELECT * FROM biblioteca.logs_prestamos; 
