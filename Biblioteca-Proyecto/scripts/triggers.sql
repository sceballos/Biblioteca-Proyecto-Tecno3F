
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
