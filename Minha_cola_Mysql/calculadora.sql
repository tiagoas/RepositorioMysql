--Procedure para calculadora
--drop procedure calculadora
CREATE PROCEDURE calculadora @oper char(1),@num1 as decimal(10,2),@num2 as decimal(10,2)
AS
BEGIN
DECLARE @res decimal(10,2);
end

 IF @oper='A'
  BEGIN
	SET @res= @num1+@num2;
	PRINT 'OPERACAO ADICAO'
	PRINT @res
  END
 ELSE IF @oper='D'
  BEGIN
	SET @res= @num1/@num2;
	PRINT 'OPERACAO DIVISAO'
	PRINT @res
  END
  ELSE IF @oper='M'
  BEGIN
	SET @res= @num1*@num2;
	PRINT 'OPERACAO MULTIPLICACAO'
	PRINT @res
  END
  ELSE IF @oper='S'
  BEGIN
	SET @res= @num1-@num2;
	PRINT 'OPERACAO SUBTRACAO'
	PRINT @res
  END
	ELSE
	BEGIN
		PRINT 'OPERACAO NÃO EXISTE'
	END
--EXCUTANDO PROC CALCULADORA
--A ADICAO
--M MULTIPLICACAO
--D DIVISAO
--S SUBTRACAO

exec calculadora M,5,6