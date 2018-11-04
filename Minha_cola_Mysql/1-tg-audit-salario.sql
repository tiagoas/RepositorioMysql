
-- criando tabela para trigger
create table auditoria_salario
	( id int not null primary key auto_increment,
	  id_func int,
     salario_antes decimal(10,2)not null,
     salario_depois decimal(10,2) not null,
     usuario varchar(30) not null,
     data datetime not null
     );
     
   -- analisando dados
   select * from funcionarios;

  
-- criando trigger com evento apos update na tabela funcionario
CREATE TRIGGER tg_audit_sal after UPDATE 
ON funcionarios 
FOR EACH row 
  INSERT INTO auditoria_salario 
              (id_func,salario_antes,salario_depois,usuario,data) 
               VALUES      
  				  (new.id,old.salario,new.salario,User(), Now());


  -- testando a trigger
	update funcionarios set salario=salario*1.10;
    
    select * from auditoria_salario;
    
    SHOW TRIGGERS;
    
   
    
    -- DROP TRIGGER tg_audit_sal
    -- drop table auditoria_salario
       
    
     
