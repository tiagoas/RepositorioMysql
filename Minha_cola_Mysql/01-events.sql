use curso;
-- Verificando se evento esta habilitado
show variables like '%event_scheduler%';

-- Habilitanto Event

set GLOBAL event_scheduler=ON; 

-- Verificando se evento esta habilitado
show variables like '%event_scheduler%';

-- Verificando processos
SHOW PROCESSLIST;

-- Para desligar Evento
	
SET GLOBAL event_scheduler = OFF;

-- Criando tabela para teste de evento

CREATE TABLE Teste_evento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    mensagem VARCHAR(255) NOT NULL,
    data_hora DATETIME NOT NULL
);



-- Verificando eventos no banco de dados	
SHOW EVENTS FROM curso;

-- verificando a tabela
SELECT 
    *
FROM
    Teste_evento;

-- TEMPO

-- Agendamentos
/*
schedule:
    AT timestamp [+ INTERVAL interval] ...
  | EVERY interval
    [STARTS timestamp [+ INTERVAL interval] ...]
    [ENDS timestamp [+ INTERVAL interval] ...]

interval:
    quantity {YEAR | QUARTER | MONTH | DAY | HOUR | MINUTE |
              WEEK | SECOND | YEAR_MONTH | DAY_HOUR | DAY_MINUTE |
              DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND}
--exemplo de intervalo
processar a cada 2 minutos e 30 segundos
	INTERVAL '2:30' MINUTE_SECOND. 
*/
-- criando evento
CREATE EVENT evento_1
ON SCHEDULE  EVERY 1 MINUTE
STARTS CURRENT_TIMESTAMP
DO
   INSERT INTO Teste_evento(mensagem,data_hora)
   VALUES('Evento 1',NOW());
   
 -- Veerificando tabela
 select * from Teste_evento  ;
 
-- Criando outro evento
	
CREATE EVENT evento_2
ON SCHEDULE EVERY 1 MINUTE
STARTS CURRENT_TIMESTAMP
ENDS CURRENT_TIMESTAMP + INTERVAL 1 HOUR
DO
     INSERT INTO Teste_evento(mensagem,data_hora)
     VALUES('Evento 2',NOW());
     
     
-- DESABILITANDO UM ENVENTO
ALTER EVENT evento_2 DISABLE;
    
-- HABILITANDO UM ENVENTO
ALTER EVENT evento_2 ENABLE;
    

-- ALTERAR AGENDA DO EVENTO
ALTER EVENT evento_2
    ON SCHEDULE
      EVERY 12 HOUR
    DO
 INSERT INTO Teste_evento(mensagem,data_hora)
     VALUES('Evento 2',NOW());
     
-- criando tabela para simular cenarios de bloqueio de assinaturas

CREATE TABLE assinaturas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data_inicio DATE,
    data_fim DATE,
    situacao CHAR(1) DEFAULT 'A'
);
  -- INSERINDO REGISTROS
  
  INSERT INTO assinaturas(data_inicio,data_fim) values ('2018-01-01','2018-10-29');
  INSERT INTO assinaturas(data_inicio,data_fim) values ('2018-01-01','2018-10-30');
  INSERT INTO assinaturas(data_inicio,data_fim) values ('2018-01-01','2018-10-31');


SELECT 
    *
FROM
    assinaturas;

-- CRIAR EVENTO PARA BLOQUEAR ASSINATURAS COM data FIM igual dia corrente
CREATE EVENT evento_3
ON SCHEDULE EVERY 24 HOUR
STARTS '2018-10-30 23:59:00'
DO
     UPDATE ASSINATURAS SET SITUACAO='B' 
     WHERE DATA_FIM=CAST(NOW()AS DATE);
     
-- ATUALIZANDO EVENTO
ALTER EVENT evento_3
ON SCHEDULE EVERY 1 MINUTE
STARTS '2018-10-30 09:25:00'
DO
     UPDATE ASSINATURAS SET SITUACAO='B' 
     WHERE DATA_FIM=CAST(NOW()AS DATE);

--
SELECT * FROM ASSINATURAS
-- dropando todos eventos
 drop event evento_1;
 drop event evento_2;
 drop event evento_3;
 
 -- DROP TABELAS
 DROP TABLE Teste_evento;
 DROP TABLE assinaturas;