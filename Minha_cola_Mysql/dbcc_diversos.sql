--Retorna informações de sintaxe para o comando especificado DBCC.
DBCC HELP (?)
DBCC HELP (TRACEON)

--Descarrega o procedimento armazenado estendido DLL especificado da memória
DBCC dllname (FREE)

--select * from sys.session
--Habilita os sinalizadores de rastreamento especificados
DBCC TRACEON 

----Exibe o status de sinalizadores de rastreamento
DBCC TRACESTATUS


--Desabilita os sinalizadores de rastreamento especificados.
DBCC TRACEOFF 


--apoio 
-- Conexões ativas
SELECT * FROM sys.dm_exec_connections
 
-- Sessões ativas
SELECT * FROM sys.dm_exec_sessions
 
-- Requisições solicitadas
SELECT * FROM sys.dm_exec_requests


--Indentificando arquivo trace
SELECT * FROM sys.traces;

--verificando arquivo TRACE
SELECT  TextData, 
		SPID, 
		LoginName, 
		NTUserName, 
		NTDomainName, 
		HostName, 
		ApplicationName, 
		StartTime, ServerName, 
		DatabaseName, 
		EventClass, 
		ObjectType
FROM fn_trace_gettable('C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\Log\log_19.trc', default)


SELECT GETDATE()