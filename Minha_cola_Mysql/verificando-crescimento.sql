use curso
--Verificando tamanho/espaço ocupado pelos banco de dados
exec sp_databases

--Verificando tamanho/espaço ocupado pelos banco de dados
exec sp_spaceused 'alunos'
exec sp_spaceused 'cidades'

--verificando todas tabelas registros e tamanho
use curso

SELECT
    OBJECT_NAME(object_id) As Tabela, 
	p.Rows As Linhas,
    SUM(a.Total_Pages * 8) As Reservado,
    SUM(CASE WHEN p.Index_ID > 1 THEN 0 ELSE a.Data_Pages * 8 END) As Dados,
        SUM(a.Used_Pages * 8) -
        SUM(CASE WHEN p.Index_ID > 1 THEN 0 ELSE a.Data_Pages * 8 END) As Indice,
    SUM((a.Total_Pages - a.Used_Pages) * 8) As NaoUtilizado
FROM
    sys.partitions As p
    INNER JOIN sys.allocation_units As a 
	ON p.hobt_id = a.container_id
GROUP BY OBJECT_NAME(object_id), Rows
ORDER BY dados desc

--verificando tamanhos de arquivos
select DB_NAME(dbid)bd,
       cast(cast(size*8 as decimal(10,2))/1024. as decimal(10,3))tamanho,
	   STR (size * 8, 15, 0) + ' KB' tamanho_str,
	   name, 
	   filename
	   from sysaltfiles 






