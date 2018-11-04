CREATE DATABASE mini_ec; 

USE mini_ec;

-- cadastros independentes 
-- usuarios 
CREATE TABLE usuarios 
  ( 
     id_user       INT NOT NULL PRIMARY KEY auto_increment, 
     nome_user     VARCHAR(50) NOT NULL, 
     email_user    VARCHAR(60) NOT NULL, 
     senha         VARCHAR(32) NOT NULL, 
     data_cadastro DATETIME NOT NULL, 
     status        ENUM ('A', 'B')-- A= ATIVO B= BLOQUEADO 
  ); 

-- criando unique indice no campo email --> intregridade e perfomance 
CREATE UNIQUE INDEX ix_usr_1 ON usuarios(email_user); 

-- categoria de produtos 
CREATE TABLE categorias 
  ( 
     id_categoria INT NOT NULL PRIMARY KEY auto_increment, 
     descricao    VARCHAR(50) NOT NULL 
  ); 

-- fabricantes 
CREATE TABLE fabricantes 
  ( 
     id_fabricante   INT NOT NULL PRIMARY KEY auto_increment, 
     nome_fabricante VARCHAR(50) NOT NULL 
  ); 

-- uf 
-- drop table unidade_federal
CREATE TABLE unidade_federal 
  ( 
     cod_uf  TINYINT NOT NULL PRIMARY KEY, 
     uf      CHAR(2) NOT NULL, 
     nome_uf VARCHAR(50) NOT NULL 
  ); 

-- cidades 
-- drop table cidades
CREATE TABLE cidades 
  ( 
     id_cidade   INT NOT NULL PRIMARY KEY NOT NULL auto_increment, 
     nome_cidade VARCHAR(70) NOT NULL, 
     cod_mun     CHAR(7) NOT NULL, 
     cod_uf      TINYINT(2) NOT NULL 
  ); 

-- criando chave estrangeira      
ALTER TABLE cidades 
  ADD CONSTRAINT fk_cid_1 FOREIGN KEY (cod_uf) REFERENCES unidade_federal(cod_uf); 

-- produtos 
CREATE TABLE produto 
  ( 
     id_produto    INTEGER NOT NULL auto_increment, 
     descricao     VARCHAR(100) NOT NULL, 
     id_categoria  INT NOT NULL, 
     id_fabricante INT NOT NULL, 
     preco_custo   DECIMAL(10, 2), 
     preco_venda   DECIMAL(10, 2), 
     PRIMARY KEY(id_produto), 
     FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria), 
     FOREIGN KEY (id_fabricante) REFERENCES fabricantes(id_fabricante) 
  ); 

-- produto_caracteriticas 
CREATE TABLE produto_caracter 
  ( 
     id_produto     INT NOT NULL, 
     caracteristica VARCHAR(50) NOT NULL, 
     valor          VARCHAR(50) NOT NULL, 
     FOREIGN KEY (id_produto) REFERENCES produto(id_produto) 
  ); 

-- estoque 
CREATE TABLE estoque 
  ( 
     id_produto        INT NOT NULL, 
     estoque_total     INT NOT NULL, 
     estoque_livre     INT, 
     estoque_reservado INT, 
     FOREIGN KEY (id_produto) REFERENCES produto(id_produto) 
  ); 

-- clientes 
CREATE TABLE clientes 
  ( 
     id_cliente    INT NOT NULL PRIMARY KEY auto_increment, 
     nome          VARCHAR(32) NOT NULL, 
     sobrenome     VARCHAR(32) NOT NULL, 
     email         VARCHAR(60) NOT NULL, 
     senha         VARCHAR(32) NOT NULL, 
     data_nasc     DATE NOT NULL, 
     data_cadastro DATETIME NOT NULL, 
     ult_acesso    DATETIME, 
     ult_compra    DATETIME, 
     situacao      ENUM('A', 'B') NOT NULL -- A= Ativo B= Bloqueado 
  ); 

-- endereco_cli 
-- drop table cliente_endereco
CREATE TABLE cliente_endereco 
  ( 
     id_endereco INT NOT NULL PRIMARY KEY auto_increment, 
     id_cliente  INT NOT NULL, 
     tipo        ENUM ('P', 'A') NOT NULL,-- P= principal A= Alternativo 
     endereco    VARCHAR(60) NOT NULL, 
     numero      VARCHAR(10) NOT NULL, 
     bairro      VARCHAR(30) NOT NULL, 
     cep         VARCHAR(8) NOT NULL, 
     id_cidade   INT NOT NULL, 
     FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente), 
     FOREIGN KEY (id_cidade) REFERENCES cidades(id_cidade) 
  ); 

-- cond_pagto 
CREATE TABLE cond_pagto 
  ( 
     id_pagto  INT NOT NULL PRIMARY KEY auto_increment, 
     descricao VARCHAR(50) NOT NULL, 
     tipo      ENUM ('C', 'D', 'B') NOT NULL 
  -- C= Cartao, D = debito , B= Boleto 
  ); 

-- cond_pagto_det 
CREATE TABLE cond_pagto_det 
  ( 
     id_pagto   INT NOT NULL, 
     parcela    INT NOT NULL, 
     percentual DECIMAL(10, 2) NOT NULL, 
     dias       INT NOT NULL, 
     FOREIGN KEY (id_pagto) REFERENCES cond_pagto(id_pagto) 
  ); 

