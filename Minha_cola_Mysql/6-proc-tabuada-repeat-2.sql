-- exemplo proc REPEAT tabuada
-- drop procedure proc_tabuada_r_t
DELIMITER //
create procedure proc_tabuada_r_t(tabuada int)
	begin
		declare contador int default 0;
      declare resultado int default 0;
      create temporary table temp_tab (res varchar(50));
	REPEAT
		set contador=contador+1;
      set resultado=tabuada*contador;
      -- realizando select com insert
      insert into temp_tab
      select concat(tabuada,' x ',contador,' = ',resultado) as resultado;
	UNTIL contador > 9 
	END REPEAT;	
	-- select para apresentar o valores
	select * from temp_tab;	
	-- dropar a tabela temp tab;
	drop temporary table temp_tab;
end//
DELIMITER ;

call proc_tabuada_r_t(7);