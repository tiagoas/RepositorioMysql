--Retornar Boas Vindas para usuários logados
--drop PROCEDURE TESTE2
CREATE PROCEDURE proc_teste2
AS
BEGIN
SELECT 'Welcome'+' '+ SYSTEM_USER
END


--Executando Procedure
EXEC proc_teste2
