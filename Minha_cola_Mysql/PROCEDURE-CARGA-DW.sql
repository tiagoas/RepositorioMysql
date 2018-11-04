--PROCEDURE DE CARGAR
EXEC PROC_CARGA_DW
--CRIACAO DA PROC DE CARGA DW
USE MINIDW
GO
CREATE PROCEDURE PROC_CARGA_DW
AS
BEGIN
PRINT 'CARGA INICIADA'

	TRUNCATE TABLE  D_MATERIAL
	PRINT 'DADOS MATERIAL ELIMINADO'
	--CARGA MATERIAL
	PRINT 'INICIO CARGA MATERIAL'
	PRINT GETDATE()
	INSERT INTO D_MATERIAL
	SELECT A.COD_MAT,
		   A.DESCRICAO,
		   A.PRECO_UNIT,
		   A.ID_FOR,
		   B.DESC_TIP_MAT 
	  
	FROM MINIERP.DBO.MATERIAL A
	INNER JOIN MINIERP.DBO.TIPO_MAT B
	ON A.COD_TIP_MAT=B.COD_TIP_MAT

PRINT 'FIM CARGA MATERIAL'
PRINT GETDATE()
TRUNCATE TABLE D_CLIENTES
PRINT 'DADOS CLIENTES ELIMINADOS'
PRINT 'INICIO CARGA CLIENTES'
PRINT GETDATE()
--DIMENSAO CLIENTE
	INSERT INTO D_CLIENTES
	SELECT A.ID_CLIENTE,
		   A.RAZAO_CLIENTE,
		   A.TIPO_CLIENTE,
		   A.COD_CIDADE
		   FROM MINIERP.DBO.CLIENTES A

PRINT 'FIM CARGA CLIENTES'
PRINT GETDATE()
TRUNCATE TABLE D_FORNECEDORES
PRINT 'DADOS FORNECEDORES ELIMINADOS'
PRINT 'INICIO CARGA FORNECEDORES'
PRINT GETDATE()

--DIMENSAO FORNECEDORES
		   INSERT INTO D_FORNECEDORES
		   SELECT A.ID_FOR,
		   A.RAZAO_FORNEC,
		   A.TIPO_FORNEC,
		   A.COD_CIDADE	 
		   FROM MINIERP.DBO.FORNECEDORES A

PRINT 'FIM CARGA FORNECEDORES'
PRINT GETDATE()
TRUNCATE TABLE D_VENDEDORES
PRINT 'DADOS D_VENDEDORES ELIMINADOS'
PRINT 'INICIO CARGA D_VENDEDORES'
PRINT GETDATE()

--DIMENSAO VENDEDORES
	INSERT INTO D_VENDEDORES
	SELECT A.ID_VEND,
		   A.MATRICULA,B.NOME
	 FROM MINIERP.DBO.VENDEDORES A
	 INNER JOIN MINIERP.DBO.FUNCIONARIO B
	 ON A.MATRICULA=B.MATRICULA

PRINT 'FIM CARGA VENDEDORES'
PRINT GETDATE()
TRUNCATE TABLE D_GERENTES
PRINT 'DADOS D_GERENTES ELIMINADOS'
PRINT 'INICIO CARGA D_GERENTES'
PRINT GETDATE()
--DIMENSAO GERENTES
	INSERT INTO D_GERENTES
	SELECT A.ID_GER,
		   A.MATRICULA,B.NOME
	 FROM MINIERP.DBO.GERENTES A
	 INNER JOIN MINIERP.DBO.FUNCIONARIO B
	 ON A.MATRICULA=B.MATRICULA

PRINT 'FIM CARGA D_GERENTES'
PRINT GETDATE()
TRUNCATE TABLE D_CANAL_VENDAS
PRINT 'DADOS D_CANAL_VENDAS ELIMINADOS'
PRINT 'INICIO CARGA D_CANAL_VENDAS'
PRINT GETDATE()
 
--DIMENSAO CANAL_VENDAS
	INSERT INTO D_CANAL_VENDAS
	SELECT A.ID_CLIENTE,
	       A.RAZAO_CLIENTE,
		   A.ID_VEND,
		   A.NOME_VEND,
		   A.ID_GER,
		   A.NOME_GER
	 FROM MINIERP.DBO.V_CANAL_VENDAS A


