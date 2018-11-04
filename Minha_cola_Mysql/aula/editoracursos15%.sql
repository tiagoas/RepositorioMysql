create database cursores;

create table autor(
cod_autor int primary key,
nome varchar(50),
nascimento varchar(50)
);

create table editora(
cod_editora int primary key,
razao varchar(50),
endereco varchar(50),
cidade varchar(50)
);

create table livro(
titulo varchar(50),
cod_autor int references autor (cod_autor),
cod_editora int references editora (cod_editora),
valor float,
ano_publicacao int
);

insert into autor values (110,'pedro alves','18/03/1955');
insert into autor values (111,'carolina dantas','22/02/1970');
insert into autor values (112,'olivia duncan','10/01/1968');


insert into editora values (1,'sextante','av. hortencias, 234', 'porto alegre');
insert into editora values (2,'fantasy','r. 24 horas, 55', 'sao paulo');
insert into editora values (3,'bookman','av. das ubaias, 303', 'recife');

insert into livro values ('banco de dados',110,3,150,2009);
insert into livro values ('o estranho',111,1,45,2010);
insert into livro values ('sucesso',112,2,35,2000);
insert into livro values ('arquitetura de bd',110,3,110,2007);
insert into livro values ('o conhecimento',110,3,150,2009);
insert into livro values ('bd distribuidos',111,1,98,2010);

-- Faça uma procedure que altere o preço dos livros: os livros da editora Bookman irão sofrer
-- um aumento de 15% e os livros da editora Sextante irão sofrer uma redução de 5%.

drop procedure if exists `exercicio1`;
delimiter $$
create procedure `exercicio1` ()
begin

declare existe_mais_linhas int default 0;
declare vlr int;
declare total int;
declare meuCursor cursor for select valor from livro;
declare continue handler for not found set existe_mais_linhas=1;
open meuCursor;
meuLoop:loop
fetch meuCursor into vlr;
if existe_mais_linhas=1 then
leave meuLoop;
end if;
select valor into vlr from livro where cod_editora=3;
set valor = vlr + (vlr*15/100);
end loop meuLoop;
close meuCursor;
end $$
delimiter ;

call exercicio1();

select * from livro;