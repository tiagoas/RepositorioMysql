-- exemplo proc loop tabuada
-- drop procedure proc_tabuada
delimiter //
create procedure proc_tabuada_l(tabuada int)
	begin
		declare contador int default 0;
      declare resultado int default 0;
	loop_tabuada: loop
		  set contador=contador+1;
        set resultado=tabuada*contador;
        select concat(tabuada,' x ',contador,' = ',resultado);
        if contador > 9 then
          leave loop_tabuada;
		  end if;
	end loop loop_tabuada;
end//
delimiter;

call proc_tabuada_l(5);