-- pedidos 
-- drop table pedidos 
CREATE TABLE pedidos 
  ( 
     num_pedido       INT NOT NULL PRIMARY KEY auto_increment, 
     id_cliente       INT NOT NULL, 
     id_endereco      INT NOT NULL, 
     id_pagto         INT NOT NULL, 
     total_prod       DECIMAL(10, 2), 
     total_frete      DECIMAL(10, 2), 
     total_desc       DECIMAL(10, 2), 
     total_pedido     DECIMAL(10, 2), 
     data_pedido      DATETIME NOT NULL, 
     previsao_entrega DATE, 
     efetiva_entrega  DATE, 
     status_ped       ENUM('A', 'S', 'F', 'T', 'E'), 
     -- A=aguard Aprov -- S=Separacao F=Faturado T= Em transito E= entregue 
     FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente), 
     FOREIGN KEY (id_endereco) REFERENCES cliente_endereco(id_endereco), 
     FOREIGN KEY (id_pagto) REFERENCES cond_pagto(id_pagto) 
  ); 

-- pedido produtos 
-- drop table pedido_itens 
CREATE TABLE pedido_itens 
  ( 
     num_pedido INT NOT NULL, 
     id_produto INT NOT NULL, 
     qtd        INT NOT NULL, 
     val_unit   DECIMAL(10, 2) NOT NULL, 
     desconto   DECIMAL(10, 2) NOT NULL, 
     total      DECIMAL(10, 2) NOT NULL, 
     FOREIGN KEY (num_pedido) REFERENCES pedidos(num_pedido), 
     FOREIGN KEY (id_produto) REFERENCES produto(id_produto) 
  ); 

-- pedido_obs 
CREATE TABLE pedido_obs 
  ( 
     num_pedido INT NOT NULL, 
     obs        VARCHAR(255) NOT NULL, 
     FOREIGN KEY (num_pedido) REFERENCES pedidos(num_pedido) 
  ); 

-- Notas 
-- drop table nota_fiscal 
CREATE TABLE nota_fiscal 
  ( 
     num_nota    INT NOT NULL PRIMARY KEY auto_increment, 
     num_ped_ref INT NOT NULL, 
     id_cliente  INT NOT NULL, 
     id_endereco INT NOT NULL, 
     id_pagto    INT NOT NULL, 
     total_prod  DECIMAL(10, 2), 
     total_frete DECIMAL(10, 2), 
     total_desc  DECIMAL(10, 2), 
     total_nf    DECIMAL(10, 2), 
     data_nf     DATETIME NOT NULL, 
     status_nf   ENUM('N', 'C', 'D'),-- N=Normal -- C=Cancelada D=Devolvida 
     id_user     VARCHAR(50), 
     FOREIGN KEY (num_ped_ref) REFERENCES pedidos(num_pedido), 
     FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente), 
     FOREIGN KEY (id_endereco) REFERENCES cliente_endereco(id_endereco), 
     FOREIGN KEY (id_pagto) REFERENCES cond_pagto_det(id_pagto) 
  -- foreign key (id_user) references usuarios(id_user) 
  ); 

-- Nota produtos 
-- drop table nf_itens 
CREATE TABLE nf_itens 
  ( 
     num_nota   INT NOT NULL, 
     id_produto INT NOT NULL, 
     qtd        INT NOT NULL, 
     val_unit   DECIMAL(10, 2) NOT NULL, 
     desconto   DECIMAL(10, 2) NOT NULL, 
     total      DECIMAL(10, 2) NOT NULL, 
     FOREIGN KEY (num_nota) REFERENCES nota_fiscal(num_nota), 
     FOREIGN KEY (id_produto) REFERENCES produto(id_produto) 
  ); 

-- nota_obs 
-- drop table nf_obs 
CREATE TABLE nf_obs 
  ( 
     num_nota INT NOT NULL, 
     obs      VARCHAR(255) NOT NULL, 
     FOREIGN KEY (num_nota) REFERENCES nota_fiscal(num_nota) 
  ); 

-- carrinho 
CREATE TABLE carrinho_compras 
  ( 
     sessao          VARCHAR(32) NOT NULL, 
     id_produto      INT NOT NULL, 
     qtd             INT NOT NULL, 
     val_unit        DECIMAL(10, 2) NOT NULL, 
     desconto        DECIMAL(10, 2) NOT NULL, 
     total           DECIMAL(10, 2) NOT NULL, 
     data_hora_sessa DATETIME NOT NULL, 
     FOREIGN KEY (id_produto) REFERENCES produto(id_produto) 
  ); 

CREATE INDEX ix_cc_1 ON carrinho_compras(sessao); 

-- rastreabilidade 
-- drop table rastreabilidade 
CREATE TABLE rastreabilidade 
  ( 
     num_pedido INT NOT NULL, 
     status_ped CHAR(1) NOT NULL, 
     -- A=aguard Aprov -- S=Separacao F=Faturado T= Em transito E= entregue 
     data_hora  DATETIME NOT NULL, 
     id_user    VARCHAR(50), 
     FOREIGN KEY (num_pedido) REFERENCES pedidos(num_pedido) 
  -- foreign key (id_user) references usuarios(id_user) 
  ); 
