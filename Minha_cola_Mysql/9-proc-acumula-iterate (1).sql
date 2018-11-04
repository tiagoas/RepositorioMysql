/*ITERATE significa: dentro de uma estrutura de repetição “inicie o loop novamente;
A declaração ITERATE aparece apenas dentro de estruturas LOOP, REPEAT E WHILE;
*/

delimiter //
create procedure proc_mod_par (teto int)
main: begin
	declare contador int default 0;
    enquanto_par: while contador<teto do
		set contador=contador+1;
		-- resultado sera 0 ou 1,zero imprimi ,1 retorna ao inicio
        if MOD(contador,2) then
				iterate enquanto_par;
		  end if;
        select concat(contador,' é um numero par, resultado mod ',MOD(contador,2)) as valor;
	end while;
end //
delimiter ;

call proc_mod_par(15);

-- drop procedure proc_mod_par

