--VERIFICANDO SE EXISTE LINKED SERVER NO BD
SELECT * FROM   sys.servers


--CRIANDO LINKED SERVER
EXEC        sp_addlinkedserver 
            @server = 'INFINITY', 
			@srvproduct='', 
			@provider='SQLNCLI', 
			@datasrc='INFINITY\SQLEXPRESS2' 

--CRIANDO USUARIO DO  LINKED SERVER

EXEC       sp_addlinkedsrvlogin
		    @rmtsrvname='INFINITY', 
			@useself='true', 
			@locallogin='INFINITY\andre', 
			@rmtuser=NULL, 
            @rmtpassword='sua senha'



--SELECIONANDO DADOS ATRAVES DO LINKED SERVER
SELECT * FROM   INFINITY.TESTE_LINK.dbo.PESSOAS

---ATUALIZADO DADOS ATRAVES DO LINKED SERVER
UPDATE INFINITY.TESTE_LINK.dbo.PESSOAS SET NOME='TESTE UPDATE'
WHERE ID=5 

---INSERINDO DADOS ATRAVES DO LINKED SERVER
INSERT INTO INFINITY.TESTE_LINK.dbo.PESSOAS (NOME) VALUES ('JACK')

--SELECIONANDO DADOS ATRAVES DO LINKED SERVER
SELECT * FROM   INFINITY.TESTE_LINK.dbo.PESSOAS

--EXCLUINDO USUARIO LINKED SERVER

EXEC sp_droplinkedsrvlogin @rmtsrvname='INFINITY',
                           @locallogin='INFINITY\andre'

--EXCLUINDO LINKED SERVER

EXEC sp_dropserver @server=N'INFINITY', @droplogins='droplogins'