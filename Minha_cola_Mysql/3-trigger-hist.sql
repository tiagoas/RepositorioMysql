-- DROP TABLE HISTORICO_SETOR;
create table HISTORICO_SETOR
(transacao int not null primary key AUTO_INCREMENT,
 id int not null,
 SETOR_ANT varchar(50),
 SETOR_DEP varchar(50)not null,
 user varchar(50)not null,
 data datetime not null
 );
 
-- SELECT * FROM FUNCIONARIOS;
DELIMITER //
CREATE TRIGGER TG_HISTORICO_SETOR BEFORE UPDATE 
ON FUNCIONARIOS
FOR EACH ROW
BEGIN
  INSERT INTO HISTORICO_SETOR (ID,SETOR_ANT,SETOR_DEP,user,data)
     values (new.id,old.setor,new.setor,user(),now());
END//
DELIMITER ;

-- DROP TRIGGER TG_HISTORICO_SETOR

SELECT * FROM FUNCIONARIOS

UPDATE FUNCIONARIOS SET SETOR='TI Desenvolvimento'
WHERE ID='5';

SELECT * FROM HISTORICO_SETOR;

 	