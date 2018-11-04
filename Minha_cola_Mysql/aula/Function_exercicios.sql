create database Aula_Procedure;
USE Aula_Procedure;
create table departamento (
	cod_depto int,
	localizacao varchar(50),
	nome_depto varchar(50),
	primary key (cod_depto)
);

USE `aula_procedure`;
DROP procedure IF EXISTS `inserir_depto`;

DELIMITER $$
USE `aula_procedure`$$
CREATE PROCEDURE `inserir_depto` (in cod int, in localizacao varchar(50), in nome varchar(50))
	BEGIN
	insert into departamento values (cod,localizacao, nome);
	END$$

DELIMITER ;

	call inserir_depto(1,'Karaiba', 'Sistemas de Informação');
	call inserir_depto(2,'Karaiba', 'Engenharia de Produção');
	call inserir_depto(3,'Centro', 'Marketing');
	call inserir_depto(4,'Karaiba', 'Direito');
    
    
USE `aula_procedure`;
DROP procedure IF EXISTS `update_nome_depto`;

DELIMITER $$
USE `aula_procedure`$$
CREATE PROCEDURE `update_nome_depto` (in cod int, in nome varchar(50))
BEGIN
	update departamento set nome_depto = nome where cod_depto = cod;
END$$

DELIMITER ;

call update_nome_depto(4,'Engenharia Civil');

USE `aula_procedure`;
DROP procedure IF EXISTS `selecionar_depto`;

DELIMITER $$
USE `aula_procedure`$$
CREATE PROCEDURE `selecionar_depto`(in quantidade int)
BEGIN
	select *from departamento
    LIMIT quantidade;

END$$

DELIMITER ;

call selecionar_depto(4);

create table funcionario(
	cod_func int,
    cod_depto int,
    nome_func varchar(50),
    data_nasc date,
    sexo char, 
    primary key (cod_func),
    foreign key (cod_depto) references departamento(cod_depto)
    );
    
insert into funcionario values (1, 1, 'Cecília Maximiano',     '1980-02-12', 'F');
insert into funcionario values (2, 2, 'Maria Clara',           '1986-02-12', 'F');
insert into funcionario values (3, 3, 'Mariah Czar',           '1980-02-12', 'F');
insert into funcionario values (4, 4, 'Noah Hermann Hirsch',   '1980-02-12', 'M');
insert into funcionario values (5, 4, 'Victor Hermann Hirsch', '1980-02-12', 'M');
    
    USE `aula_procedure`;
DROP procedure IF EXISTS `select_func_sexo`;

USE `aula_procedure`;
DROP procedure IF EXISTS `select_func_sexo`;

DELIMITER $$
USE `aula_procedure`$$
CREATE PROCEDURE `select_func_sexo`(in sex char)
BEGIN
	if sex ='F' then
		select *from funcionario where sexo =sex;
    else
		if sex = 'M' then
			select *from funcionario where sexo = sex;
        else
			select *from funcionario;
        end if;    
    end if;
END$$

DELIMITER ;

call select_func_sexo('F');


USE `aula_procedure`;
DROP procedure IF EXISTS `qtd_depto_procedure`;

DELIMITER $$
USE `aula_procedure`$$
CREATE PROCEDURE `qtd_depto_procedure` (out quantidade int)
BEGIN
	select count(*) into quantidade from departamento;
END$$

DELIMITER ;

-- ALTERANDO NOME DE UMA COLUNA
alter table teste
change column valor qtde int;

call qtd_depto_procedure(@total);
select @total as qtd_depto;

create table teste(
cod int,
qtde int,
primary key (cod)
);

drop table teste;

USE `aula_procedure`;
DROP procedure IF EXISTS `qtd_depto_procedure`;

DELIMITER $$
USE `aula_procedure`$$
CREATE PROCEDURE `qtd_depto_procedure`(in qtde int)
BEGIN
	declare quantidade int;
    select count(*) into quantidade from funcionario where cod_depto = qtde;
    insert into teste values  (qtde, quantidade);
END$$

DELIMITER ;

