--DETACH/DESANEXANDO BD
USE master;  
GO  
EXEC sp_detach_db @dbname = N'CURSO';  
GO 

--ATTACH/ANEXANDO BD
USE master;  
GO  
CREATE DATABASE CURSO   
    ON (FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\curso.mdf'),
	   (FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\curso_log.ldf')  
    FOR ATTACH;  
GO   

--DETACH/DESANEXANDO BD
USE master;  
GO  
EXEC sp_detach_db @dbname = N'AULA_BK';  
GO  

--ATTACH/ANEXANDO BD
USE master;  
GO  
CREATE DATABASE AULA_BK   
    ON (FILENAME = 'C:\Cursos\Database\Data\AULA_BK1.mdf'),
	   (FILENAME = 'C:\Cursos\Database\Data\AULA_BK2.mdf'),
	   (FILENAME = 'C:\Cursos\Database\Data\AULA_BK3.mdf'),
	   (FILENAME = 'C:\Cursos\Database\Data\AULA_BK4.mdf'),
	   (FILENAME = 'C:\Cursos\Database\log\AULA_BK_log.ldf') 
    FOR ATTACH;  
GO  
