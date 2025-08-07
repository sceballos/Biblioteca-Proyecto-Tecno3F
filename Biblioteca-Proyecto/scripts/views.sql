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
