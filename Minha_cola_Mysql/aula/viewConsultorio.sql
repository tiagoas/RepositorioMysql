create database consultorio;
use consultorio;

create table Cliente(
id_Cliente integer primary key not null,
nome varchar(20),
endereço varchar(20),
bairro varchar(20),
cep varchar(20),
cidade varchar(20),
estado varchar(20),
telefone varchar(20)
);

create table Especie(
id_Especie integer primary key not null,
descriçao varchar(40)
);

create table Animal(
id_Animal integer primary key not null,
id_Especie integer not null,
id_Cliente integer not null,
nome varchar(10),
idade integer,
sexo char(1) check (sexo='m' or sexo='f'),
foreign key (id_Especie)  references Especie (id_Especie),
foreign key (id_Cliente) references Cliente (id_Cliente)
);

create table Tratamento(
id_Tratamento integer primary key not null,
data_Inicial varchar(10),
data_Final varchar(10),
id_Animal integer not null,
foreign key (id_Animal) references Animal (id_animal)
);


create table Veterinario(
id_Veterinario integer primary key not null,
nome varchar(10),
endereço varchar(10),
telefone varchar(10)
);
altertable`Veterinario` CHANGE `telefone``telefone` VARCHAR(255)NOTNULL; 

use consultorio;

create table Consulta(
id_Consulta integer primary key,
data_Consulta date not null,
historico varchar(10),
id_Tratamento integer not null,
id_Veterinario integer not null,
foreign key (id_Tratamento) references Tratamento (id_Tratamento),
foreign key (id_Veterinario) references Veterinario (id_Veterinario)
);

create table Exame(
id_Exame integer primary key,
descricao_Exame varchar(20),
id_Consulta integer,
foreign key (id_Consulta) references Consulta (id_Consulta)
);

    INSERT INTO Cliente VALUES (1,'Michele', 'Rua 1','Bairro 1','123','Uberlandia','MG','1111-1111');
    INSERT INTO Cliente VALUES (2,'Bruno' , 'Rua 2','Bairro 2','456','Uberlandia','MG','2222-2222');
    INSERT INTO Cliente VALUES (3,'Thiago' , 'Rua 3','Bairro 3','789','Uberlandia','MG','3333-3333');
    INSERT INTO Cliente VALUES (4,'Nathan' , 'Rua 4','Bairro 4','234','Uberlandia','MG','4444-4444');
    INSERT INTO Cliente VALUES (5,'Bianca' , 'Rua 5','Bairro 5','567','Uberlandia','MG','5555-5555');

    INSERT INTO Especie VALUES (1, 1, 'Mandy',7,'f'); 
	INSERT INTO Especie VALUES (2,'2',    '5',       'chanim','2','2');
    INSERT INTO Especie VALUES (3,'3' ,        '2',         'M','3','2');
    INSERT INTO Especie VALUES (4,'4',   '3','M','4','3');
    INSERT INTO Especie VALUES (5,'5'   , '1',     'M','5','1');
    
    
    INSERT INTO Especie VALUES (1, 'cachorro');
    INSERT INTO Especie VALUES (2,'Gato');
    INSERT INTO Especie VALUES (3,'cachorro');
    INSERT INTO Especie VALUES (4,'coelho');
	INSERT INTO Especie VALUES (5,'hamister');
    
    
    
    INSERT INTO Animal VALUES (1,1,1,'Mandy',7,'f'); 
	INSERT INTO Animal VALUES (2,2,5,       'chanim',3,'m');
    INSERT INTO Animal VALUES (3, 3 ,2,       'rex',1,'m');
    INSERT INTO Animal VALUES (4,4,3,       'branquinho', 3,'m');
    INSERT INTO Animal VALUES (5, 5,1,   'hantaro', 2,'m');
  
    
    
    
    INSERT INTO Tratamento VALUES (1,'23-05-2017','24-05-2017',1); 
	INSERT INTO Tratamento VALUES (2,'24-04-2017','04-05-2017', 2);
    INSERT INTO Tratamento VALUES (3,'01-09-2017' ,'08-05-2017',3);
    INSERT INTO Tratamento VALUES (4,'04-09-2017',null,  4);
    INSERT INTO Tratamento VALUES (5, '11-09-2017','null', 5);
    

    
    INSERT INTO Veterinario VALUES (1,'Fulano ','Rua 3','666'); 
	INSERT INTO Veterinario VALUES (2,'Joao','Rua 5','77777');

    
	INSERT INTO Consulta VALUES (1,'2017-05-23','dfsdfs',1,1); 
	INSERT INTO Consulta VALUES (2,'2017-04-24','sdfsd', 2,1);
    INSERT INTO Consulta VALUES (3,'2017-06-24' ,'sdfsd',2,1);
    INSERT INTO Consulta VALUES (4,'2017-05-04','sdfsd',  1,1);
    INSERT INTO Consulta VALUES (5, '2017-09-01','sdfsd', 3,2);
    INSERT INTO Consulta VALUES (6,'2017-09-04','sdfsd', 4,2);
    INSERT INTO Consulta VALUES (7,'2017-09-08' ,'sdfsd',3,2);
    INSERT INTO Consulta VALUES (8,'2017-09-11','dfsd',  5,1,2);
    INSERT INTO Consulta VALUES (9, '2017-09-11','sdfsd', null,2);
    
    
  

    INSERT INTO Exame VALUES (1,'Exame sangue',null);
    INSERT INTO Exame VALUES (2, 'ultrasom',2);
    
    describe exame;
    
    
    -- a) Apresente o nome do cliente, o nome do animal e a espécie de todos animais cadastrados

