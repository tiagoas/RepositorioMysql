-- criando função simples para retornar o valor da variavel a x b;
use curso;

DELIMITER //
create function fn_teste (a decimal(10,2),b int)
returns int
return a*b;
//

-- invocando a função
select fn_teste(12.5,3);

use curso;

create table produtos
 (
 id int not null primary key auto_increment,
 nome_prod varchar(50) not null,
 preco_unit decimal(10,2)
 );
 
 insert into produtos (nome_prod,preco_unit)
			values 
            ('XBOX','1500.99'),
            ('SMART TV 49' ,'3199.99'),
            ('NOTEBOOK' ,'4200.99');
            
-- CRIAR FUNCÃO para calcular total do preco x qtd
-- drop FUNCTION Fn_total
DELIMITER //
create FUNCTION Fn_total(preco decimal(10,2),qtd int)
RETURNS DECIMAL(10,2)
RETURN cast(qtd*preco as decimal(10,2));
//

-- invocando função
set @qtd:=3;
set @id:=1;

select nome_prod,@qtd qtd,preco_unit val_uni,fn_total(preco_unit,@qtd) total_compras
from produtos
where id=@id;

-- criando função para trazer primeira letra maiscula, demais minuscula
DELIMITER //
create function fn_initcap (nome varchar(50))
returns varchar(50)
return concat(upper(substring(nome,1,1)),lower(substring(nome,2,50)));
//
-- invocando função
select nome_prod,fn_initcap(nome_prod) from produtos;


-- criando função de boas vindas
DELIMITER //
create function fn_boas_vindas (usuario varchar(50))
returns varchar(50)
return  Concat('Ola ',usuario,' Seja Bem vindo');
//
-- invocando função
select fn_boas_vindas(user());


use sakila;
DELIMITER //
create function fn_filmes_ator (id_ator int)
returns int
begin
	declare qtd int;
select count(*) into qtd from film_actor where actor_id=id_ator;
return qtd;
end;
//
-- invocando função;
select fn_filmes_ator(1);

-- select * from film_actor;

use curso;
-- criando tabelas tara teste
CREATE TABLE avaliacao
	(aluno VARCHAR(10), 
	  nota1 INT, 
     nota2 INT, 
     nota3 INT, 
     nota4 INT);
     
INSERT INTO avaliacao VALUES('Paul', 10, 9, 10, 10);
INSERT INTO avaliacao VALUES('Mary', 5, 2, 3, 4);
-- criando a função calcula media aluno
DELIMITER //
CREATE FUNCTION fn_media (nome VARCHAR(10))
    RETURNS FLOAT
    BEGIN
    DECLARE n1,n2,n3,n4 INT;
    DECLARE med FLOAT;
    SELECT nota1,nota2,nota3,nota4 INTO n1,n2,n3,n4 
	     FROM avaliacao WHERE aluno = nome;
    SET med = (n1+n2+n3+n4)/4;
    RETURN med;
    END
    //
    
SELECT fn_media('Mary');


-- criando função simula aumento de salario;
delimiter //
create function fn_simula_aumento(salario decimal(10,2),pct decimal(10,2))
RETURNS DECIMAL(10,2)
	BEGIN
		RETURN salario + salario * pct /100;
	END //
delimiter ;   -- forcando o delimiter padrão;

-- invocando a função

SELECT fn_simula_aumento(1550.50,7.8);

-- Criando Function  – Table Value
-- drop function F_Cidades
-- use curso

use curso;
-- drop Function Fn_Cidades
DELIMITER //
Create Function Fn_Cidades (p_uf VarChar(2),p_ano int)
Returns int
 begin
  declare qtd int;
  Select count(*) into qtd from senso Where cod_uf=p_uf and ano=p_ano;
  return qtd;
  end
  //
delimiter ;   -- forcando o delimiter padrão;
  
-- Invocando funções 
Select distinct estado,Fn_Cidades(cod_uf,2014) from senso
where ano='2014';


select * from senso

-- criando index melhorar performance
create index ix_senso1 on senso(cod_uf,ano);

