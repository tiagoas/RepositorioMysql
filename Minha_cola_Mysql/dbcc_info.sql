--Link apoio https://msdn.microsoft.com/pt-br/library/ms188796(v=sql.120).aspx
USE MASTER
DBCC HELP ('?'); 
DBCC HELP (PROCCACHE)
--Exibe informa��es de fragmenta��o para os dados e �ndices da tabela ou exibi��o 
--especificada
use curso
DBCC SHOWCONTIG (cidades)

--Exibe as estat�sticas de otimiza��o de consulta atuais de uma tabela ou exibi��o indexada
DBCC SHOW_STATISTICS (cidades)

--Exibe informa��es em um formato de tabela sobre o cache de procedimento
DBCC PROCCACHE

--Ajuda a identificar as transa��es ativas que podem impedir o truncamento do log
DBCC OPENTRAN
