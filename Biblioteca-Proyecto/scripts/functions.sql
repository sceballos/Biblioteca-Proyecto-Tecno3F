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

