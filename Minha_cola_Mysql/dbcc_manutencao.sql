--Link apoio https://msdn.microsoft.com/pt-br/library/ms188796(v=sql.120).aspx
--ALTER DATABASE CURSO SET MULTI_USER; 
--DBCC HELP (Diversos)
DBCC HELP ('?'); 
DBCC HELP ('checkfilegroup'); 

--A consist�ncia l�gica e f�sica dos objetos no banco de dados � 
--verificada nessa fase.
use curso
DBCC CHECKTABLE ('pedidos'); 

--As corre��es de banco de dados s�o executadas nessa fase, 
--se REPAIR_FAST, REPAIR_REBUILD ou REPAIR_ALLOW_DATA_LOSS 
--for especificado e houver erros de objeto que precisem ser corrigidos.
--DBCC TABLE REPAIR
USE MASTER
ALTER DATABASE CURSO SET SINGLE_USER;

DBCC CHECKTABLE ('cidades',REPAIR_FAST)
DBCC CHECKTABLE ('cidades',REPAIR_REBUILD)
DBCC CHECKTABLE ('cidades',REPAIR_ALLOW_DATA_LOSS)


--As tabelas do sistema de banco de dados s�o verificadas nessa fase.
--DBCC SYS CHECK
DBCC CHECKSYS

--As corre��es de banco de dados s�o realizadas nessa fase se 
--REPAIR_FAST, REPAIR_REBUILD ou REPAIR_ALLOW_DATA_LOSS 
--for especificado e houver erros de tabelas do sistema que precisem ser corrigidos.
DBCC SYS REPAIR

--Limpa cache de procedures
DBCC FREEPROCCACHE