PRINT 'FIM CARGA V_CANAL_VENDAS'
PRINT GETDATE()
TRUNCATE TABLE D_COND_PAGTO
PRINT 'DADOS D_COND_PAGTO ELIMINADOS'
PRINT 'INICIO CARGA D_COND_PAGTO'
PRINT GETDATE()
--DIMENSAO CONDICOES DE PAGTO
	INSERT INTO D_COND_PAGTO
	SELECT A.COD_PAGTO,
		   A.NOME_CP,
		   B.DIAS,
		   B.PCT,
		   B.PARC
		   --INTO D_COND_PAGTO
	 FROM  MINIERP.DBO.COND_PAGTO A
	 INNER JOIN MINIERP.DBO.COND_PAGTO_DET B
	 ON A.COD_PAGTO=B.COD_PAGTO

PRINT 'FIM CARGA D_COND_PAGTO'
PRINT GETDATE()
TRUNCATE TABLE F_FATURAMENTO
PRINT 'DADOS F_FATURAMENTO ELIMINADOS'
PRINT 'INICIO CARGA F_FATURAMENTO'
PRINT GETDATE()
--FATOS
--CRIACAO TABELA FATO DE FATURAMENTO
    INSERT INTO F_FATURAMENTO
	SELECT A.NUM_NF,
		   A.DATA_EMISSAO,
		   A.ID_CLIFOR ID_CLIENTE,
		   A.COD_MAT,
		   A.QTD,
		   A.VAL_UNIT,
		   A.TOTAL
		   FROM MINIERP.DBO.V_FATURAMENTO A

PRINT 'FIM CARGA F_FATURAMENTO'
PRINT GETDATE()
TRUNCATE TABLE F_CONTAS_RECEBER
PRINT 'DADOS F_CONTAS_RECEBER ELIMINADOS'
PRINT 'INICIO CARGA F_CONTAS_RECEBER'
PRINT GETDATE()

--CONTAS RECEBER
	INSERT INTO F_CONTAS_RECEBER
	SELECT A.ID_DOC,
		   A.ID_CLIENTE,
		   A.PARC,
		   A.DATA_VENC,
		   A.DATA_PAGTO,
		   A.VALOR,
		   A.SITUACAO,
		   A.MSG,
		   A.DIAS_ATRASO
		  FROM MINIERP.DBO.V_CONTAS_RECEBER A

	PRINT 'FIM CARGA F_CONTAS_RECEBER'
	PRINT GETDATE()
	TRUNCATE TABLE F_CONTAS_PAGAR
	PRINT 'DADOS F_CONTAS_PAGAR ELIMINADOS'
	PRINT 'INICIO CARGA F_CONTAS_PAGAR'
	PRINT GETDATE()

-- CONTAS PAGAR
	INSERT INTO F_CONTAS_PAGAR
	SELECT A.ID_DOC,
		   A.ID_FOR,
		   A.PARC,
		   A.DATA_VENC,
		   A.DATA_PAGTO,
		   A.VALOR,
		   A.SITUACAO,
		   A.MSG  
		  FROM MINIERP.DBO.V_CONTAS_PAGAR A

PRINT 'FIM CARGA F_CONTAS_PAGAR'
	PRINT GETDATE()
	TRUNCATE TABLE F_PED_VENDAS
	PRINT 'DADOS F_PED_VENDAS ELIMINADOS'
	PRINT 'INICIO CARGA F_PED_VENDAS'
	PRINT GETDATE() 

--PED_VENDAS
	INSERT INTO F_PED_VENDAS
	SELECT A.NUM_PEDIDO,
		   A.ID_CLIENTE,
		   A.COD_PAGTO,
		   A.DATA_PEDIDO,
		   A.DATA_ENTREGA,
		   A.SITUACAO,
		   A.TOTAL_PED
		   FROM MINIERP.DBO.PED_VENDAS A

	   
	PRINT 'FIM CARGA F_PED_VENDAS'
	PRINT GETDATE()
	TRUNCATE TABLE F_PED_COMPRAS
	PRINT 'DADOS F_PED_COMPRAS ELIMINADOS'
	PRINT 'INICIO CARGA F_PED_COMPRAS'
	PRINT GETDATE() 
