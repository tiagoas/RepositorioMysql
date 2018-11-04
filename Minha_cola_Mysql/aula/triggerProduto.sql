create database Trabalho;
use Trabalho;
create table Produto(
	 codProd int primary key not null,
	 nomeProduto varchar(80) not null,
	 valor decimal(10,2)
);
create table Fornecedor (
	 codFornecedor int,
	 nome varchar(60),
	 endereco varchar(60),
	 PRIMARY KEY (codFornecedor, nome)
);
create table Pedido (
	 numero int primary key,
	 dataPedido date,
	 codFornecedor int,
	 foreign key (codFornecedor) references fornecedor (codFornecedor)
);
create table Produtos_Pedido (
	 numero int not null,
	 codProd int not null,
	 qtd int,
	 PRIMARY KEY (numero, codProd),
	 foreign key (numero) references pedido    (numero),
	 foreign key (codProd) references Produto (codProd)
  );
insert into Produto values (1, 'SMART TV LED 55',                   '1200.00'),
						   (2, 'REFRIGERADOR FROST FREE 553 LITROS','5600.00'),
						   (3, 'LAVADOURA DE ROUPAS 15KG',          '2600.00'),
						   (4, 'CLIMATIZADOR DE AR ELETROLUX',       '780.00'),
						   (5, 'VENTILADOR DE TETO',                 '180.00'),
						   (6, 'FOGÃO 4 BOCAS',                      '780.00');
insert into fornecedor values   (1, 'MARTINS',      'FLORIANO PEIXOTO, 232'),
								(2, 'PEIXOTO',     'PARQUE INDUSTRIAL, 190'),
								(3, 'CASAS BAHIA',  'PARQUE INDUSTRIAL, 90'),
								(4, 'PONTO FRIO',  'PARQUE INDUSTRIAL, 390');
insert into Pedido values (1, '2017-09-29', '1'),
						  (2, '2017-09-30', '2'),
						  (3, '2017-09-19', '3'),
						  (4, '2017-09-15', '4');
insert into Produtos_Pedido values(1, 1, '38'),
								  (2, 2, '12'),
								  (3, 3, '18'),
								  (4, 4, '21');

-- 1) Elaborar pelo menos 3 questões que envolvam junção (join) de duas ou mais tabelas;
-- APRESENTE O NOME, VALOR DO PRODUTO, CUJO FORNECEDOR É 2;
select Produto.nomeProduto, produto.valor, fornecedor.codFornecedor from Produto
inner join Produtos_Pedido on Produtos_Pedido.codProd = Produto.codProd
inner join pedido on pedido.numero = produtos_pedido.numero
inner join fornecedor on fornecedor.codFornecedor = Pedido.codFornecedor
where Pedido.codFornecedor = 2; 

-- Exiba  o nome do produto, valor cujo número do Pedido é 4;
select produto.nomeProduto, produto.valor, produto.codProd from produto
inner join Produtos_Pedido on Produtos_Pedido.codProd = Produto.codProd
inner join pedido on pedido.numero = produtos_pedido.numero
where Pedido.numero = 4; 

-- Liste nome, endereço, data do pedido de todos os fornecedores que fizeram pedidos em Setembro de 2017;
select nome, endereco, dataPedido from Fornecedor inner join Pedido
on Pedido.codFornecedor = Fornecedor.codFornecedor
where dataPedido between '2017-09-01' and '2017-09-30'; 

-- 2) 	Utilizando operações em conjuntos, 
-- a.	Apresente os nomes dos fornecedores que já realizaram pedidos
select fornecedor.nome from fornecedor inner join Pedido 
on Pedido.codFornecedor = Fornecedor.codFornecedor;


-- b. Apresente os nomes dos produtos que nunca foram vendidos.
select distinct produto.nomeProduto from produtos_pedido
left join Produto on Produtos_Pedido.codProd != Produto.codProd;


-- 3) Altere a tabela PEDIDO acrescentando o campo total, que vai armazenar o valor total do pedido em R$.
alter table Pedido
add column Total float;

alter table pedido
modify total decimal(10,2);


-- Crie uma trigger que calcule e armazene o valor total do pedido. Sempre que existir um insert na tabela PRODUTOS_PEDIDO a trigger 
-- atualiza o valor total do pedido. Obs.: a trigger tem que contemplar quando fará um insert na tabela PEDIDO ou quando fará um update.


delimiter $
CREATE TRIGGER atualiza_total AFTER INSERT
ON produtos_pedido
FOR EACH ROW
BEGIN
    DECLARE vtotal decimal(10,2);

	 SELECT SUM(produto.valor * produtos_pedido.qtd)  INTO vtotal 
	 FROM produtos_pedido 
	 inner join produto on produtos_pedido.codProd = produto.codProd
	 inner join pedido on produtos_pedido.numero = pedido.numero;
	 

    update pedido set total = vtotal
    where pedido.numero = new.numero;
    
	
END $ delimiter ;


-- 4) Crie a tabela UPDATE_PRODUTO(data_atualizacao(pk), Cod_prod(pk), valor_antigo).
create table Update_Produto(
data_atualizacao date primary key not null,
codProd int,
valor_antigo float,
foreign key (codProd) references Produto(codProd)
);

alter table update_produto
modify valor_antigo decimal(10,2);
 
-- Crie uma trigger que sempre que um produto sofrer atualização de valor, insira o Cod_prod, data_atualizacao, e valor_antigo na tabela
-- UPDATE_PRODUTO.


delimiter $
 create trigger guardaValAntigo after update 
 on produto 
 for each row
 begin 
	 if(old.valor != new.valor) then 
	  insert into update_produto
	  values(SYSDATE(), old.codProd, old.valor);
 end if; end $   
 delimiter ;
    

-- 5) Usando a base de dados filmes (visto em sala) crie uma view que apresente o nome do filme, o ano, o estúdio e o nome do diretor 
-- de todos os filmes do ano de 2017. 
  create view VisaoGeral as 
    (select filme.nome as nomefilme, filme.ano, estudio.nome as nomeestudio, diretor.nome as nomediretor, ator.nome FROM filme
	inner join estudio on estudio.id_estudio = filme.id_estudio
    inner join diretor on diretor.id_diretor = filme.id_diretor 
    inner join participa on participa.id_filme = filme.id_filme
    inner join ator on ator.id_ator = participa.id_ator
    where ano = '2017');

-- Utilizando essa view, apresente os filmes da Disney lançados em 2017.
create view VisaoGeral2 as (select *from visaogeral
where nome = 'disney');


-- 6) Usando a base de dados estacionamento (visto em sala), crie uma view que apresente o cpf, o nome do cliente, a placa, o modelo e a cor do carro.

create view VisaoEstacionamento as (select cliente.cpf, cliente.nome, veiculo.placa, modelo.desc_2, veiculo.cor from cliente
inner join veiculo on cliente.cpf = veiculo.cliente_cpf
inner join modelo on modelo.codMod = veiculo.modelo_codMod
inner join estaciona on veiculo.placa = estaciona.veiculo_placa
); -- verificar a duplicidade de nomes


--  Usando a view, apresente a quantidade de carros da cor prata que já utilizaram o estacionamento.
create view VisaoEstacionados as (select count(*)veiculo from visaoestacionamento
where cor ='prata');
