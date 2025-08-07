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
SELECT * FROM editorial;
CALL registrarEditorial ("Salamandra");  
