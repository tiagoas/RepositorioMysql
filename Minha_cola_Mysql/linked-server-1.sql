--drop DATABASE TESTE_LINK
--CRIANDO DATABASE
CREATE DATABASE TESTE_LINK

USE TESTE_LINK

--ESTE BLOCO SERA CRIANDO NO SERVIDOR QUE SERA ACESSADO
--CRIANDO DATABASE

--CRIANDO TABELA

CREATE TABLE PESSOAS   
    (      
	  id   INT IDENTITY(1,1)  NOT NULL,      
	  nome VARCHAR(50) NULL,      
      CONSTRAINT pktable1 PRIMARY KEY CLUSTERED (id)   
     ) 
--INSERINDO VALORES
INSERT PESSOAS (nome) VALUES 
('joao eduardo'),  ('jeremias'), ('dante'), ('lucas'), ('luiz henrique')

--VERIFICAR O REGISTROS

SELECT * FROM PESSOAS

