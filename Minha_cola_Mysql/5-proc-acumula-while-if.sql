
-- drop procedure proc_acumula_w
DELIMITER //
create procedure proc_acumula_w(valor_teto int)
	main: begin
		  declare contador int default 0;
        declare soma int default 0;
	IF valor_teto<1 THEN
		SELECT 'O VALOR DEVE SER MAIOR QUE ZERO' AS ERRO;
   LEAVE main;
	END IF;
	while contador < valor_teto do
		set contador=contador+1;
      set soma=soma+contador;
	END while;
    SELECT SOMA;
end//
DELIMITER ;

call proc_acumula_w(5);



-- teste 

DELIMITER //
create procedure proc_acumula_wt(valor_teto int)
	main: begin
		  declare contador int default 0;
        declare soma int default 0;
	IF valor_teto<1 THEN
		SELECT 'O VALOR DEVE SER MAIOR QUE ZERO' AS ERRO;
   LEAVE main;
	END IF;
	while contador < valor_teto do
		set contador=contador+1;
      set soma=soma+contador;
	END while;
    SELECT SOMA;
end//
DELIMITER ;

call proc_acumula_wt(-2)