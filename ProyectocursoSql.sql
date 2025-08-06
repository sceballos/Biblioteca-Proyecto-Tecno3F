-- Entrega 1 --
CREATE DATABASE bibliotecaProyecto;
use bibliotecaProyecto;

CREATE TABLE autores(
ID_autor INT AUTO_INCREMENT PRIMARY KEY,
Nombre VARCHAR(50) NOT NULL
);
CREATE TABLE generos(
ID_genero INT auto_increment PRIMARY KEY,
Genero VARCHAR(50) NOT NULL
);
CREATE TABLE pais(
ID_pais INT AUTO_INCREMENT PRIMARY KEY,
pais VARCHAR(50) NOT NULL
);
CREATE TABLE editorial(
ID_editorial INT AUTO_INCREMENT PRIMARY KEY,
editorial VARCHAR(50)
);
CREATE TABLE multas(
ID_multa int auto_increment PRIMARY KEY,
monto INT NOT NULL
);
CREATE TABLE Libros(
ID_Libro INT auto_increment PRIMARY KEY,
Titulo VARCHAR(100),
ID_genero INT NOT NULL,
anioPublicacion INT,
ID_editorial INT NOT NULL,
Disponibilidad ENUM("Disponible","Prestado") DEFAULT "Disponible",
FOREIGN KEY (ID_genero) REFERENCES generos(ID_genero),
FOREIGN KEY (ID_editorial) REFERENCES editorial(ID_editorial)
);
-- DROP TABLE if exists Libros;

CREATE TABLE Usuarios(
ID_usuario INT auto_increment PRIMARY KEY,
Nombre VARCHAR (50),
Apellido VARCHAR(50),
DNI CHAR(10) UNIQUE NOT NULL,
Email VARCHAR(50) UNIQUE NOT NULL,
Telefono VARCHAR(20),
Direccion VARCHAR(40),
FechaRegistro DATE DEFAULT(current_date),
Estado ENUM("Activo","Inactivo")Default "Activo"
);

CREATE TABLE Prestamos(
ID_prestamo int auto_increment PRIMARY KEY,
ID_usuario int,
fechaDePrestamo DATE,
fechaDeDevolucion DATE,
FOREIGN KEY (ID_usuario) REFERENCES usuarios(ID_usuario)
);
CREATE TABLE detalle_prestamo(
ID_detallePrestamo int auto_increment PRIMARY KEY,
ID_prestamo int,
ID_libro int,
cantidad int,
FOREIGN KEY(ID_prestamo) REFERENCES Prestamos(ID_prestamo),
FOREIGN KEY(ID_libro) REFERENCES libros(ID_libro)
);
CREATE TABLE Prestamo_multas(
ID_PrestamoMulta INT auto_increment PRIMARY KEY,
ID_prestamo int, 
ID_multa int,
FOREIGN KEY (ID_prestamo) REFERENCES Prestamos(ID_prestamo),
FOREIGN KEY (ID_multa) REFERENCES multas(ID_multa)
);

ALTER TABLE libros 
ADD column ID_pais INT,
ADD constraint fk_pais
FOREIGN KEY (ID_pais) REFERENCES pais(ID_pais);

ALTER TABLE libros
ADD COLUMN ID_autor INT,
ADD constraint fk_autor
FOREIGN KEY(ID_autor) REFERENCES autores(ID_autor);

/*DROP TABLE if exists prestamos;
DROP TABLE IF exists multas;
*/
ALTER TABLE Libros
MODIFY COLUMN anioPublicacion INT;


-- Entrega 2 -- 

use bibliotecaproyecto;

-- 1. Insertar autores (10 ejemplos)
INSERT INTO autores (Nombre) VALUES
('Gabriel García Márquez'),
('J.K. Rowling'),
('Julio Cortázar'),
('Jane Austen'),
('George Orwell'),
('Isabel Allende'),
('Mario Vargas Llosa'),
('Stephen King'),
('Agatha Christie'),
('Haruki Murakami');

-- 2. Insertar géneros 
INSERT INTO generos (Genero) VALUES
('Realismo mágico'),
('Fantasía'),
('Literatura clásica'),
('Ciencia ficción'),
('Terror'),
('Misterio');

-- 3. Insertar países
INSERT INTO pais (pais) VALUES
('Colombia'),
('Reino Unido'),
('Argentina'),
('Estados Unidos'),
('Japón');

