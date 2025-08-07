
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


/* ACLARACION: LAS DEMAS TABLAS SE INGRESARON SUS DATOS MEDIANTE ARCHIVOS CSV */