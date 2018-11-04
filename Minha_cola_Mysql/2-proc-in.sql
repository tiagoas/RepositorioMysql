-- exemplo com parametro in 

delimiter //
CREATE PROCEDURE proc_cidades_uf (IN p_uf VARCHAR(2))
	BEGIN
	 SELECT DISTINCT nome_mun,populacao,cod_uf
		FROM senso
		WHERE cod_uf=p_uf;
	END//
delimiter;
-- invocando a procedure
CALL proc_cidades_uf(35);


-- invocando a procedure com variavel
SET @var_uf='13'; 
CALL proc_cidades_uf(@var_uf);

-- drop procedure proc_cidades_uf

-- criando base para procedure
CREATE TABLE MATERIAL(
  COD_MAT INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  NOME VARCHAR(50) NOT NULL,
  CUSTO DECIMAL(10,2) NOT NULL
  );
  
INSERT INTO MATERIAL (NOME,CUSTO) VALUES ('XBOX','1500'),('SMART TV 42','2200'),
										 ('NOTEBOOK','3900'),('SMARTPHONE','2350');

CREATE TABLE ESTOQUE(
  COD_MAT INT NOT NULL,
  QTD int NOT NULL,
  foreign key (COD_MAT) references MATERIAL(COD_MAT)
  );

  INSERT INTO ESTOQUE (COD_MAT, QTD) VALUES (1,12);
  INSERT INTO ESTOQUE (COD_MAT, QTD) VALUES (2,29);
  INSERT INTO ESTOQUE (COD_MAT, QTD) VALUES (3,33);
  INSERT INTO ESTOQUE (COD_MAT, QTD) VALUES (4,54);
  -- TESTANDO FK
 INSERT INTO ESTOQUE (COD_MAT, QTD) VALUES (5,54);

-- criando base de dados

-- proc atualiza preco custo em pct

delimiter //
CREATE PROCEDURE proc_ajusta_custo(IN p_cod_mat INT,taxa DECIMAL(10,2)) 
	BEGIN
		UPDATE material SET custo=custo+custo*taxa/100
		WHERE cod_mat=p_cod_mat; 
	END //
delimiter ; 

CALL proc_ajusta_custo(2,7);

select * from material;
-- drop procedure proc_ajusta_custo
-- 2200.00
-- 2354.00
