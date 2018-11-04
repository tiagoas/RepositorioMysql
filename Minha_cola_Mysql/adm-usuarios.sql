--Listagem 1. Comando para verificar logins de instância

  SELECT * FROM sys.sql_logins
  SELECT * from sys.syslogins
  select * from sys.sysremotelogins
  select * from sys.remote_logins
  select * from sys.linked_logins

--Listagem 2. Comando para verificar acessos concedidos a usuários.

  SELECT          
    S.name, 
    S.loginname, 
    S.password,
    l.sid, 
    l.is_disabled, 
    S.createdate, 
    S.denylogin,
    S.hasaccess,
    S.isntname,
    S.isntgroup,
    S.isntuser,
    S.sysadmin,
    S.securityadmin,
    S.serveradmin,
    S.processadmin,
    S.diskadmin,
    S.dbcreator,
    S.bulkadmin
 FROM sys.syslogins S
  LEFT JOIN       
   sys.sql_logins L
  ON S.sid = L.sid

--Listagem 3.Comando para verificar informações básicas de usuários.

  Sp_helplogins
  Sp_helplogins 'TESTEADM'
  Sp_helplogins 'infinity\andre'