--PED_COMPRAS
	INSERT INTO F_PED_COMPRAS
	SELECT A.NUM_PEDIDO,
		   A.ID_FOR,
		   A.COD_PAGTO,
		   A.DATA_PEDIDO,
		   A.DATA_ENTREGA,
		   A.SITUACAO,
		   A.TOTAL_PED
		   FROM MINIERP.DBO.PED_COMPRAS A

	   
	PRINT 'FIM CARGA F_PED_COMPRAS'
	PRINT GETDATE()
	TRUNCATE TABLE F_ESTOQUE
	PRINT 'DADOS F_ESTOQUE ELIMINADOS'
	PRINT 'INICIO CARGA F_ESTOQUE'
	PRINT GETDATE()
--ESTOQUE
	INSERT INTO F_ESTOQUE
	SELECT A.COD_MAT,
		   QTD_SALDO 
		FROM MINIERP.DBO.ESTOQUE A

		PRINT 'FIM CARGA F_ESTOQUE'
		PRINT GETDATE()
		TRUNCATE TABLE F_META_VENDA
		PRINT 'DADOS F_META_VENDA ELIMINADOS'
		PRINT 'INICIO CARGA F_META_VENDA'
		PRINT GETDATE()

--META
	INSERT INTO F_META_VENDA
	SELECT  A.ID_VEND,
			A.ANO,
			A.MES,
			A.VALOR
	FROM MINIERP.DBO.META_VENDAS A

 PRINT 'FIM CARGA F_META_VENDA'
	PRINT GETDATE()
	TRUNCATE TABLE F_META_VENDA_2017
	PRINT 'DADOS F_META_VENDA_2017 ELIMINADOS'
	PRINT 'INICIO CARGA F_META_VENDA_2017'
	PRINT GETDATE()
--FATO META X FATO 2017
	INSERT INTO F_META_VENDA_2017
	SELECT A.ID_VEND,
		   B.NOME_VEND,
		   A.ANO,
		   A.MES,
		   A.VALOR META,
		   SUM(ISNULL(C.TOTAL,0))REALIZ,
		   CAST(100/A.VALOR*SUM(ISNULL(C.TOTAL,0)) AS DECIMAL(10,2))PCT
	 
	  FROM MINIERP.DBO.META_VENDAS A
	  LEFT JOIN MINIERP.DBO.V_CANAL_VENDAS B
	  ON A.ID_VEND=B.ID_VEND
	  LEFT JOIN  MINICRM.DBO.V_CRM_FAT_RESUMO C
	  ON B.ID_CLIENTE=C.ID_CLIFOR
	  AND A.MES=C.MES
	  AND A.ANO=C.ANO
	  WHERE A.ANO=2017
	  GROUP BY  A.ID_VEND,
		   B.NOME_VEND,
		   A.ANO,
		   A.MES,
		   A.VALOR,
		   100/A.VALOR

 PRINT 'FIM CARGA F_META_VENDA_2017'
	PRINT GETDATE()
	TRUNCATE TABLE F_AGENDAS_RESUMO
	PRINT 'DADOS F_AGENDAS_RESUMO ELIMINADOS'
	PRINT 'INICIO CARGA F_AGENDAS_RESUMO'
	PRINT GETDATE()


--CRM
--AGENDAS RESUMO
	INSERT INTO F_AGENDAS_RESUMO
	SELECT A.MATRICULA,
		   A.NOME_VEND,
		   A.RAZAO_CLIENTE,
		   A.SITUACAO,
		   A.QTD_VISITAS,
		   A.GEROU_VENDA 
	FROM MINICRM.DBO.V_CRM_AGENDAS_RESUMO A

--AGENDA DETALHE

    PRINT 'FIM CARGA F_AGENDAS_RESUMO'
	PRINT GETDATE()
	TRUNCATE TABLE F_AGENDA_DETALHE
	PRINT 'DADOS F_AGENDA_DETALHE ELIMINADOS'
	PRINT 'INICIO CARGA F_AGENDA_DETALHE'
	PRINT GETDATE()
    INSERT INTO F_AGENDA_DETALHE
	SELECT A.ID_AGENDA,
		   A.MATRICULA,
		   A.NOME_VEND,
		   A.RAZAO_CLIENTE,
		   A.DATA_VISITA,
		   A.SITUACAO,
		   1 QTD_VISITAS,
		   A.GEROU_VENDA 
	FROM MINICRM.DBO.V_CRM_AGENDAS_DETALHE A

PRINT 'FIM CARGA F_AGENDA_DETALHE'
	PRINT GETDATE()

END