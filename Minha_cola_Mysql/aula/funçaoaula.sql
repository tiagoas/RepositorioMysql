create database funçao1;

use funçao1;

CREATE TABLE IF NOT EXISTS aluno (
id INT NOT NULL ,
nome VARCHAR(100) NOT NULL ,
matricula VARCHAR(45) NOT NULL ,
data_nascimento DATE NULL ,
data_matricula DATE NOT NULL ,
PRIMARY KEY ( id ) ,
UNIQUE INDEX matricula_UNIQUE ( matricula ASC)
);
-- inserindo alunos
INSERT INTO aluno (id, nome, matricula, data_nascimento, data_matricula) VALUES
(1,'MICHAEL JONH', '123A', STR_TO_DATE('23/08/1993', '%d/%m/%Y'), CURRENT_DATE()),
(2,'WILLIANS JUNIOR', '400B', STR_TO_DATE('10/04/1993', '%d/%m/%Y'), CURRENT_DATE()),
(3,'JOHN BILLBOARD', '420B', STR_TO_DATE('30/07/1993', '%d/%m/%Y'), CURRENT_DATE()),
(4,'JENNY KILLY', '010A', NULL, STR_TO_DATE('25/01/2014', '%d/%m/%Y')
);
CREATE TABLE IF NOT EXISTS prova (
id INT NOT NULL ,
data_realizacao DATE NOT NULL ,
descricao VARCHAR(255) NOT NULL ,
PRIMARY KEY ( id )
);
-- INSERINDO PROVAS
INSERT INTO prova(id, data_realizacao, descricao) VALUES
(1, STR_TO_DATE('30/03/2014', '%d/%m/%Y'), 'Prova A1'),
(2, STR_TO_DATE('30/04/2014', '%d/%m/%Y'), 'Prova B1'),
(3, STR_TO_DATE('30/05/2014', '%d/%m/%Y'), 'Prova C1'),
(4, STR_TO_DATE('30/07/2014', '%d/%m/%Y'), 'Prova A2'),
(5, STR_TO_DATE('30/08/2014', '%d/%m/%Y'), 'Prova B2'),
(6, STR_TO_DATE('30/09/2014', '%d/%m/%Y'), 'Prova C2');

CREATE TABLE IF NOT EXISTS nota (
aluno_id INT NOT NULL ,
prova_id INT NOT NULL ,
valor_nota DECIMAL(15,2) NULL ,
PRIMARY KEY ( aluno_id , prova_id ) ,
INDEX fk_aluno_has_prova_prova1 ( prova_id ASC) ,
INDEX fk_aluno_has_prova_aluno1 ( aluno_id ASC) ,
FOREIGN KEY ( aluno_id ) REFERENCES aluno ( id ),
FOREIGN KEY ( prova_id ) REFERENCES prova ( id )
);
-- INSERINDO NOTAS
INSERT INTO nota (aluno_id, prova_id, valor_nota) VALUES
#ALUNO 1
(1, 1, 10),
(1, 2, 9.8),
(1, 3, 8),
(1, 4, 10),
(1, 5, 10),
(1, 6, 9),
#ALUNO 2
(2, 1, 7),
(2, 2, 7.5),
(2, 3, 6),
(2, 4, 8),
(2, 5, 8.5),
(2, 6, 9),
#ALUNO 3
(3, 1, 9),
(3, 2, 9),
(3, 3, 9),
(3, 4, 10),
(3, 5, 10),
(3, 6, 9.8),
#ALUNO 4
(4, 1, 3),
(4, 2, 6),
(4, 3, 7),
(4, 4, 8),
(4, 5, 7),
(4, 6, 7);


#1. Faça uma function que calcula a média de um determinado aluno.
DELIMITER $
create function `calcula_media`(aluno_id int)
RETURNS float

BEGIN 
declare media_nota float;
        select avg(valor_nota) into media_nota from nota 
        where aluno_id = nota.aluno_id;
RETURN media_nota;
    END$$
DELIMITER ;

select calcula_media(4) as nota;
    


#2. Crie uma procedure que apresente a matricula, o nome e a média de cada aluno.
DELIMITER $$
create procedure `dados_aluno`(in aluno_id int)
BEGIN
    select (concat( 'Matricula: ', matricula, '  Aluno: ', nome,   '  Média: ' , calcula_media(aluno_id))) from aluno
    where aluno_id = id;
    
   
END$$
DELIMITER ;

call dados_aluno(4);


#3. Crie uma function que retorne o nome, a matricula e a média do aluno de maior média.

DELIMITER $
create function `dados_aluno`()
RETURNS varchar(255)
BEGIN
    declare var varchar(255);
    select (concat('Aluno: '  , aluno.nome,  '  Matrícula: ', aluno.matricula,  ' com a maior média: ', max(calcula_media((aluno_id))))) into var from nota
    inner join aluno on  aluno.id = nota.aluno_id;
RETURN var;
   
END$$
DELIMITER ;

select dados_aluno();



#1. Faça uma function que calcula a média de um determinado aluno.
#2. Crie uma procedure que apresente a matricula, o nome e a média de cada aluno.
#3. Crie uma function que retorne o nome, a matricula e a média do aluno de maior média