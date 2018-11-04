DBCC HELP (?)
DBCC HELP (CHECKALLOC)
--Verifica a integridade lógica e física de todos os objetos do banco de 
--dados especificado com a execução das seguintes operações:
ALTER DATABASE CURSO SET SINGLE_USER  

--use curso

DBCC CHECKDB (curso)
DBCC CHECKDB (curso,REPAIR_FAST)
DBCC CHECKDB (curso,REPAIR_REBUILD)
DBCC CHECKDB (curso,REPAIR_ALLOW_DATA_LOSS)


--Verifica a integridade de todas as páginas e estruturas 
--que compõem a tabela ou a exibição indexada
USE CURSO
DBCC CHECKTABLE (cidades)
--Inspeciona a integridade de uma restrição especificada ou de todas as 
--restrições em uma tabela especificada no banco de dados atual.

DBCC CHECKCONSTRAINTS

--Verifica a consistência de estruturas de alocação de espaço em disco
-- para um banco de dados especificado

DBCC CHECKALLOC

