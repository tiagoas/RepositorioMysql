-- criando tabela  temporaria
CREATE TEMPORARY TABLE tmp_senso1
(
 id INT PRIMARY KEY AUTO_INCREMENT,
 cod_mun char(7),
 nome_mun VARCHAR(80)
)ENGINE=MEMORY;


-- inserindo dados tabela  temp
INSERT INTO tmp_senso1 (cod_mun,nome_mun)
SELECT cod_mun,nome_mun FROM senso;


-- selecionando dados tabela temp
SELECT * FROM tmp_senso1;

-- criando temp atraves de select
CREATE TEMPORARY TABLE tmp_senso2 
SELECT * FROM senso;


EXPLAIN tmp_senso1;
EXPLAIN tmp_senso2;
EXPLAIN senso;

-- dropando a tabela temporaria
drop TEMPORARY TABLE tmp_senso1;

select * from  tmp_senso1

select * from tmp_senso2;
