create database t2;
use t2;


create table Departamentos(
cod_depto int(3),
descriçao varchar(30)
);

create table Empregados(
cod int(5) primary key,
nome varchar (50),
data_admissao varchar(50),
data_rescisao Date,
salario float(9,2),
profissao varchar(40),
cod_depto int(3) references departamentos(cod_depto)
);



insert into departamentos( cod_depto, descriçao) values
(1,'secretaria'),
(2,'adminitraçao'),
(3,'bibliotaca'),
(4,'portaria'),
(5,'professores'),
(6,'ajudantes');

insert into empregados (cod, nome, data_admissao, data_rescisao, salario, profissao, cod_depto) values
(4,'tiago',06/09/2010','23/03/2011' '100.00', 'porteiro' 4 ),
(1,'lucas',03/06/2008','03/07/2019' '1065.00', 'adminitraçao'2 ),
(1,'pedro',23/09/1997','23/03/2000' '134.00', 'professores' 5 ),
(1,'maria',09/01/2008','12/04/2011' '1000', 'secretaria' 1 ),
(1,'emerson',23/09/2016','23/03/2017' '1045.00', 'ajudantes' 6 ),
(1,'filipe',12/12/2008','11/01/2019' '1000.00', 'bibliotaca' 3 );

