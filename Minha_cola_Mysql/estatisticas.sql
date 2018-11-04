--Verificando se existe estatísticas em uma tabela
USE CURSO
EXEC sp_helpstats 'alunos', 'all'

--Ao executar o Select, teoricamente forçará o SQL Server a ]
--criar um plano de execução e como não existe nenhuma estatística 
--para a tabela, internamente e automaticamente será criada para o predicado.

select * from alunos
where NOME NOT like ('Gustavo%')


--VERIFICANDO STATISTICS
EXEC sp_helpstats 'alunos', 'all'

--verificando tabela de estatisticas
SELECT * FROM sys.stats 
WHERE object_id = OBJECT_ID('alunos')



--Estatísticas criadas implicitamente
--É quando criamos um índice – seja ele clustered ou não – 
--e por consequência são criadas estatísticas implicitamente para os 
--campos chaves do índice.

ALTER TABLE campeonato
ADD CONSTRAINT pk_time PRIMARY KEY CLUSTERED (nometime)

--VERIFICANDO STATISTICS
EXEC sp_helpstats 'campeonato', 'all'
--Estatísticas cridas manualmente
--Também podemos criá-las manualmente, utilizando o comando CREATE STATISTICS

CREATE STATISTICS St_id_nome
ON alunos (id_aluno,nome);

--VERIFICANDO STATISTICS
EXEC sp_helpstats 'alunos', 'all'
--
CREATE STATISTICS st_time_pontos
ON campeonato (pontos);

--VERIFICANDO STATISTICS
EXEC sp_helpstats 'campeonato', 'all'

--Atualizando estatísticas de uma tabela
UPDATE STATISTICS alunos
UPDATE STATISTICS campeonato
 


--apagando statistics
--DROP STATISTICS tabela.nome_stats
DROP STATISTICS alunos._WA_Sys_00000002_3B40CD36

--Atualizando estatística do banco todo
sp_updatestats





