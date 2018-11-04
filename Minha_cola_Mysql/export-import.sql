-- verificando dados
use curso;
select * from uf;

-- exportando arquivo

SELECT * INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\uf.csv' 
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' FROM uf;

-- verificando problema no estado TO
select estado,charset(estado) from uf;

-- Realizando Update para corrigir
update uf set estado='Tocantins' where cod_uf='17';

-- apagando a tabela para realizar nova carga
delete from uf; 
-- verificando dados
SELECT * FROM UF;

-- carregando arquivo
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\uf.csv' 
INTO TABLE uf
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';


-- verificando dados
SELECT * FROM UF;
