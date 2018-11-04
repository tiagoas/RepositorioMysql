-- exemplo proc 
-- drop procedure proc_acumula_iterate
DELIMITER //
create procedure proc_acumula_iterate(valor_teto int)
	main: begin
		  declare contador int default 0;
        declare soma int default 0;
	   IF valor_teto<1 THEN
		  SELECT 'O VALOR DEVE SER MAIOR QUE ZERO' AS ERRO;
        LEAVE main;
	   END IF;
    teste:loop
		  set contador=contador+1;
        set soma=soma+contador;
	if contador<valor_teto then
		iterate teste;
	end if;
    leave teste;
end loop teste;
 -- imprimindo resultado
    SELECT SOMA;
end//
DELIMITER;

call proc_acumula_iterate(7);