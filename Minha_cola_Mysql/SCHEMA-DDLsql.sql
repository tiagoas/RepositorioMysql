-- Criando Schema para a área de Finaceira
use curso
CREATE SCHEMA FIN
GO

-- Criando Schema para a área de administrativa 
CREATE SCHEMA ADM
GO

--DROP TABLE financeiro.fluxo_de_caixa
-- Criando tabela fluxo_de_caixa no Schema FIN
CREATE TABLE FIN.fluxo_de_caixa(
	id int NULL,
	clif_for varchar(50) NULL,
	valor decimal(18, 0) NULL,
	data date NULL
) 
--TESTE DE SELECT NO SCHEMA FIN
select * from FIN.fluxo_de_caixa

/* Alterando o Schema da tabela fluxo_de_caixa. */

use curso
go
ALTER SCHEMA ADM TRANSFER FIN.fluxo_de_caixa
GO

--TESTE DE SELECT NO SCHEMA ADM
select * from ADM.fluxo_de_caixa


--DROP SCHEMAS
drop schema FIN
drop schema ADM

--DROP TABLE
DROP TABLE ADM.fluxo_de_caixa


--VERIFICANDO TODOS SCHEMAS
select * from sys.schemas 