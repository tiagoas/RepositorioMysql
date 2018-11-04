--Passo 1
--Criando Banco de dados
--DROP DATABASE [AULA_BK]
USE MASTER
CREATE DATABASE AULA_BK
 ON  PRIMARY 
( 
  NAME = N'AULA_BK1', FILENAME = N'C:\Cursos\Database\Data\AULA_BK1.mdf' , 
  SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB 
  ),
  FILEGROUP AULA
  (
  NAME = N'AULA_BK2', FILENAME = N'C:\Cursos\Database\Data\AULA_BK2.mdf' , 
  SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB 
  ),
   (
  NAME = N'AULA_BK3', FILENAME = N'C:\Cursos\Database\Data\AULA_BK3.mdf' , 
  SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB 
  )
 LOG ON 
( NAME = N'AULA_BK_log', FILENAME = N'C:\Cursos\Database\Log\AULA_BK_log.ldf' , 
  SIZE = 1072KB , MAXSIZE = 2048MB , FILEGROWTH = 10%)

 
--Passo 2 
--Alterando modo de recuperacao
ALTER DATABASE AULA_BK SET RECOVERY FULL
 
--Passo 3
--Realizando 1 Backup
BACKUP DATABASE AULA_BK TO DISK='C:\Cursos\Database\BK\AULA_BK-FULL.BAK'
GO 


--Passo 4
--Criando tabela ALunos
--DROP TABLE ALUNOS
USE AULA_BK
CREATE TABLE ALUNOS (
	ALUNO_ID INT PRIMARY KEY,
	ALUNO_NOME VARCHAR (50),	
)ON AULA
GO
--CRIACAO DE INDEX
CREATE INDEX IX_ID ON ALUNOS(ALUNO_ID)  ON AULA

--Passo 5
--Populando Tabela
INSERT INTO ALUNOS VALUES (01, 'Maria Clara')
INSERT INTO ALUNOS VALUES (02, 'Augusto Luis')
--USE MASTER
--ADICIONANDO ARQUIVO DE DADOS
ALTER DATABASE AULA_BK
ADD FILE
(
NAME ='AULA_BK4',                              
FILENAME = N'C:\Cursos\Database\Data\AULA_BK4.mdf' ,
   SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB 
)
TO FILEGROUP AULA

--Passo 6
--Verificando registros
SELECT * FROM ALUNOS
 
--Passo 7 realizando 2 Backup
BACKUP DATABASE AULA_BK TO DISK='C:\Cursos\Database\BK\AULA_BK-FULL-2.BAK'
 
--Passo 8
--Apagando Banco de dados
USE MASTER
DROP DATABASE AULA_BK

--Passo 9
--Restaurando 1 Backup
RESTORE DATABASE AULA_BK FROM DISK='C:\Cursos\Database\BK\AULA_BK-FULL.BAK'
GO
 
--Passo 10
--Analisando evidencias
 
USE AULA_BK
SELECT * FROM ALUNOS

--Passo 11
--Apagando Banco de dados
USE master
DROP DATABASE AULA_BK
GO
 
--Passo 12
--Restaurando 2 Backup
RESTORE DATABASE AULA_BK FROM DISK='C:\Cursos\Database\BK\AULA_BK-FULL-2.BAK'
GO
 
--13
--Verificando registros
USE AULA_BK
SELECT * FROM ALUNOS

--Passo 14
--Inserindo mais registros
USE AULA_BK
INSERT INTO ALUNOS VALUES (03, 'MIKE SILVA')
INSERT INTO ALUNOS VALUES (04, 'Odair Rocha')
 
--Passo 15 
--Verificando registros
USE AULA_BK
SELECT * FROM ALUNOS
 
--Passo 16
--Criando Backup com Arquivos de Log
BACKUP LOG AULA_BK TO DISK = 'C:\Cursos\Database\BK\AULA_BK-LOG1.TRN'
GO 

--Passo 17
--Inserindo mais registros
INSERT INTO ALUNOS VALUES (05, 'Pedro Santos')
INSERT INTO ALUNOS VALUES (06, 'Tiago Maia')
 
--Passo 18
----Criando Backup com Arquivos de Log
BACKUP LOG AULA_BK TO DISK = 'C:\Cursos\Database\BK\AULA_BK-LOG2.TRN'
GO
 
--Passo 19 
--Inserindo registro
INSERT INTO ALUNOS VALUES (07, 'Gustavo Lion')

--Passo 20
--Verificando
USE AULA_BK
SELECT * FROM ALUNOS
 
--Passo 21
--Realizando Backup diferencial, 
BACKUP DATABASE AULA_BK TO DISK='C:\Cursos\Database\BK\BACKUP_BANCO-DIFF-1.BAK' 
WITH DIFFERENTIAL
 
 
--Passo 22
--inserindo registro
INSERT INTO ALUNOS VALUES (08, 'Andre Antonio')

--Passo 23 
--verificando registros
USE AULA_BK
SELECT * FROM ALUNOS
 
--Passo 24
--Apagando Banco de dados
USE MASTER
DROP DATABASE AULA_BK
GO

--Passo 25
--Restauracao FULL e DIFF
RESTORE DATABASE AULA_BK FROM DISK='C:\Cursos\Database\BK\AULA_BK-FULL-2.BAK' 
WITH NORECOVERY
GO
 
RESTORE DATABASE AULA_BK FROM DISK='C:\Cursos\Database\BK\BACKUP_BANCO-DIFF-1.BAK' 
WITH NORECOVERY
GO
RESTORE DATABASE AULA_BK WITH RECOVERY
GO
 
--Passo 26
--Verificando dados
USE AULA_BK
SELECT * FROM ALUNOS
