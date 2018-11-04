-- exemplo proc soma valores
-- drop procedure proc_acumula;
DELIMITER //
create procedure proc_acumula(valor_teto int)
	main: begin
		  declare contador int default 0;
        declare soma int default 0;
   -- testando valor menor que 1
	IF valor_teto<1 THEN
		SELECT 'O VALOR DEVE SER MAIOR QUE ZERO' AS ERRO;
   LEAVE main;
	END IF;
	REPEAT
		  set contador=contador+1;
        set soma=soma+contador;
	UNTIL contador = valor_teto 
	END REPEAT;
    SELECT SOMA;
end//
DELIMITER ;

call proc_acumula(-2);

