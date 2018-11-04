-- criando função
delimiter //
create function simula_aumento(salario decimal(10,2),pct decimal(10,2))
RETURNS DECIMAL(10,2)
	BEGIN
		RETURN salario + salario * pct /100;
	END //
delimiter ; -- forcando o delimeter padrão;

-- invocando a função

SELECT simula_aumento(1550.50,7.8);