-- 4. Insertar editoriales
INSERT INTO editorial (editorial) VALUES
('Penguin Random House'),
('Salamandra'),
('Alfaguara'),
('Debolsillo'),
('Tusquets');

-- 5. Insertar libros 
INSERT INTO Libros (Titulo, ID_genero, anioPublicacion, ID_editorial, ID_pais, ID_autor, Disponibilidad) VALUES
('Cien años de soledad', 1, 1967, 3, 1, 1, 'Disponible'),
('Harry Potter y la piedra filosofal', 2, 1997, 2, 2, 2, 'Prestado'),
('Rayuela', 3, 1963, 3, 3, 3, 'Disponible'),
('1984', 4, 1949, 4, 4, 5, 'Disponible'),
('La casa de los espíritus', 1, 1982, 3, 1, 6, 'Prestado'),
('Orgullo y prejuicio', 3, 1813, 1, 2, 4, 'Disponible'),
('It', 5, 1986, 1, 4, 8, 'Disponible'),
('Asesinato en el Orient Express', 6, 1934, 4, 2, 9, 'Prestado'),
('Kafka en la orilla', 1, 2002, 5, 5, 10, 'Disponible'),
('El amor en los tiempos del cólera', 1, 1985, 3, 1, 1, 'Disponible'),
('Los juegos del hambre', 4, 2008, 2, 4, 2, 'Prestado'),
('Crónica de una muerte anunciada', 1, 1981, 3, 1, 1, 'Disponible'),
('El resplandor', 5, 1977, 1, 4, 8, 'Prestado'),
('Tokio blues', 3, 1987, 5, 5, 10, 'Disponible'),
('La ciudad y los perros', 3, 1963, 3, 1, 7, 'Disponible');

SELECT * from bibliotecaproyecto.autores;
SELECT * from bibliotecaproyecto.libros;
SELECT * from bibliotecaproyecto.generos;
SELECT * from bibliotecaproyecto.editorial;
SELECT * from bibliotecaproyecto.pais;

SELECT * from usuarios;
SELECT * FROM multas;
SELECT * FROM prestamos;
SELECT * FROM detalle_prestamo;
SELECT * from prestamo_multas;


/* CREO LAS VISTAS */
CREATE VIEW usuariosConMultas as 
SELECT u.ID_usuario, u.Nombre, u.Apellido,SUM(m.monto) as "monto total"
FROM Usuarios u
INNER JOIN Prestamos p ON u.ID_usuario = p.ID_usuario
INNER JOIN prestamo_multas pm ON p.ID_prestamo=pm.ID_prestamo
INNER JOIN multas m ON pm.ID_multa=m.ID_multa
GROUP BY u.id_Usuario, u.Nombre, u.Apellido
ORDER BY id_usuario ASC;

CREATE VIEW editorialDeLosLibros AS
SELECT l.Titulo,e.editorial,l.anioPublicacion as "año publicado"
FROM libros l 
INNER JOIN editorial e ON e.ID_editorial = l.ID_editorial; 

CREATE VIEW infoDeLibro as 
SELECT l.Titulo,g.Genero,a.Nombre as "Autor"
FROM libros l INNER JOIN generos g ON g.ID_genero=l.ID_genero
INNER JOIN autores a ON l.ID_autor = a.ID_autor;

CREATE VIEW DetalleDelPrestamo as
SELECT 
  l.Titulo,
  u.Nombre,
  u.Apellido,
  p.ID_prestamo,
  p.fechaDePrestamo
FROM detalle_prestamo dp
INNER JOIN Libros l ON dp.ID_libro = l.ID_Libro
INNER JOIN Prestamos p ON dp.ID_prestamo = p.ID_prestamo
INNER JOIN Usuarios u ON p.ID_usuario = u.ID_usuario;




SELECT * FROM detalledelprestamo;







-- Entrega 3 --

/*---------PROCEDIMIENTOS------------*/
DELIMITER $$
CREATE PROCEDURE cargarLibro(
IN tituloNuevo VARCHAR(100),
IN ID_generoNuevo INT, 
IN anioNuevo INT,
IN editorialNuevo INT,
IN paisNuevo INT, 
IN idAutor INT )
BEGIN 
	DECLARE EXIT HANDLER  FOR SQLEXCEPTION 
    BEGIN 
    ROLLBACK;
    SELECT "ERROR, ingreso de datos incorrectos" as mensaje;
    END;
	
    START TRANSACTION;
    
    INSERT INTO libros (
    Titulo, ID_genero, anioPublicacion, ID_editorial, ID_pais, ID_autor, Disponibilidad
    )
    VALUES (
    tituloNuevo,ID_generoNuevo,anioNuevo,editorialNuevo,paisNuevo,idAutor,'Disponible'
	);
      COMMIT;
  SELECT 'Libro insertado correctamente.' AS Mensaje;
