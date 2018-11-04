--Verificando se existe estat�sticas em uma tabela
USE CURSO
EXEC sp_helpstats 'alunos', 'all'

--Ao executar o Select, teoricamente for�ar� o SQL Server a ]
--criar um plano de execu��o e como n�o existe nenhuma estat�stica 
--para a tabela, internamente e automaticamente ser� criada para o predicado.

select * from alunos
where NOME NOT like ('Gustavo%')


--VERIFICANDO STATISTICS
EXEC sp_helpstats 'alunos', 'all'

--verificando tabela de estatisticas
SELECT * FROM sys.stats 
WHERE object_id = OBJECT_ID('alunos')



--Estat�sticas criadas implicitamente
--� quando criamos um �ndice � seja ele clustered ou n�o � 
--e por consequ�ncia s�o criadas estat�sticas implicitamente para os 
--campos chaves do �ndice.

ALTER TABLE campeonato
ADD CONSTRAINT pk_time PRIMARY KEY CLUSTERED (nometime)

--VERIFICANDO STATISTICS
EXEC sp_helpstats 'campeonato', 'all'
--Estat�sticas cridas manualmente
--Tamb�m podemos cri�-las manualmente, utilizando o comando CREATE STATISTICS

CREATE STATISTICS St_id_nome
ON alunos (id_aluno,nome);

--VERIFICANDO STATISTICS
EXEC sp_helpstats 'alunos', 'all'
--
CREATE STATISTICS st_time_pontos
ON campeonato (pontos);

--VERIFICANDO STATISTICS
EXEC sp_helpstats 'campeonato', 'all'

--Atualizando estat�sticas de uma tabela
UPDATE STATISTICS alunos
UPDATE STATISTICS campeonato
�


--apagando statistics
--DROP STATISTICS tabela.nome_stats
DROP STATISTICS alunos._WA_Sys_00000002_3B40CD36

--Atualizando estat�stica do banco todo
sp_updatestats