SELECT
    c.nome,
    a.nome ,
    e.descriçao 
FROM
    cliente c
    INNER JOIN animal a
        ON (a.id_Cliente = c.id_Cliente)
    INNER JOIN especie e
        ON (a.id_Especie = e.id_Especie);

-- b) Apresente a quantidade de consultas já realizadas.

SELECT count(*) total_consultas
FROM
    consulta;

-- c) Apresente todos os veterinários que já realizaram consultas.

SELECT
    DISTINCT v.nome
FROM
    veterinario v
    INNER JOIN consulta c
        ON (v.id_Veterinario = c.id_Veterinario);

-- d) Apresente quais animais já realizou algum exame.

SELECT
    a.nome
FROM
    animal a
    INNER JOIN tratamento t
        ON (a.id_Animal = t.id_Animal)
    INNER JOIN consulta c
        ON (t.id_Tratamento = c.id_Tratamento)
WHERE
    c.id_Consulta IN (SELECT id_Consulta
                     FROM exame);

-- e) Apresente o nome do cliente e a quantidade de animais que ele possui cadastrado.
SELECT
    c.nome,
    (SELECT count(*)
     FROM animal
     WHERE animal.id_Cliente = c.id_Cliente) qtdAnimais
FROM
    cliente c;

-- f) Crie a view todas_consultas que apresente o nome do cliente, o nome do animal, o nome
--    do veterinário de todas as consultas já realizadas.

CREATE VIEW todas_consultas AS
    SELECT
        cl.nome AS cliente,
        a.nome AS animal,
        v.nome AS veterinario,
        co.historico
    FROM
        consulta co
        INNER JOIN veterinario v
            ON (co.id_Veterinario = v.id_Veterinario)
        INNER JOIN tratamento t
            ON (co.id_Tratamento = t.id_Tratamento)
        INNER JOIN animal a
            ON (a.id_Animal = t.id_Animal)
        INNER JOIN cliente cl
            ON (a.id_Cliente = cl.id_Cliente);

-- g) Utilizando a view do tópico f, apresente o nome do cliente e o nome do animal que já se
--    consultaram o veterinário Fulano da Silva

SELECT
    cliente,
    animal
FROM
    todas_consultas
WHERE
    veterinario = 'Fulano da Silva';

-- h) Crie a view não_finalizados que apresente o nome do cliente, o nome do animal e a data
--    inicial dos animais que ainda não finalizaram um tratamento.

CREATE VIEW nao_finalizados AS
    SELECT
        c.nome cliente,
        a.nome animal,
        t.data_Inicial
    FROM
        tratamento t
        INNER JOIN animal a
            ON (t.id_Animal = a.id_Animal)
        INNER JOIN cliente c
            ON (c.id_Cliente = a.id_Cliente)
    WHERE
        t.data_Final IS NULL;


-- i) Utilizando a a view não_finalizados, apresente os animais que iniciaram tratamento este mês.

SELECT
    animal
FROM
    nao_finalizados
WHERE
    month(data_Inicial) = month(current_date());
    
   
   
   
   
   