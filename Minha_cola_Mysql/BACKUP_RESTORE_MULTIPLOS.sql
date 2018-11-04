--BACKUP MULTIPLOS ARQUIVOS 
BACKUP DATABASE AdventureWorks2014
TO DISK = 'C:\Cursos\Database\BK\AdventureWorks_1.BAK',
   DISK = 'C:\Cursos\Database\BK\AdventureWorks_2.BAK',
   DISK = 'C:\Cursos\Database\BK\AdventureWorks_3.BAK',
   DISK = 'C:\Cursos\Database\BK\AdventureWorks_4.BAK'
   WITH STATS

 
--DROP DATABASE
DROP  DATABASE AdventureWorks2014

--RESTORE MULTIPLOS ARQUIVOS
RESTORE DATABASE AdventureWorks2014
FROM  DISK = 'C:\Cursos\Database\BK\AdventureWorks_1.BAK',
   DISK = 'C:\Cursos\Database\BK\AdventureWorks_2.BAK',
   DISK = 'C:\Cursos\Database\BK\AdventureWorks_3.BAK',
   DISK = 'C:\Cursos\Database\BK\AdventureWorks_4.BAK'
   WITH STATS,RECOVERY