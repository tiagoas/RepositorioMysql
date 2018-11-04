use curso;
-- criando tabela para teste
CREATE TABLE artigo (
          id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
          titulo VARCHAR(200),
          corpo TEXT,
          FULLTEXT (titulo,corpo)
        ) ENGINE=InnoDB;

-- inserindo dados       
INSERT INTO artigo (titulo,corpo) VALUES
        ('MySQL Tutorial','SGBD MYSQL do zero ...'),
        ('Como utilizar bem o MYSQL','Depois que analisamos muitos ...'),
        ('Otimizando MySQL','Neste tutorial vamos aprende...'),
        ('1001 Dicas no MYSQL','1. Nunca incie o mysqld como root. 2. ...'),
        ('MySQL vs. SQL Server','Nesta comparação vamos ...'),
        ('Segurança no MYSQL','Quando configurado corretamente,o MySQL ...');
        
-- select * from artigo;
-- retornando
SET @pesquisa:='Tutorial';
SELECT * FROM artigo
        WHERE MATCH (titulo,corpo)
        AGAINST (@pesquisa IN NATURAL LANGUAGE MODE);
        

SET @pesquisa:='Tutorial';
SELECT COUNT(*) FROM artigo
    WHERE MATCH (titulo,corpo)
    AGAINST (@pesquisa IN NATURAL LANGUAGE MODE);
    

SET @pesquisa:='Tutorial';
SELECT
    COUNT(IF(MATCH (titulo,corpo)
    AGAINST (@pesquisa IN NATURAL LANGUAGE MODE), 1, NULL))
    AS count
    FROM artigo;

-- exemplo
SET @pesquisa:='Tutorial Otimizando';
SELECT id, MATCH (titulo,corpo)
    AGAINST (@pesquisa IN NATURAL LANGUAGE MODE) AS score
    FROM artigo;
    

-- select * from artigo

SET @pesquisa:='MySQL';
SELECT id,titulo,corpo,MATCH (titulo,corpo)
    AGAINST (@pesquisa IN NATURAL LANGUAGE MODE) AS score
    FROM artigo;

SET @pesquisa:='Quando configurado corretamente,o MySQL';
SELECT id, titulo,corpo, MATCH (titulo,corpo) AGAINST
    (@pesquisa IN NATURAL LANGUAGE MODE) AS score
    FROM artigo WHERE MATCH (titulo,corpo) AGAINST
    (@pesquisa IN NATURAL LANGUAGE MODE);
    
    



