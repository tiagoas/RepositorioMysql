--Criando Banco de dados

--USE MASTER DROP DATABASE desastre
CREATE DATABASE  desastre
 ON  PRIMARY 
( 
  NAME = N'desastre_data', FILENAME = N'C:\Cursos\Database\Data\desastre.mdf' , 
  SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB 
  )
  LOG ON 
( NAME = N'desastre_log', FILENAME = N'C:\Cursos\Database\Log\desastre_log.ldf' , 
  SIZE = 1072KB , MAXSIZE = 2048MB , FILEGROWTH = 10%)

--SET BACKUP FULL
 ALTER DATABASE  desastre SET recovery full 
 
--Realiza backup 
BACKUP DATABASE desastre 
TO disk=N'C:\Cursos\Database\bk\desastre.bak' 
---Criando tabela 
USE DESASTRE
CREATE TABLE material ( cod_mat INT NOT NULL, desc_mar VARCHAR(30) ) 
--Populando tabela INSERT INTO material VALUES (1, ’papel’) 
INSERT INTO material VALUES (1,'lata') 
INSERT INTO material VALUES (2, 'cartao') 
INSERT INTO material VALUES (3, 'Lapis') 
INSERT INTO material VALUES (3, 'Caneta') 

--SELECT * FROM material

CHECKPOINT 

--Simulando a falha de disco e perda do arquivo de dados
/*
1.    Parar o serviço do SQL Sever;
2.    Mover o arquivo de dados (.mdf) para outro local e colocar em seu lugar 
      um arquivo texto zerado com a extensão .mdf;
3.    Carregar novamente o SQL Server;
      Após os procedimentos acima você deve acessar o SQL manager, você 
      irá verificar que o banco de dados Teste está marcado 
      como “Suspect” ou Recovering Pending. 
*/

--Recuperando o banco de dados

-- 1 COLOCAR DB EM EMERGENCY
ALTER DATABASE desastre SET EMERGENCY  
--2    Fazer um backup do log de transações mesmo o banco estando como suspect 
--(lembrando que o log de transações deve estar integro em outra unidade de disco);
--BACKUP DO ARQUIVO!!!!
--3.    Em alguns casos é necessário a exclusão do banco marcado como “Suspect”;
--4.    Restaurar o ultimo backup full;
--DROP DATABASE DESASTRE
  RESTORE DATABASE DESASTRE
  FROM disk=N'C:\Cursos\Database\bk\desastre.bak' 
  WITH RECOVERY ,REPLACE
  

--verifando base
SELECT * FROM MATERIAL