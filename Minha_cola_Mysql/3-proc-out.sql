delimiter //
create procedure proc_ajusta_custo_2(in p_cod_mat int,
                                     taxa decimal(10,2),
                                     out antes decimal(10,2))
	begin 
	     -- select com atribuição de valores
		  select custo into antes
        from material where cod_mat=p_cod_mat;
        -- update
		  update material set custo=custo+custo*taxa/100
        where cod_mat=p_cod_mat;
	end //
delimiter ;

call proc_ajusta_custo_2(2,7,@antes);
select @antes;


-- criando proc 2
delimiter //
create procedure proc_ajusta_custo_3(in p_cod_mat int,
                                     taxa decimal(10,2),
                                     out antes decimal(10,2),
                                     out depois decimal(10,2))
	begin 
	   -- select para atribuicao de valores
		select custo,custo+((custo*taxa)/100) as pos into antes,depois
        from material where cod_mat=p_cod_mat;
      -- update para efetivar a atualização
		update material set custo=custo+custo*taxa/100
      where cod_mat=p_cod_mat;
	end //
delimiter ;

call proc_ajusta_custo_3(2,7,@antes,@depois);
select @antes as antes,@depois as depois