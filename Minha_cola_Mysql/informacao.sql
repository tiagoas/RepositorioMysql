
-- funções de informacao

select charset('123')retorno1,charset('ABC') retorno2


use world;

select name,charset(name)nome,
	    continent,charset(continent)continent,
       population,charset(population) populacao
from country;

-- charset converoes
select charset(convert(name using utf8))nome,
       convert(name using utf8)nome,
       charset(name)continent,
       name nome2,
	    charset(continent)continent,
       charset(population) populacao
from country;


-- collation
use curso;
SELECT COLLATION('abc');

SELECT COLLATION(nome) from alunos;


use world;
SELECT COLLATION('abc');

use world;
SELECT COLLATION(name) from country;

--  descobrindo id da conexao
select CONNECTION_ID();


-- trazendo informação do usuario logado

select current_user();
select current_user
SELECT USER();
select session_user();
select system_user();

-- verficando database selecionado

select database();


use sakila;
select database();

-- verifanco usuarios
SELECT * FROM mysql.user;


-- trazendo linhas lidas
use curso;
SELECT SQL_CALC_FOUND_ROWS nome_mun FROM senso;
SELECT FOUND_ROWS();

-- retornando ultimo id inserido
insert into alunos (nome) values ('Catarina');
SELECT LAST_INSERT_ID();

-- -- retornando ultimo id inserido
insert  into  alunos (nome) values ('Greg'),('Marla'),('Jack');
SELECT LAST_INSERT_ID();

--
-- retorna quantidade de registro inseridos, atualizado, deletados

update funcionarios set salario=salario*1.055;
SELECT row_count();

-- verifcando schema db ativo
use curso;
select SCHEMA();

use sakila;
select SCHEMA() 

use world;
select SCHEMA();

-- verificando versao mysql
select version();
