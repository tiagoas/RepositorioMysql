
-- DDL CRIANDO TABELA
CREATE TABLE funcionario   
(		 matricula INT not null primary key auto_increment,      
	    nome      VARCHAR(50) NOT NULL,      
		 sobrenome VARCHAR(50) NOT NULL,      
		 endereco  VARCHAR(50),      
		 cidade    VARCHAR(50),      
		 pais      VARCHAR(25),      
		 data_nasc DATETIME	 
		);

-- DDL CRIANDO TABELA COM CHAVE ESTRANGEIRA
CREATE TABLE salario   
(      
	matricula INT not null,      
	salario   DECIMAL(10,2) NOT NULL, 
    FOREIGN KEY(matricula) REFERENCES funcionario(matricula)
  );

-
-- DDL CRIACAO DE TABELA COM CHAVE PRIMARIA
CREATE TABLE audit_salario   
	(  
		transacao int not null auto_increment,    
		matricula  INT NOT NULL,      
		data_trans DATETIME NOT NULL,      
		sal_antigo DECIMAL(10,2),      
		sal_novo   DECIMAL(10,2), 
		Usuario    varchar(20)not null,
		primary key(transacao),
		FOREIGN KEY(matricula) REFERENCES funcionario(matricula) 
		);

-- DDL CRIACAO DE INDEX
 CREATE INDEX ix_func1   ON funcionario(data_nasc);
 

-- DDL CRIACAO DE INDEX
 CREATE INDEX ix_func2   ON funcionario(cidade,pais);


 -- Adicionando novo campo na tabela 
ALTER TABLE funcionario ADD genero CHAR(1);
 
-- SELECT * FROM funcionario

 -- Renomeando campo/colunas da tabela
 alter table funcionario change genero sexo char(1);
 -- Retornando situacao anterior
 alter table funcionario change sexo genero char(1);

 
 -- Renomeando  tabela
 rename table funcionario to pessoa;
 --  retornando situaacao anterior
 rename table pessoa to funcionario;
 

-- DDL PARA ADICIONAR COLUNA NA TAB SENSO 
  ALTER TABLE SENSO ADD ID INT;


-- DDL PARA ADICIONAR CHAVE PRIMARIA NA TAB SENSO AUTO_INCREMENT 
ALTER TABLE SENSO MODIFY COLUMN ID INT AUTO_INCREMENT PRIMARY KEY;

-- SELECT * FROM SENSO;

-- Alterando tipo da coluna
ALTER TABLE funcionario MODIFY COLUMN endereco VARCHAR(30);

  
-- Excluindo campo da coluna
ALTER TABLE funcionario DROP COLUMN genero; 
 

  
-- alterar Engine da tabela
ALTER TABLE senso
ENGINE = MyIsam;

 
-- DDL CRIACAO DE DATABASE
CREATE DATABASE TESTE;


-- Excluindo database
DROP DATABASE TESTE; 


-- Excluindo table
DROP TABLE SALARIO


-- CRIACAO DE VIEW
CREATE VIEW v_funcionario
	AS
	SELECT * FROM FUNCIONARIOS



-- MODIFICANDO VIEW DE VIEW
-- ALTER VIEW
	ALTER VIEW v_funcionario
	AS 
	SELECT ID,NOME FROM FUNCIONARIOS;


-- 
-- Excluindo VIEW
DROP VIEW v_funcionario; 


-- Excluindo index
DROP index ix_func1 ON FUNCIONARIO; 


-- CRIANDO INDEX
CREATE INDEX IX_FUNC1 ON FUNCIONARIOS (NOME)


-- CRIANDO PROCEDURvE procedure
DELIMITER $$
CREATE PROCEDURE proc_quadrado (INOUT numero INT)
BEGIN
	SET numero = numero * numero;
END $$
DELIMITER ;


-- EXECUTANDO PROCEDURE
SET @valor = 5;
CALL proc_quadrado (@valor);
SELECT @valor;


-- EXCLUINDO PROCEDURE 
DROP PROCEDURE proc_quadrado; 


-- Excluindo Função
DROP function func_salario;


-- Excluindo Trigger
DROP trigger trig_func_salario;


-- DDL TRUNCATE
TRUNCATE TABLE	 SENSO;

-- DDL TRUNCATE VERIFICANDO REGISTROS

SELECT * FROM FUNCIONARIOS;


-- CRIANDO TABELA TEMPORARIA BK EM TABELA TEMPORARIA
CREATE TEMPORARY TABLE TMP_FUNCIONARIOS
(
 ID INT,
 NOME VARCHAR(50),
 SALARIO DECIMAL(10,2),
 SETOR VARCHAR(30)
 )


-- FAZENDO BK NA TABELAS TEMPORARIA
INSERT INTO TMP_FUNCIONARIOS
SELECT * FROM FUNCIONARIOS


-- VERIFACANDO BK NA TABELA TEMPORARIA
SELECT * FROM TMP_FUNCIONARIOS

 
-- TRUNCATE NA TABELA FUNCIONARIOS --APAGANDO REGISTROS
TRUNCATE FUNCIONARIOS;

SELECT * FROM FUNCIONARIOS;


-- RECUPERAR DADOS DA TABELA TEMP
-- DESATIVAR AUTO INCREMENT DA TABELA FUNCIONARIOS
ALTER TABLE FUNCIONARIOS CHANGE ID ID INT UNSIGNED NOT NULL;


-- RECUPERANDO DADOS DO BK TEMPORARIO
INSERT INTO FUNCIONARIOS
SELECT * FROM  TMP_FUNCIONARIOS

SELECT * FROM FUNCIONARIOS;

-- RETORNANDO AUTO INCREMENT
ALTER TABLE FUNCIONARIOS MODIFY COLUMN ID INT AUTO_INCREMENT;


-- TESTANDO AUTO INCREMENT
INSERT INTO funcionarios (nome,salario) VALUES ('Leopoldo',1000);

-- EVIDENCIA
SELECT * FROM funcionarios

