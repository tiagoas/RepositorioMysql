DBCC HELP (?)
DBCC HELP (CHECKALLOC)
--Verifica a integridade l�gica e f�sica de todos os objetos do banco de 
--dados especificado com a execu��o das seguintes opera��es:
ALTER DATABASE CURSO SET SINGLE_USER  

--use curso

DBCC CHECKDB (curso)
DBCC CHECKDB (curso,REPAIR_FAST)
DBCC CHECKDB (curso,REPAIR_REBUILD)
DBCC CHECKDB (curso,REPAIR_ALLOW_DATA_LOSS)


--Verifica a integridade de todas as p�ginas e estruturas 
--que comp�em a tabela ou a exibi��o indexada
USE CURSO
DBCC CHECKTABLE (cidades)
--Inspeciona a integridade de uma restri��o especificada ou de todas as 
--restri��es em uma tabela especificada no banco de dados atual.

DBCC CHECKCONSTRAINTS

--Verifica a consist�ncia de estruturas de aloca��o de espa�o em disco
-- para um banco de dados especificado

DBCC CHECKALLOC

