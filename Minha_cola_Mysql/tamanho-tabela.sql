-- verificando tamanho tabelas
SELECT 
    table_schema AS DB,
    table_name AS tabela,
    data_length / 1024 / 1024 'Tamanho da tabela em MB',
    index_length / 1024 / 1024 'Tamanho do indice em MB',
    table_rows AS linhas,
    ENGINE
FROM
    information_schema.TABLES
WHERE
    table_schema = 'curso'
ORDER BY 3 DESC;

-- verifcando tamanho DB
SELECT 
    table_schema 'Nome_DB',
    SUM(data_length + index_length) / 1024 / 1024 'Data Base Size in MB'
FROM
    information_schema.TABLES
GROUP BY table_schema; 