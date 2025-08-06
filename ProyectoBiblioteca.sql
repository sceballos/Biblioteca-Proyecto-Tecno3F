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
DROP TABLE if exists Libros;

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

DROP TABLE if exists prestamos;
DROP TABLE IF exists multas;

ALTER TABLE Libros
MODIFY COLUMN anioPublicacion INT;
