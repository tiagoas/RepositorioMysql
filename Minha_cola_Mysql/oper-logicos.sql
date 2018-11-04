	

	-- OPERADOR WHERE
	SELECT *
	FROM senso
	WHERE nome_mun='Jundiai'
	and ano='2014';
	

	-- OPERADOR AND
	SELECT *
	FROM senso
	WHERE cod_uf='35' 
	AND populacao >50000
	and ano='2014';
	
	
	-- OPERADOR BETWEEN
	select * from senso 
	where cod_uf='35' 
	and populacao between 5000 and 10000
	and ano='2014'
	order by populacao desc; 
	
	
	-- OPERADOR IN
	select * from senso
	where cod_uf in ('35','12')
	and ano='2014';
		
		
	-- OPERADOR NOT IN
	select * from senso
	where cod_uf not in ('35','12')
	and ano='2014';
	

	-- LIKE LOCALIZA VALORES QUE CONTENHAM "OR" EM QUALQUER LUGAR
	select * from senso
	where nome_mun like ('%or%')
	and ano='2014';
	
	
	-- LIKE Encontra quaisquer valores que tenham "r" na segunda posição
	select * from senso
	where nome_mun like '_r%'
	and ano='2014';
		

	-- LIKE Localiza valores que começam com "a" e possuem pelo menos 3 caracteres de comprimento
		select * from senso
	where nome_mun like 'a_%_%'
	and ano='2014';
	
			

	-- LIKE Localiza valores que começam com "a" e termina com "o"
			select * from senso
			where nome_mun like 'a%o'
			and ano='2014';
	

	-- LIKE Localiza valores que começam com "a"
	
		select * from senso
			where nome_mun like 'a%'
			and ano='2014';

		
	-- OPERADOR LIKE CORINGA __
		
		select * from senso
			where nome_mun like '_ra%'
			and ano='2014';
	
	-- OPERADOR NOT
	
	select ano,cod_uf,estado,nome_mun,populacao from senso
	where nome_mun not like ('A%')
	and cod_uf='35'
	and not populacao<40000
	and ano='2014';
	
	
	select ano,cod_uf,estado,nome_mun,populacao from senso
	where nome_mun not like ('A%')
	and cod_uf='35'
	and not populacao>40000
	and ano='2014';
	
	-- OPERADOR OR
	
	select * from senso
	where nome_mun like ('A%')
	and (cod_uf='35' or cod_uf='15');
	
-- evidencia de erro	
	select * from senso
	where nome_mun like ('A%')
	and cod_uf='35' 
	and cod_uf='15';
	
  
	-- OPERADOR IS NOT NULL
	select * from senso
	where regiao is not null;


	-- OPERADOR IS NULL
	select * from senso
	where regiao is null;

-- preparando cenario is null
  select * from senso
  where regiao='';
  
  update senso set regiao=null
  where regiao=''; 
  
  update senso set regiao=''
  where regiao is null; 

	
	

	-- OPERADOR HAVING
	select cod_uf,estado,count(*)qtd
	from senso
	where ano='2014'
	group by cod_uf,estado having count(cod_mun)>500;


	-- OPERADOR HAVING
	select cod_uf,estado,count(*)qtd
	from senso
	where ano='2014'
	group by cod_uf,estado having count(cod_mun)<500;


	-- OPERADOR HAVING
	
	select cod_uf,estado,count(cod_mun)qtd,
	              sum(populacao)
	from senso
	where ano='2014'
	group by cod_uf,estado having sum(populacao)>5000000;
	
	
	-- OPERADOR HAVING
	
	select cod_uf,estado,count(cod_mun)qtd,
	              sum(populacao)
	from senso
	where ano='2014'
	group by cod_uf,estado having sum(populacao)<5000000;
	
	
	
	
