    
    
    CREATE DATABASE aula_18_09_TRIGGER;

CREATE TABLE Produtos (
	Referencia VARCHAR(3) PRIMARY KEY,
	Descricao  VARCHAR(50) UNIQUE,
    Estoque INT NOT NULL DEFAULT 0
    );
    
    
    INSERT INTO Produtos VALUES ('001', 'Feijão', 10);
    INSERT INTO Produtos VALUES ('002', 'Arroz', 9);
    INSERT INTO Produtos VALUES ('003', 'Farinha', 15);
    
    CREATE TABLE ItensVenda (
	Venda int,
	Produto  VARCHAR(3),
    Quantidade int
    );



DELIMITER $

CREATE TRIGGER Tgr_ItensVenda_Insert AFTER INSERT
ON ItensVenda
FOR EACH ROW
BEGIN 
	UPDATE Produtos SET Estoque = Estoque - NEW.Quantidade
    WHERE Referencia = NEW.Produto;
    END$
    DELIMITER ;
    
    
    DELIMITER $
    CREATE TRIGGER Tgr_ItensVenda_Delete AFTER DELETE
    ON ItensVenda
    FOR EACH ROW
    BEGIN
		UPDATE Produtos SET Estoque = Estoque + OLD.Quantidade WHERE Referencia = OLD.Produto;
        END$
        
        DELIMITER ; 
        
        INSERT INTO ItensVenda VALUES (1, '001', 3);
        INSERT INTO ItensVenda VALUES (1, '002', 1);
        INSERT INTO ItensVenda VALUES (1, '003', 5);
        
        
        DELETE FROM ItensVenda WHERE Venda = 1 AND Produto = '001';
        
        
        
        CREATE DATABASE Aula_22_09_trigger;
        
        CREATE TABLE Produto2 (
			Referencia VARCHAR (3) PRIMARY KEY,
            Descricao VARCHAR (50) UNIQUE,
            Estoque INT NOT NULL DEFAULT 0
            );
            
            
            
            
            
            
            
            DELIMITER $
            CREATE TRIGGER Tgr_Copiar_Produto2 after insert
            ON Produtos
            FOR EACH ROW 
            BEGIN 
				insert into Produto2 (referencia,descricao,Estoque)
                values (new.referencia,new.descricao, new.Estoque);
                END$
                
                DELIMITER ;
               
               
               INSERT INTO Produtos VALUES ('004' , 'bala' , 150);
               
               
               DELIMITER $
				CREATE TRIGGER deletar_produto2 before delete
                on produtos
                for each row
                begin
					delete from produtos where produto2.Referencia = old.Referencia;
                    end$
                    DELIMITER ;
               
               
               
               delete from produtos where Referencia = '004'; 
               
               
               
               DELIMITER $
               CREATE TRIGGER Atualiza_Produto2 after update
               ON Produtos
               FOR EACH ROW
               BEGIN 
				update produto2 set produto2.Descricao = new.Descricao;
                END$
                DELIMITER ;
                
                
                insert into produtos (Referencia, Descricao, Estoque) values ('004','fuba', 25);
                
                
                
                update Produtos set descricao = 'bala de menta' where referencia = '004';
                SELECT * from Produto2;
                
                
                
                CREATE DATABASE Exemplooo_kkkk;
                
                CREATE TABLE Produto (
                idProduto int primary key,
                descricao varchar (255),
                preco float
                );
                
                
				CREATE TABLE Venda (
                idProduto int references Produto (idProduto),
                UnidadesVendidas int
                );
                
                
				CREATE TABLE TotalVendas (
                idProduto int references Produto (idProduto),
                TotalVendas int
                );
                
                
                
				CREATE TABLE Estoque (
                idProduto int references Produto (idProduto),
                UnidadesDisponiveis int
                );
                
                
                -- TRABALHO T1 ---------------------
                -- TRABALHO T1 ---------------------
                -- TRABALHO T1 ---------------------
                -- TRABALHO T1 ---------------------
                
                
                CREATE DATABASE Trabalho_t1;
                
                CREATE TABLE Produtos_Pedido (
                Numero int references Pedido (Numero) ,
                Cod_Prod int references Produto (Cod_Prod),
                Qtd int );
                
                
				CREATE TABLE Produto (
                Cod_Prod int primary key ,
                Nm_Prod int,
                Valor float );
                
                
				CREATE TABLE Fornecedor (
                Cod_Fornec int primary key ,
                Nome int ,
                Qtd int );
                
                
				CREATE TABLE Pedido (
                Numero int primary key ,
                Data varchar(255),
                Qtd int );
                
                
                -- Exercicio 01 
                -- Quantiddade de Produtos vendido no pedido 111
                SELECT Produtos_Pedido.Qtd from Produto_Pedido inner join Pedido on Pedido.Numero = 
                Produtos_Pedido.Numero where Pedido.Numero = '111';

				-- Nome do produto do pedido 111
                SELECT Produto.Nm_Prod from Produto inner join Produtos_Pedido on Produto.Cod_Prod = 
                Produtos_Pedido.Cod_Prod where Numero = '111';
                
                -- Nome do fornecedor que fez pedido em 10/02
                SELECT Fornecedor.Nome from Fornecedor inner join Pedido on Fornecedor.Cod_Fornec =
                Pedido.Cod_Fornec where data = '10/02/2010';
                
                
                -- Exercicio 02
                -- Apresente os nomes dos fornecedores que que já realizaram pedidos.
                SELECT Fornecedor.Nome from Fornecedor inner join Pedido on 
                Fornecedor.Cod_Fornec = Pedido.Cod_fornec where Cod_Fornec != null;
                
                -- Apresente os nomes dos produtos que nunca foram vendidos. 
                SELECT Produto.Nm_Prod from Produto inner join Produtos_Pedido on
                Produto.Cod_Prod = Produtos_Pedido.Cod_Prod where Qtd = NULL; 
                
                -- Altere a tabela PEDIDO acrescentando o campo total, que vai armazenar o valor total 
                -- do pedido em R$. Crie uma trigger que calcule e armazene o valor total do pedido. Sempre
                -- que existir um insert na tabela PRODUTOS_PEDIDO a trigger atualiza o valor total do pedido. 
                -- Obs.: a trigger tem que contemplar quando fará um insert na tabela PEDIDO ou quando fará um update. 
                
                ALTER TABLE Pedido ADD Total float;
                CREATE TRIGGER Calcula on Pedido FOR EACH ROW BEGIN 