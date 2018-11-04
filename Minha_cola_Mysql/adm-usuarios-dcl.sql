USE CURSO
--alterando para usuario TESTEADM
SETUSER 'TESTEADM'

select SYSTEM_USER
--testando select 
select * from funcionarios

--testando insert 
insert into funcionarios values ('Jack',800,'RH')

--testando delete
delete from FUNCIONARIOS

--testando update
update  FUNCIONARIOS set salario=salario*1.15

--voltar usuario que logou
SETUSER 

select SYSTEM_USER
--alterando para usuario TESTEADM
SETUSER 'TESTEADM'

  --Usuários a nível de Banco de dados

--COMANDO DCL 
GRANT SELECT, UPDATE ON funcionarioS TO TESTEADM

GRANT SELECT, UPDATE, DELETE ON funcionarioS TO TESTEADM

REVOKE UPDATE,SELECT ON funcionarioS TO TESTEADM

DENY SELECT, UPDATE, DELETE ON funcionarioS TO TESTEADM

--alterando para usuario TESTEADM
SETUSER 'TESTEADM'


SELECT * FROM funcionarioS