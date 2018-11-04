CREATE DATABASE ClienteVeiculo;

use ClienteVeiculo;

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

-- 1 - Exiba a placa e o nome dos donos de todos os veículos.

SELECT nome, placa FROM cliente
INNER JOIN veiculo on cpf = Cliente_cpf;

-- 2 Exiba o CPF e o nome do cliente que possui o veiculo de placa “JJJ-2020”.

SELECT cpf, nome FROM Veiculo
INNER JOIN Cliente ON Cliente_cpf = cpf WHERE placa = 'JJJ-2020';

-- 3. Exiba a placa e a cor do veículo que possui o código de estacionamento 1.

SELECT placa, cor FROM veiculo
INNER JOIN estaciona ON Veiculo_placa = placa WHERE cod=1;

-- 4. Exiba a placa e o ano do veículo que possui o código de estacionamento 1.

SELECT placa, ano FROM veiculo
INNER JOIN estaciona ON Veiculo_placa = placa WHERE cod=1;

-- 5. Exiba a placa, o ano do veículo e a descrição de seu modelo, se ele possuir ano a partir de 2000.

SELECT placa, ano, descricao FROM Veiculo
INNER JOIN modelo ON codmod = modelo_codigo WHERE ano > 2000;

-- 6. Exiba o endereço, a data de entrada e de saída dos estacionamentos do veículo de placa “JEG-1010”.

SELECT ender, dtentrada, dtsaida FROM Patio
INNER JOIN Estaciona ON patio_num = num WHERE veiculo_placa = 'JEG-1010';

-- 7. Exiba a quantidade de vezes os veículos de cor verde estacionaram.

SELECT count(cod) as qntde FROM Estaciona
INNER JOIN veiculo ON placa = veiculo_placa WHERE cor = 'verde';

-- 8. Liste todos os clientes que possuem carro de modelo 1.

SELECT nome FROM Cliente
INNER JOIN Veiculo ON cliente_cpf = cpf WHERE modelo_codigo = 1;

-- 9. Liste as placas, os horários de entrada e saída dos veículos de cor verde.

SELECT placa, hsentrada, hssaida FROM estaciona
INNER JOIN Veiculo ON placa = veiculo_placa WHERE cor = 'verde';

-- 10. Liste todos os estacionamentos do veículo de placa “JJJ-2020”.

SELECT *FROM estaciona
WHERE veiculo_placa = 'JJJ-2020';

-- 11. Exiba o nome do cliente que possui o veículo cujo código do estacionamento é 2.

SELECT nome FROM Cliente
INNER JOIN Veiculo ON cliente_cpf = cpf
INNER JOIN Estaciona ON veiculo_placa = placa
WHERE cod = 2;

-- 12. Exiba o CPF do cliente que possui o veículo cujo código do estacionamento é 3.

SELECT cpf FROM Cliente
INNER JOIN Veiculo ON cliente_cpf = cpf
INNER JOIN Estaciona ON veiculo_placa = placa
WHERE cod = 2;
 
-- 13. Exiba a descrição do modelo do veículo cujo código do estacionamento é 2.

SELECT descricao FROM Modelo
INNER JOIN Veiculo ON modelo_codigo = codmod
INNER JOIN Estaciona ON veiculo_placa  = placa
WHERE cod = 2;

-- 14. Exiba a placa, o nome dos donos e a descrição dos os modelos de todos os veículos.

SELECT placa, nome, descricao FROM veiculo
INNER JOIN Cliente ON cpf = cliente_cpf
INNER JOIN Modelo ON codmod = modelo_codigo;








-- Arthur.
use estacionamento_db;

-- 1)                                             arthur
select	c.nome,v.placa from	cliente c
    inner join veiculo v
    on (c.cpf = v.cliente_cpf);

-- 2)
select	c.cpf,	c.nome from	cliente c
    inner join veiculo v
    on (c.cpf = v.cliente_cpf)
where
	v.placa = "JJJ-2020";

-- 3)

select 	v.placa, v.cor from	veiculo v
    inner join estaciona e
    on (v.placa = e.veiculo_placa)
where 
	e.patio_num = 1;
	
-- 4)

select 	v.placa, v.ano from	veiculo v
    inner join estaciona e
    on (v.placa = e.veiculo_placa)
where 
	e.patio_num = 1;

-- 5)

select	v.placa,v.ano, m.descricao from veiculo v
    inner join modelo m
    on (v.modelo_codigo = m.codmod)
where
	ano > 2000;

-- 6)

select 	p.ender,   e.dtentrada,  e.dtsaida from	estaciona e 
    inner join patio p
    on (e.patio_num = p.num)
where
	veiculo_placa = "JEG-1010";

-- 7)

select 	count(*) as total_visitas from 	estaciona e  inner join veiculo v
    on (e.veiculo_placa = v.placa)
where
	v.cor = "Verde";
    
-- 8)

select 	c.* from cliente c
    inner join veiculo v
    on (c.cpf = v.cliente_cpf)
where 
	v.cor = "Verde";

-- 9)

select 	e.veiculo_placa,   e.hsentrada,   e.hssaida from estaciona e 
    inner join veiculo v
	on (e.veiculo_placa = v.placa)
where
	v.cor = "Verde";

-- 10)
select	* from	estaciona
where 
	veiculo_placa = "JJJ-2020";
    
-- 11)
select 	* from 	estaciona
where 
	veiculo_placa = "JJJ-2020";
    




