--Procedure para calcular CUBO
CREATE PROCEDURE calc_cubo @PAR1 INT
AS
BEGIN
 
SELECT @PAR1*@PAR1*@PAR1 AS CUBO
END

--Executando Procedure
EXEC calc_cubo 5 