call qtd_depto_procedure(1);
select *from teste;


 -- EXERCITANDO PROCEDURES --

-- 1. Insira um cliente e seu animal nas respectivas tabelas;
USE `veterinario`;
DROP procedure IF EXISTS `inserir_cliente`;

DELIMITER $$
USE `veterinario`$$
CREATE PROCEDURE `inserir_cliente` (in idcliente int, in nome varchar(50), in endereco varchar(50), in bairro varchar(10), in cep varchar(11),
                                                                        in cidade varchar(20), in estado varchar(20), in telefone varchar(15))
BEGIN
	insert into cliente values(idCliente, nome, endereco, bairro, cep, cidade, estado, telefone);
END$$
DELIMITER ;
    
call inserir_cliente(6, 'Mariah Hisrsh', 'Rua Vieira Gonçalves, 1232', 'Centro', '38408-118', 'SJRP', 'SP', '17-99113-7655');
    
    
USE `veterinario`;
DROP procedure IF EXISTS `inserir_animal`;

DELIMITER $$
USE `veterinario`$$
CREATE PROCEDURE `inserir_animal` (in idAnimal int, in nome varchar(20), in idade int, in sexo char(1), in idEspecie int, in idCliente int)
BEGIN
	insert into animal values(idAnimal, nome, idade, sexo, idEspecie, idCliente);
END$$

DELIMITER ;inserir_animalinserir_animal
call inserir_animal(8, 'Tobias', '4', 'M', '3', '6');
    

-- 2. Apresente o nome do cliente e do animal que foi consultado por um determinado veterinário;
USE `veterinario`;
DROP procedure IF EXISTS `select_cliente_animal`;

DELIMITER $$
USE `veterinario`$$
CREATE PROCEDURE `select_cliente_animal`(in idCliente int, in idAnimal int, in idVeterinario int)
BEGIN
	select Cliente.nome as nomeCliente, Animal.nome as nomeAnimal, veterinario.nome as nomeVeterinario from cliente
	inner join animal on cliente.idCliente = animal.idCliente
	inner join veterinario on consulta.idVeterinario = veterinario.idVeterinario
    inner join tratamento on tratamento.idAnimal = animal.idAnimal
    inner join consulta on consulta.idTratamento = tratamento.idTratamento
	WHERE co.idVeterinario = id_Veterinario;
END$$

DELIMITER $$ ;

call select_cliente_animal (6,6,1);
  
-- 3- Apresente o nome do cliente e do animal que realizaram consulta no mês de Setembro;
USE `veterinario`;
DROP procedure IF EXISTS `select_Consulta_setembro`;

DELIMITER $$
USE `veterinario`$$
CREATE PROCEDURE `select_Consulta_setembro` (in mes int)
BEGIN
	select cliente.nome, animal.nome from animal
    inner join cliente on cliente.idCliente = animal.idCliente
    inner join tratamento on  tratamento.idAnimal = animal.idAnimal
    inner join consulta on consulta.idTratamento = tratamento.idTratamento
    where month(data) = mes;
END$$

DELIMITER ;

call select_Consulta_setembro(9);


-- 4. Apresente o nome do veterinário que já fez pedido de exames;
USE `veterinario`;
DROP procedure IF EXISTS `select_pedido_exame`;

DELIMITER $$
USE `veterinario`$$
CREATE PROCEDURE `select_pedido_exame` ()
BEGIN
	select veterinario.nome from veterinario
    inner join consulta on veterinario.idveterinario = consulta.idveterinario;
    inner join exame on consulta.idconsulta = exame.idConsulta
END$$

DELIMITER ;

call select_pedido_exame();


-- 5. Atualize os dados de um cliente;
USE `veterinario`;
DROP procedure IF EXISTS `update_cliente`;

DELIMITER $$
USE `veterinario`$$
CREATE PROCEDURE `update_cliente` (in nomeC varchar(50), in idclienteC int)
BEGIN
	update cliente set nome = nomeC
    where idcliente = idclienteC;
END$$

DELIMITER ;

call update_cliente('Manuela Bergamasco',5);

    