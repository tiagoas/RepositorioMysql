--espaço em disco
use CURSO

PRINT getdate()
PRINT 'INICIO ESPAÇO EM DISCO'

insert into CKLIST.dbo.ESPACO_DISCO
select     b.volume_mount_point,
	       CAST(b.total_bytes / 1073741824.0 AS NUMERIC(18, 2)) AS disk_total_size_GB,
           CAST(b.available_bytes / 1073741824.0 AS NUMERIC(18, 2)) AS disk_free_size_GB,
		   CAST((b.total_bytes / 1073741824.0)-(b.available_bytes / 1073741824.0 )
		   AS NUMERIC(18, 2))  disk_usado_size_GB,
		   cast(sum(a.size / 128 / 1024.0)*1024.0 as numeric(18,2)) as disk_ocupado_sql_MB,
		   getdate() data_log
--	INTO ESPACO_DISCO	 
 from sys.master_files a 
 CROSS APPLY sys.dm_os_volume_stats(a.database_id,a.[file_id]) b
group by b.volume_mount_point,
CAST(b.total_bytes / 1073741824.0 AS NUMERIC(18, 2)),
           CAST(b.available_bytes / 1073741824.0 AS NUMERIC(18, 2)) ,
		   CAST((b.total_bytes / 1073741824.0)-(b.available_bytes / 1073741824.0 )
		   AS NUMERIC(18, 2))

PRINT getdate()
PRINT 'FIM ESPAÇO EM DISCO'	
PRINT 'INICIO  TAMANHO ARQUIVO'		   
--Arquivos tamanhos

insert into CKLIST.dbo.TAMANHO_ARQUIVOS
select     c.volume_mount_point,
           b.name db_nome,
		   a.type_desc tipo_arquivo,
		   a.name nome_logico,
		   a.physical_name path,
		   a.state_desc status,
		   cast(a.size * 8/1024. as numeric(18,2)) as tamanho_arquivo_MB,
		   getdate()data_log
	--	   INTO CKLIST.DBO.TAMANHO_ARQUIVOS
 from sys.master_files a WITH(NOLOCK)
inner join sys.databases b WITH(NOLOCK)
on a.database_id=b.database_id
 CROSS APPLY sys.dm_os_volume_stats(a.database_id,a.[file_id]) c
/*
group by c.volume_mount_point,
           b.name,
		   a.type_desc,
		   a.name,
		   a.physical_name,
		   a.state_desc
order by b.name
*/

PRINT getdate()
PRINT 'FIM  TAMANHO ARQUIVO'	
PRINT 'INICIO  ANALISE LOG'	

insert into CKLIST.dbo.ANALISE_LOG
(db_nome,Log_Size,Log_Space_Used_PCT,status_log)
exec dbo.Proc_analise_log

PRINT getdate()
PRINT 'FIM  ANALISE LOG'	
PRINT 'INICIO  LOG BACKUP'	
--Backup
insert into CKLIST.dbo.LOG_BACKUP
SELECT database_name, 
       NAME, 
       backup_start_date, 
       Datediff(mi, backup_start_date, backup_finish_date) [tempo (min)], 
       server_name, 
       recovery_model, 
       Cast(backup_size / 1024 / 1024 AS NUMERIC(15, 2))   [Tamanho (MB)] 
FROM   msdb.dbo.backupset B 
       INNER JOIN msdb.dbo.backupmediafamily BF 
               ON B.media_set_id = BF.media_set_id 
WHERE  backup_start_date >= Dateadd(hh, 18, getdate() - 1) 
       --backups realizados a partir das 18h de ontem 
       AND backup_start_date < Dateadd (day, 1, getdate()) 
       AND type = 'd' 

PRINT getdate()
PRINT 'FIM  LOG BACKUP'	
PRINT 'INICIO  TAMANHO DB'
--TAMANHO DB
insert into CKLIST.dbo.TAMANHO_DB
  SELECT DB.name, 
  CAST(SUM(size) * 8 /1024.  AS NUMERIC(10,2))Tamanho,
  STR(CAST(SUM(size) * 8 /1024.  AS NUMERIC(10,2)),10,2)+
  CASE WHEN SUM(size) * 8 /1024.>1000 
	   THEN ' GB' else ' MB' end  Tamanho_2,
	getdate() data_log
--	into cklist.dbo.tamanho_db	   
   FROM sys.databases DB
	INNER JOIN sys.master_files
	ON DB.database_id = sys.master_files.database_id
	GROUP BY DB.name


PRINT getdate()
PRINT 'FIM TAMANHO DB'	
PRINT 'INICIO  LOG JOBS'
--log jobs
insert into CKLIST.dbo.LOG_JOBS
select
	j.name,
	h.step_id,
	h.[message],
	h.Run_duration,
	h.run_status,
	case when h.run_status = 0 then 'Failed'
		when h.run_status = 1 then 'Succeeded'
		when h.run_status = 2 then 'Retry (step only)'
		when h.run_status = 3 then 'Canceled'
		when h.run_status = 4 then 'In-progress message'
		when h.run_status = 5 then 'Unknown' end Status,
	getdate() data_log
--	into cklist.dbo.log_job
		from msdb..sysjobs as j
		inner join msdb..sysjobhistory as h 
		on j.job_id = h.job_ID
where run_date  >= Dateadd(hh, 18, getdate() - 1) 


PRINT getdate()
PRINT 'FIM LOG JOBS'	
PRINT 'INICIO  HIST TABELAS'
--tamanho de tabelas
insert into CKLIST.dbo.HIST_TABELAS
SELECT
    OBJECT_NAME(object_id) As Tabela, Rows As Linhas,
    SUM(Total_Pages * 8) As Reservado,
    SUM(CASE WHEN Index_ID > 1 THEN 0 ELSE Data_Pages * 8 END) As Dados,
        SUM(Used_Pages * 8) -
        SUM(CASE WHEN Index_ID > 1 THEN 0 ELSE Data_Pages * 8 END) As Indice,
    SUM((Total_Pages - Used_Pages) * 8) As NaoUtilizado,
	getdate() data_log
	--into cklist.dbo.hist_tabela
FROM
    sys.partitions As P
    INNER JOIN sys.allocation_units As A ON P.hobt_id = A.container_id
GROUP BY OBJECT_NAME(object_id), Rows
ORDER BY Dados DESC

PRINT getdate()
PRINT 'FIM HIST TABELAS'	
PRINT 'FIM GERAL'