-- Operador + 
	select 1+3 as retorno;
	
	-- Operador * 
	select 3*2  as retorno;
	

	-- Operador - 
	select 5-2  as retorno;
	
	select 2-5  as retorno;
	

	-- Operador / 
	select 15/3 as retorno
	 
	-- Operador % 
	select 12%5 as retorno;
	

 -- combinando operadores
	SELECT ((1+4)*(3*3))/5 as retorno;
	

	-- script projetando acrescimo de 10% populacao
	
		select nome_mun,populacao,
			 populacao*1.10 as pop_projecao		
			from senso
			where ano='2014';

	-- script projetando acrescimo de 10% populacao
		select nome_mun,populacao,
			 populacao*0.10 as acrescimo,
			 populacao+(populacao*0.10) projecao_pop
	from senso
	where ano='2014'

	

	-- script projetando decrescimo de 10% populacao
	select nome_mun,populacao,
			 populacao*0.10 as descrescimo,
			 populacao-(populacao*0.10) projecao_pop
	from senso
	where ano='2014';

	
	

	/*O exemplo a seguir divide o número 38 por 5. 
	Isto resulta em 7 como a parte inteira do resultado 
	e demonstra como o módulo retorna o resto de 3.
	*/
		    
   select 38/5 as divisao,
         38%5 as restante;