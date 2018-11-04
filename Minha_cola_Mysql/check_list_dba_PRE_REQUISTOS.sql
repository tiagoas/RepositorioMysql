--CRIANDO DATABASE
use master
--drop DATABASE CKLIST
CREATE DATABASE CKLIST
go
USE CKLIST
--CRIANDO TABELA PARA ARMAZENAR DADOS DE DISCOS
CREATE TABLE dbo.ESPACO_DISCO(
	volume nvarchar(256) NULL,
	disk_total_size_GB numeric(18, 2) NULL,
	disk_free_size_GB numeric(18, 2) NULL,
	disk_usado_size_GB numeric(18, 2) NULL,
	disk_ocupado_sql_MB numeric(18, 2) NULL,
	data_log datetime NOT NULL
	)
--CRIANDO TABELAS PARA ARMAZENAR TAMANHOS DE ARQUIVOS

CREATE TABLE dbo.TAMANHO_ARQUIVOS(
	volume nvarchar(256) NULL,
	db_nome sysname NOT NULL,
	tipo_arquivo nvarchar(60) NULL,
	nome_logico sysname NOT NULL,
	path nvarchar(260) NOT NULL,
	status nvarchar(60) NULL,
	tamanho_arquivo_MB numeric(18, 2) NULL,
	data_log datetime NOT NULL
)

--ARMAZENA ANALISE DE LOG
--drop table dbo.analise_log 
create table dbo.ANALISE_LOG (
	db_nome varchar(50),
	Log_Size numeric(15,2),
	Log_Space_Used_pct numeric(15,2),
	status_log int,
	data_log datetime default getdate()
	)

--ARMAZENA HISTORICO DE BACKUP

CREATE TABLE dbo.LOG_BACKUP 
  ( 
     db_nome           NVARCHAR(256), 
     nome              NVARCHAR(256), 
     backup_start_date DATETIME, 
     tempo             INT, 
     server_name       NVARCHAR(256), 
     recovery_model    NVARCHAR(120), 
     tamanho           NUMERIC(15, 2) 
  ) 

--ARMAZENA HISTORICO DATABASE 
--USE cklist
CREATE TABLE dbo.TAMANHO_DB(
	name sysname NOT NULL,
	Tamanho numeric(10, 2) NULL,
	Tamanho_2 varchar(13) NULL,
	data_log datetime NOT NULL
)

--ARMAZENA LOG DE JOBS
CREATE TABLE dbo.LOG_JOBS(
	name sysname NOT NULL,
	step_id int NOT NULL,
	message nvarchar(4000) NULL,
	Run_duration int NOT NULL,
	run_status int NOT NULL,
	Status varchar(19) NULL,
	data_log datetime NOT NULL
)
--ARMAZENA HISTORICO DE TABELAS
CREATE TABLE dbo.HIST_TABELAS(
	Tabela nvarchar(128) NULL,
	Linhas bigint NULL,
	Reservado bigint NULL,
	Dados bigint NULL,
	Indice bigint NULL,
	NaoUtilizado bigint NULL,
	data_log datetime NOT NULL
)

--DROP procedure dbo.Proc_analise_log
--Verifica utlização de log de log
CREATE procedure dbo.Proc_analise_log
as
DBCC SQLPERF (LOGSPACE) 
--FIM PROCEDURE


