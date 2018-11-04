-- create the database;
CREATE DATABASE views_db;

-- use it
USE views_db;

-- create the products table
CREATE TABLE produtos
(
    referencia VARCHAR(3) PRIMARY KEY,
    descricao  VARCHAR(50) UNIQUE,
    estoque    INT NOT NULL DEFAULT 0
);

-- insert data
INSERT INTO produtos VALUES ('001', 'Feijão', 10);
INSERT INTO produtos VALUES ('002', 'Arroz', 5);
INSERT INTO produtos VALUES ('003', 'Farinha', 15);

-- create the order itens table
CREATE TABLE itens_venda
(
    venda      INT,
    produto    VARCHAR(3),
    quantidade INT
);

CREATE TRIGGER trg_itens_venda_after_insert AFTER INSERT
    ON itens_venda
FOR EACH ROW
    BEGIN
        UPDATE
            produtos
        SET
            estoque = (estoque - new.quantidade)
        WHERE
            referencia = new.produto;
    END;

CREATE TRIGGER  trg_itens_venda_after_delete AFTER DELETE
    ON itens_venda
FOR EACH ROW
    BEGIN
        UPDATE
            produtos
        SET
            estoque = (estoque + OLD.quantidade)
        WHERE
            referencia = old.produto;
    END;

select * from produtos;
select * from itens_venda;

insert into itens_venda values (1, '001', 3);
insert into itens_venda values (2, '002', 1);
insert into itens_venda values (3, '003', 5);
delete from itens_venda where  venda = 1 and produto = '001';