END$$
DELIMITER ;


CALL cargarLibro(
'El libro hecho aproposito para fallar', 1,1943,2,20,19);

CALL cargarLibro( 
'Rebelion en la granja',2,1945,11,2,5);

SELECT * FROM Libros;
SELECT * FROM generos;
SELECT * FROM autores;
SELECT * FROM usuarios;


UPDATE usuarios
SET Estado = 'Inactivo'
WHERE ID_usuario = 67;

SELECT * FROM historial_estado_usuario;
DELIMITER $$


DELETE FROM Libros
WHERE ID_Libro = 9;  


CREATE PROCEDURE registrarEditorial(
  IN p_editorial VARCHAR(50)
)
BEGIN
  DECLARE v_existe INT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    SELECT '❌ Error al registrar la editorial.' AS Mensaje;
  END;

  SELECT COUNT(*) INTO v_existe
  FROM editorial
  WHERE editorial = p_editorial;

  IF v_existe = 0 THEN
    START TRANSACTION;

    INSERT INTO editorial (editorial)
    VALUES (p_editorial);

    COMMIT;
    SELECT 'Editorial registrada exitosamente.' AS Mensaje;
  ELSE
    SELECT 'La editorial ya existe. No se realizo la insercion.' AS Mensaje;
  END IF;
END$$

DELIMITER ;
-- DROP PROCEDURE registrarEditorial;
SELECT * FROM editorial;
CALL registrarEditorial ("Salamandra");  




/*-----------TRIGGERS-------------*/

CREATE TABLE historial_estado_usuario 
(
  ID INT AUTO_INCREMENT PRIMARY KEY,
  ID_usuario INT,
  EstadoAnterior VARCHAR(20),
  EstadoNuevo VARCHAR(20)
);

DELIMITER %%
CREATE TRIGGER after_update_usuario 
AFTER UPDATE ON usuarios 
FOR EACH ROW 
	BEGIN 
    IF OLD.Estado != NEW.Estado then 
    INSERT INTO historial_estado_usuario (ID_usuario, EstadoAnterior, EstadoNuevo)
    VALUES (OLD.ID_usuario, OLD.Estado, NEW.Estado);
	END IF;
END %% ;
DELIMITER ; 

DELIMITER $$
CREATE TRIGGER before_delete_libro
BEFORE DELETE ON Libros
FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT * FROM detalle_prestamo WHERE ID_libro = OLD.ID_Libro
  ) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No se puede eliminar: el libro tiene prestamos registrados.';
  END IF;
END $$ 

UPDATE Libros
SET Titulo = UPPER(Titulo);


DELIMITER $$ 
CREATE TRIGGER convertir_titulo_mayus
BEFORE INSERT ON Libros 
FOR EACH ROW
BEGIN 
	SET New.Titulo = UPPER(NEW.Titulo); 
END; 

/*---------- FUNCIONES -------------*/

DELIMITER $$ 
CREATE FUNCTION sumarMultasDeUsuario (idUsuario INT) 
RETURNS INT 
deterministic 
	BEGIN 
		DECLARE multaTotal INT; 
        
		SELECT SUM(m.monto) INTO multaTotal 
        FROM prestamos p 
        INNER JOIN prestamo_multas pm on p.ID_prestamo = pm.ID_prestamo 
        INNER JOIN multas m on pm.ID_multa = m.ID_multa 
        WHERE p.ID_usuario = idUsuario;
        
        RETURN multaTotal; 
	END $$ 
    
DELIMITER $$
CREATE FUNCTION cantDeVecesPrestado (idLibro INT)
 RETURNS INT 
 DETERMINISTIC 
	BEGIN 
		DECLARE cantTotal INT; 
        /*SET cantTotal=0;*/
        
        SELECT COUNT(*) INTO cantTotal 
        FROM detalle_prestamo dp 
        INNER JOIN libros l on dp.ID_libro = l.ID_Libro
        WHERE l.ID_Libro = idLibro;
        
        RETURN cantTotal;
	END$$
        
SELECT sumarMultasDeUsuario(1) AS MultaTotal;

SELECT cantDeVecesPrestado(3) as VecesPrestado;  


