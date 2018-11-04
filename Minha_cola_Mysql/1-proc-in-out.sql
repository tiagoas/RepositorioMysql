-- exemplo valor passado na variavel ira refletir no valor da variavel externa

delimiter // 
CREATE PROCEDURE proc_aumento(INOUT valor DECIMAL(10,2), 
                 taxa         DECIMAL(10,2)) 
begin 
  SET valor=valor+valor*taxa/100;
END // 
delimiter ;


-- testando: criando variavel externa e passando parametro para modificação

SET @valor=50.00;
select @valor;

-- executando procedure
call proc_aumento(@valor,25.00);

-- verificando o valor da variavel
select @valor;
