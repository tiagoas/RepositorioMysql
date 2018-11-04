-- criando tabelas para procedure atualiza estoque
use curso;
CREATE TABLE ztok 
  ( 
     cod_mat VARCHAR (20) NOT NULL, 
     saldo   DECIMAL (10, 2) NOT NULL 
  ) ;

CREATE TABLE ztok_lote 
  ( 
     cod_mat int, 
     lote    VARCHAR (15) NOT NULL, 
     saldo   DECIMAL (10, 2) NULL, 
     FOREIGN KEY (cod_mat) REFERENCES material(cod_mat), 
	  PRIMARY KEY (cod_mat,lote) 
  ) ;
  
  
CREATE TABLE mov_ztok 
  ( 
     transacao  INT PRIMARY KEY NOT NULL auto_increment, 
     mov        VARCHAR (1) NOT NULL, 
     cod_mat    int NOT NULL, 
     lote       VARCHAR (15) NOT NULL, 
     qtd        DECIMAL (10, 2) NOT NULL, 
     usuario    VARCHAR (30) NOT NULL, 
     dt_hor_mov DATETIME NOT NULL 
  ) ;

CREATE UNIQUE INDEX  ix_ztok1 on ztok(cod_mat);

ALTER TABLE mov_ztok 
  ADD FOREIGN KEY (cod_mat) REFERENCES material(cod_mat); 

