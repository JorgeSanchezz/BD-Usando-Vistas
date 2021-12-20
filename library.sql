drop database library;
create database library;
	use library;

create table editorial (
		idEditorial int(4) auto_increment primary key not null,
		nombre varchar(35)
);
create table idioma (
		idIdioma int(4) auto_increment primary key not null,
		nombre varchar(35)
);
create table carrera (
	idCarrera int(4) auto_increment primary key not null,
	nombre varchar(35)
);
create table autor (
		idAutor int(4) auto_increment primary key not null,
		nombre varchar(35)
);
create table lector (
		idLector int(4) auto_increment primary key not null,
		nombre varchar(35),
		idCarrera int(4), FOREIGN KEY (idCarrera) REFERENCES carrera (idCarrera)
);
create table libro (
		idLibro int(4) auto_increment primary key not null,
		titulo varchar(35),
		idAutor int(4), FOREIGN KEY (idAutor) REFERENCES autor (idAutor),
		idEditorial int(4), FOREIGN KEY (idEditorial) REFERENCES editorial (idEditorial),
		idIdioma int(4), FOREIGN KEY (idIdioma) REFERENCES idioma (idIdioma)
);
create table prestamo (
		idPrestamo int(4) auto_increment primary key not null,
		fecha_prestamo date,
		idLibro int(4), FOREIGN KEY (idLibro) REFERENCES libro (idLibro),
		idLector int(4), FOREIGN KEY (idLector) REFERENCES lector (idLector),
		fecha_devolucion date,
		observaciones text
);

INSERT INTO editorial VALUES (null,"Porrua"),(null,"Mc Graw-Hill"),(null,"Planeta");
INSERT INTO idioma VALUES (null,"Espanol"),(null,"Frances"),(null,"Ingles");
INSERT INTO carrera VALUES (null,"Mecanica"),(null,"Administracion"),(null,"Arquitectura"),(null,"Gastronomia"),(null,"Veterinaria");
INSERT INTO autor VALUES (null,"Joyanes"),(null,"Grossman"),(null,"Barragan");
INSERT INTO lector VALUES (null,"Benjamin Sanchez",1),(null,"Agustin Soto",3),(null,"Fernanda Castro",4);
INSERT INTO libro VALUES (null,"Motores Hibridos",2,1,1),(null,"Cocina Tai",1,3,3),(null,"Construccion y Diseno",3,2,2);
INSERT INTO prestamo VALUES (null,"2018/08/15",1,1,"2018/08/22","ninguna"),(null,"2018/08/16",2,2,"2018/08/20","libro roto");

CREATE VIEW vw1 AS
SELECT * FROM libro AS l;
SELECT * FROM vw1;

CREATE VIEW vw2 AS 
SELECT l.titulo AS libro
FROM libro AS l, prestamo AS p, Idioma AS i
WHERE l.idLibro = p.idLibro
AND p.idPrestamo = p.idLibro
AND l.idLibro = i.idIdioma
AND i.idIdioma=3;
SELECT * FROM vw2;

CREATE VIEW vw3 AS 
SELECT le.nombre AS nombre
FROM lector AS le, prestamo AS p
WHERE p.idLibro = p.idPrestamo
AND p.idPrestamo = le.idLector
AND p.fecha_prestamo >5;
SELECT * FROM vw3;

CREATE VIEW vw4 AS
SELECT l.titulo AS libro, e.nombre AS editorial, i.nombre AS idioma, a.nombre AS autor
FROM libro AS l, editorial AS e, idioma AS i, autor AS a, prestamo AS p
WHERE l.idLibro = p.idLibro
AND a.idAutor = l.idLibro
AND i.idIdioma = l.idLibro
AND e.idEditorial = l.idLibro;
SELECT * FROM vw4;