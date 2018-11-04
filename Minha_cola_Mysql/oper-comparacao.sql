-- select * from senso

-- usando operador =

	SELECt * FROM senso
	WHERE cod_uf ='35'
   and ano='2014';
   
-- usando operador =

	SELECT * FROM   senso 
	WHERE nome_mun = 'Dourado'      
	AND cod_uf = '35'
   and ano='2014';
   
-- usando o operador >

	SELECT * FROM   senso 
	WHERE  populacao > 100000
	and ano='2014';


-- Usando operador > 
	SELECT * FROM   senso 
	WHERE  populacao > 1000000
	and cod_uf='35'
   and ano='2014';
   
   
   -- Usando operador < 
	SELECT * FROM   senso 
	WHERE  populacao < 10000
   and ano='2014'; 
   
   -- Usando operador < 
	SELECT * FROM   senso 
	WHERE  populacao < 50000
   and ano='2014';
   
   
   -- Usando operador <= 
	SELECT * FROM   senso 
	WHERE  populacao <= 10000
    and ano='2014';
    
    
    -- Usando operador <=
    SELECT * FROM   senso 
		WHERE  populacao <= 50000
   	and ano='2014';
   	
   -- Usando operador <> 
	SELECT * FROM   senso 
	WHERE  cod_uf <> '35'        
	AND cod_uf <> '14'
	and ano='2014';
	
	
	   -- Usando operador = 
	SELECT * FROM   senso 
	WHERE  (cod_uf = '35' or cod_uf = '14')
	and ano='2014';
	
	
	-- Combinando operadores 
	SELECT * FROM   senso 
	WHERE  populacao <= 100000        
		AND populacao >= 50000        
		AND cod_uf = '35'        
		AND nome_mun <> 'Vinhedo'
        and ano='2014';
        
        
   	-- Combinando operadores 
	SELECT * FROM   senso 
	WHERE  populacao <= 100000        
		AND populacao >= 50000        
		AND cod_uf = '35'        
		AND nome_mun = 'Vinhedo'
        and ano='2014';

	
	
	
   
   
