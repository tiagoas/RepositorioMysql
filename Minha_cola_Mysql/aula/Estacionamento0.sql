create database estacionamento_db;

-- select it as the current db
use estacionamento_db;

-- create the customer table
create table cliente (
	cpf int,
    nome varchar(60),
    dtnasc DATE,
    primary key(cpf)    
);

-- create the model table
create table modelo(
	codmod int,
    descricao varchar(40),
    primary key(codmod)		
);

-- create the patio table
create table patio(
	num int,
    ender varchar(40),
    capacidade int,
    primary key(num)
);

-- create the vehicle table
create table veiculo(
	placa varchar(8),
    cliente_cpf int,
    modelo_codigo int,
    cor VARCHAR(40),
    ano int,
    primary key(placa),
    foreign key(cliente_cpf) references cliente(cpf),
    foreign key(modelo_codigo) references modelo(codmod)
);

-- create the table parking
create table estaciona(
	cod int,
    patio_num int,
    veiculo_placa varchar(8),
    dtentrada date,
    dtsaida date,
    hsentrada time,
    hssaida time,
    primary key(cod),
    foreign key(patio_num) references patio(num),
    foreign key(veiculo_placa) references veiculo(placa)
);

###################### PUPULATE THE TABLES ############################

insert into cliente values (1, "Fernando Rosa Moraes", "1980-01-01");
insert into cliente values (2, "Maria Nunes de Sá", "1984-01-01");
insert into cliente values (3, "Caio Bezerra dos Santos", "1987-01-01");
insert into cliente values (4, "Rosana de Moura Pires", "1970-01-01");
insert into cliente values (5, "Mario Reis de Oliveira", "1989-01-01");

insert into modelo values (1, "Sedan");
insert into modelo values (2, "Camioneta");
insert into modelo values (3, "Hatch");
insert into modelo values (4, "Caminhão");
insert into modelo values (5, "Moto");

insert into patio values(1, "Rua A", 45);
insert into patio values(2, "Rua B", 20);
insert into patio values(3, "Rua C", 100);

insert into veiculo values("JEG-1010", 1, 1, "Verde", 2001);
insert into veiculo values("JJJ-2020", 1, 1, "Azul", 2010);

insert into estaciona values(1, 1, "JEG-1010", "2017-07-12", "2017-07-12", "19:00:00", "20:00:00");
insert into estaciona values(2, 2, "JEG-1010", "2017-08-09", "2017-07-12", "16:00:00", "17:00:00");
insert into estaciona values(3, 1, "JEG-1010", "2017-07-06", "2017-07-12", "15:00:00", "17:00:00");
insert into estaciona values(4, 2, "JEG-1010", "2017-06-05", "2017-07-12", "14:00:00", "15:00:00");
insert into estaciona values(5, 1, "JEG-1010", "2017-07-04", "2017-07-12", "15:00:00", "21:00:00");
insert into estaciona values(6, 1, "JJJ-2020", "2017-07-12", "2017-07-12", "19:00:00", "20:00:00");
insert into estaciona values(7, 2, "JJJ-2020", "2017-08-09", "2017-07-12", "16:00:00", "17:00:00");
insert into estaciona values(8, 1, "JJJ-2020", "2017-07-06", "2017-07-12", "15:00:00", "17:00:00");
insert into estaciona values(9, 2, "JJJ-2020", "2017-06-05", "2017-07-12", "14:00:00", "15:00:00");
insert into estaciona values(10, 1, "JJJ-2020", "2017-07-04", "2017-07-12", "15:00:00", "21:00:00");


-- exercicio 1
SELECT cliente.Nome, veiculo.placa FROM cliente INNER JOIN veiculo ;

-- exercicio 2
SELECT cpf, nome from cliente INNER JOIN veiculo on cliente.cpf=veiculo.cliente_cpf where veiculo.placa = 'jjj-2020';

-- exercicio 3
SELECT placa, cor from veiculo inner join estaciona on veiculo.placa = estaciona.veiculo_placa where cod ='1';

-- exercicio 4
SELECT placa, ano from veiculo inner join estaciona on veiculo.placa = estaciona.veiculo_placa where cod ='1';

-- exercicio 5
SELECT veiculo.placa, veiculo.ano, modelo.descricao from veiculo inner join modelo on veiculo.modelo_codigo = modelo.codmod where ano > 2000;

-- exercicio 6
SELECT patio.ender, estaciona.dtentrada, estaciona.dtsaida from patio inner join estaciona on estaciona.patio_num = patio.num where estaciona.veiculo_placa = 'jeg-1010';


