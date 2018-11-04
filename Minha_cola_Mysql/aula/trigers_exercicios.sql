CREATE DATABASE trg_exerc;
USE trg_exerc;

CREATE TABLE produto (
    idProduto INT PRIMARY KEY,
    descricao VARCHAR(50),
    preco     DOUBLE
);

INSERT INTO produto VALUES (1, 'P1', 25);
INSERT INTO produto VALUES (2, 'P2', 50);
INSERT INTO produto VALUES (3, 'P3', 75);


CREATE TABLE venda (
    idVenda          INT PRIMARY KEY,
    idProduto        INT NOT NULL,
    unidadesVendidas INT,
    FOREIGN KEY (idProduto) REFERENCES produto (idProduto)
);

CREATE TABLE totalVenda (
    idProduto   INT NOT NULL,
    totalVendas DOUBLE,
    FOREIGN KEY (idProduto) REFERENCES produto (idProduto)
);

CREATE TABLE estoque (
    idProduto           INT NOT NULL,
    unidadesDisponiveis INT,
    FOREIGN KEY (idProduto) REFERENCES produto (idProduto)
);

CREATE TABLE comprar(
    idProduto int not null,
    descricao varchar(50)
);

INSERT INTO estoque VALUES (1, 10);
INSERT INTO estoque VALUES (2, 50);
INSERT INTO estoque VALUES (3, 30);

CREATE TRIGGER trg_venda_atualiza_total_vendas
AFTER INSERT
    ON venda
FOR EACH ROW
    BEGIN
        INSERT INTO totalVenda (idProduto, totalVendas)
            SELECT idProduto, (preco * NEW.unidadesVendidas)
            FROM produto
            WHERE idProduto = NEW.idProduto;
    END;

CREATE TRIGGER trg_venda_atualiza_estoque
AFTER INSERT
    ON venda
FOR EACH ROW
    BEGIN
        UPDATE estoque
        SET unidadesDisponiveis = (unidadesDisponiveis - NEW.unidadesVendidas)
            WHERE estoque.idProduto = NEW.idProduto;
    END;

CREATE TRIGGER trg_estoque_atualiza_comprar
AFTER UPDATE
    ON estoque
FOR EACH ROW
    BEGIN
        IF (NEW.unidadesDisponiveis <= 0) THEN
            IF ((SELECT COUNT(*) FROM comprar WHERE comprar.idProduto = NEW.idProduto) = 0) THEN
                INSERT INTO comprar (idProduto, descricao)
                    SELECT produto.idProduto, produto.descricao FROM produto WHERE produto.idProduto = NEW.idProduto;
            END IF;
        ELSE
            IF ((SELECT COUNT(*) FROM comprar WHERE comprar.idProduto = NEW.idProduto) > 0) THEN
                DELETE FROM comprar WHERE comprar.idProduto = NEW.idProduto;
            END IF;

        END IF;
    END;
