-- exemplo proc REPEAT tabuada
-- drop procedure proc_tabuada_r
DELIMITER //
create procedure proc_tabuada_r(tabuada int)
	begin
		declare contador int default 0;
      declare resultado int default 0;
	REPEAT
		set contador=contador+1;
      set resultado=tabuada*contador;
      select concat(tabuada,' x ',contador,' = ',resultado) as resultado;
	UNTIL contador > 9 
	END REPEAT;		
end//
DELIMITER ;

call proc_tabuada_r(6);