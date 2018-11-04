--Link apoio https://msdn.microsoft.com/pt-br/library/ms188796(v=sql.120).aspx
USE MASTER
DBCC HELP ('?'); 
DBCC HELP (PROCCACHE)
--Exibe informações de fragmentação para os dados e índices da tabela ou exibição 
--especificada
use curso
DBCC SHOWCONTIG (cidades)

--Exibe as estatísticas de otimização de consulta atuais de uma tabela ou exibição indexada
DBCC SHOW_STATISTICS (cidades)

--Exibe informações em um formato de tabela sobre o cache de procedimento
DBCC PROCCACHE

--Ajuda a identificar as transações ativas que podem impedir o truncamento do log
DBCC OPENTRAN
