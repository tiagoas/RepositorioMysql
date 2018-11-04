-- Parte 1 CONCEDE-GRANT
-- Cria um login "ALUNO' e dar permissões no banco e objetos

-- Concedendo Acesso DE ATUALIZACAO PARA ALUNO.
GRANT UPDATE  ON FUNCIONARIOS TO 'ALUNO'@'localhost';


-- Concedendo Acesso DE UPDATE PARA ALUNO EM TODOS OBJETOS
GRANT UPDATE  ON *.* TO 'ALUNO'@'localhost';


-- Concedendo Acesso DE DELETE PARA ALUNO.
GRANT DELETE  ON FUNCIONARIOS TO 'ALUNO'@'localhost';


-- Concedendo Acesso DE DELETE PARA ALUNO EM TODOS OBJETOS
GRANT DELETE  ON *.* TO 'ALUNO'@'localhost';


-- Concedendo Acesso DE INSERT PARA ALUNO.
GRANT INSERT  ON FUNCIONARIOS TO 'ALUNO'@'localhost';


-- Concedendo Acesso DE SELECT  PARA ALUNO.
GRANT SELECT  ON FUNCIONARIOS TO 'ALUNO'@'localhost';


-- Concedendo Acesso DE SELECT e INSERT PARA ALUNO.
GRANT SELECT, INSERT ON FUNCIONARIOS TO 'ALUNO'@'localhost';


-- Concedendo select com limitação de campos
GRANT SELECT (NOME,SETOR) ON FUNCIONARIOS TO 'ALUNO'@'localhost';


-- Concedendo Acesso PARA EXCUTAR PROC proc_quadrado PARA ALUNO.
GRANT EXECUTE ON PROCEDURE TESTE.proc_quadrado TO 'ALUNO'@'localhost';  


-- CONCENDENDO TODOS ACESSOS A TODOS OBJETOS
GRANT ALL PRIVILEGES ON FUNCIONARIOS TO 'ALUNO'@'localhost';


-- CONCENDENDO TODOS ACESSOS A TODOS OBJETOS
GRANT ALL PRIVILEGES ON * . * TO 'ALUNO'@'localhost';



-- RECARRAGANDO PREVILEGIOS
FLUSH PRIVILEGES;


select * from mysql.user where User='ALUNO';