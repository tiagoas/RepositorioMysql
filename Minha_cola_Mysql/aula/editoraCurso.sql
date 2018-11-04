create database cursordb;

use cursordb;

create table autor (
    cod_autor int,
    nome varchar(50) not null,
    nascimento date not null,
    primary key (cod_autor)
);

create table editora (
    cod_editora int,
    razao varchar(50) not null,
    endereco varchar(255) not null,
    cidade varchar(50) not null,
    primary key (cod_editora)
);

create table livro (
    cod_livro int,
    titulo varchar(255) not null,
    cod_autor int not null,
    cod_editora int not null,
    valor float,
    ano_publicacao int,
    primary key (cod_livro),
    foreign key (cod_autor) references autor(cod_autor),
    foreign key (cod_editora) references editora(cod_editora)
);

insert into autor values (110, 'Pedro Alves', '1955-03-18');
insert into autor values (111, 'Carolina Dantas', '1970-02-22');
insert into autor values (112, 'Olivia Duncan', '1968-01-10');

insert into editora values (1, 'Sextante', 'Rua A', 'Porto Alegre');
insert into editora values (2, 'Fantasy', 'Rua B', 'São Paulo');
insert into editora values (3, 'Bookmman', 'Rua C', 'Recife');

delete from livro;
insert into livro values (1, 'Banco de Dados', 110, 3, 150, 2009);
insert into livro values (2, 'O Estranho', 111, 1, 45, 2010);
insert into livro values (3, 'Sucesso', 112, 2, 35, 2000);
insert into livro values (4, 'Arquitetura de DB', 110, 3, 110, 2007);
insert into livro values (5, 'O Conhecido', 111, 1, 55, 2009);
insert into livro values (6, 'DB Distribuídos', 110, 3, 98, 2010);

-- 1

delimiter $$
create procedure sp_atualizar_valores_livros()
    begin
        declare id_livro int default null;

        declare eof bool default false;

        declare livros_atualizar cursor for (select cod_livro from livro where cod_editora in (1,3));

        declare continue handler for not found set eof = true;

        open livros_atualizar;
        while (!eof) do
            fetch livros_atualizar into id_livro;

            set @cod_editora = (select cod_editora from livro where cod_livro = id_livro);

            set @desconto =
            case
                when @cod_editora = 3 then
                    15
                else
                    -5
            end;
            


            update livro set valor = (valor + (valor * (@desconto/100)));

        end while;
        close livros_atualizar;
    end $$
delimiter ;

select * from livro where cod_editora in (1, 3);

call sp_atualizar_valores_livros();

-- 2

delimiter $$sp_atualizar_valores_livros
create procedure sp_livros_depois_de(in ano_base int)
    begin
        select * from livro where ano >= ano_base;
    end$$
    
    delimiter ;
    
    


