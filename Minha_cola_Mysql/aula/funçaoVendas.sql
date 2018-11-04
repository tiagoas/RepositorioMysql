create table Clientes(
CliCod int not null primary key,
CliNome varchar(60)

);

insert into clientes values
(1,    'Danilo Arantes'),
(2,      'Kayke Mendes'),
(3,    'Wendreo Araujo'),
(4, 'Douglas Domingues'),
(5,   'Rodrigo Pereira');

select *from clientes;

create table Vendas(
VenCod int not null primary key,
VenDta date not null,
VenCli int,
VenSit boolean,
foreign key (VenCli) references Clientes(CliCod)
);
    
Alter table Vendas
add column VenTotal float;

select *from vendas;

insert into Vendas values
(1, '2017-05-17', 1,  true),
(2, '2017-02-07', 2,  true),
(3, '2017-03-04', 3,  true),
(4, '2017-10-28', 4, false);

select *from vendas;

create table Produtos(
ProdCod int not null primary key,
ProdDsc varchar(70),
ProdVlUnit float,
ProdQtdEst int
);

insert into Produtos values 
(010, 'Bala de Menta',     0.20, 1000),
(020, 'Prestigio Branco',  1.20,  100),
(030, 'Kit Kat',           1.40,  200),
(040, 'Trident',           0.90, 1000),
(050, ' Bala de Chiclete', 5.98,   58),
    (060, 'Barra de Cereais',     1.80, 0),
(070, 'Bolinho de Chocolate', 2.20, 0);

select *from produtos;

create table Itens(
VenCod int not null,
ProdCod int not null,
IVQtd int,
IVVVlrUnit float,
foreign key (VenCod) references vendas(VenCod),
foreign key (ProdCod) references produtos(ProdCod)
);

alter table itens
change ivvvlrunit IVVlrUnit float;

select *from itens;

insert into Itens values 
(1, 010, '38', '0.20'),
(2, 020, '12', '1.20'),
(3, 030, '36', '1.40'),
(4, 040, '60', '0.90');

select *from itens;



-- 1. Faça uma function que dado o código do produto (ProdCod) e a quantidade (IVQtd) retorne o valor total desse item.
DELIMITER $
create function `Valor_Total`(codProd int, IVQtd int) Returns float
BEGIN
DECLARE  ValorTotal FLOAT;
    select (ProdVlUnit) into ValorTotal from Produtos
    where ProdCod = codProd;
    return IVQtd * ValorTotal;
END$$
DELIMITER ;

select Valor_Total(010,38);
    

/* 2. Faça uma procedure dado o VenCod(código da venda), ProdCod(código do produto) e a IVQtd(quantidade de itens da venda),
 insere o item na tabela itens. Obs.: utilizar a function anterior*/
 USE `aula_function`;
DROP procedure IF EXISTS `Insere_Itens`;
DELIMITER $$
USE `aula_function`$$
CREATE PROCEDURE `Atualiza_Itens`(in CodVenda int, in CodProd int, in Qt_Item int)
BEGIN
        declare valorUnitario float;
        declare idProduto int;
        select(Valor_Total(codProd, Qt_Item)) into valorUnitario;
        select ProdCod into idProduto from produtos
        where Produtos.ProdCod = CodProd;
        if (idProduto = null) then        
  insert into Itens values(codVenda, CodProd, Qt_Item, valorUnitario);
          select Valor_Total(codProd, Qt_Item);
        else
           update Itens set IVQtd = IVQtd + Qt_Item;
           select Valor_Total(codProd, Qt_Item);
        end if;
END$$

DELIMITER ;

call Atualiza_Itens(2, 020,10);

select *from itens;

-- 3. Function que dado o VenCod retorne o valor total da venda.
DELIMITER $
create function `Total_Vendas`(CodVenda int) Returns float
BEGIN 
Declare ValorTotal float;
    select sum(Produtos.ProdVlUnit * itens.IVQtd) into ValorTotal from itens 
    inner join Vendas on itens.VenCod = Vendas.VenCod
    inner join produtos on itens.ProdCod = produtos.ProdCod
    where Vendas.VenCod = CodVenda;
     Return ValorTotal;
END$$
DELIMITER $    

select Total_Vendas(1);


/* 4. Adicione a coluna VenTotal que armazena o total da venda.
 Crie uma procedure que altera a situação de uma venda (de aberto para finalizado),
 atualizando também o valor total da venda. Obs.: utilizar a function anterior.*/ 
 alter table Vendas
 add column VenTotal float;
 DELIMITER $$
 create procedure `Altera_Vendas`(in codvenda int)
 BEGIN
 
declare TotalVendas float;
     select Total_Vendas(codvenda) into TotalVendas;
     update Vendas set VenSit = true, VenTotal = TotalVendas 
     where Vendas.VenCod = codvenda; 
END$$
DELIMITER ;  

drop procedure Altera_Vendas;

call altera_vendas(1);

select *from vendas;
 
 
-- 5. Function que retorna a quantidade de vendas em aberto.

DELIMITER $
create function `Vendas_Abertas`() Returns int
BEGIN
declare Vds_Abertas int;
        select count(*) into Vds_Abertas from vendas
        where VenSit = false;
      
Return Vds_Abertas;
END$$
DELIMITER $$

select Vendas_Abertas();

select *from vendas;


-- 6. Procedure que mostra quais produtos estão fora de estoque.

DELIMITER $$
USE AULA_FUNCTION$$
create procedure `Sem_Estoque`()
BEGIN
select ProdCod, ProdDsc from Produtos
where Produtos.ProdQtdEst = 0; 
END$$
DELIMITER ;

call Sem_Estoque();
        
        



    
    


