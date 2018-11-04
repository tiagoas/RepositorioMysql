--Redução automática do banco de dados
--Quando a opção AUTO_SHRINK do banco de dados estiver definida como ON, 

ALTER DATABASE AULA_BK SET AUTO_SHRINK OFF --(Desliga)
ALTER DATABASE AULA_BK SET AUTO_SHRINK ON  --(Liga)


--Reduzindo um banco de dados e especificando uma porcentagem de espaço livre
--O exemplo a seguir diminui o tamanho dos arquivos de dados e de log no banco 
--de dados de usuário UserDB para permitir 10 por cento de espaço livre no banco de dados.

DBCC SHRINKDATABASE (AdventureWorks2014, 10);

--Truncando um banco de dados
--O exemplo a seguir reduz os arquivos de dados no banco 
--de dados de exemplo AdventureWorks2014 até a última extensão alocada.

DBCC SHRINKDATABASE (AdventureWorks2014, TRUNCATEONLY);

--Reduzindo arquivo de dados
use AdventureWorks2014
DBCC SHRINKFILE (AdventureWorks2014_Data, 10);
DBCC SHRINKFILE (AdventureWorks2014_Log, 5);

