-- gerenciamento

-- apresentado variaveis do MYSQL
 SHOW VARIABLES;
 
 -- filtrando por nome
 SHOW VARIABLES LIKE '%hostname%';
 
 SHOW VARIABLES LIKE 'back_log';
 
 -- alterando variavel
 -- Global
 -- apresentando
 SHOW VARIABLES LIKE 'delayed_insert_timeout';
 -- atualizando
 SET  global delayed_insert_timeout = 350;
 -- apresentando novo valor
 SHOW VARIABLES LIKE 'delayed_insert_timeout';
 
 -- sessao
  -- apresentando
 SHOW VARIABLES LIKE 'sort_buffer_size';
  -- atualizando
 SET SESSION sort_buffer_size=524288;
  -- apresentando novo valor
 SHOW VARIABLES LIKE 'sort_buffer_size';
 

 
 SHOW STATUS;
 
  -- Visualizando as conexões ativas
 
 SHOW PROCESSLIST;
 
 -- Derrubando conexões e processos presos
 
 -- KILL <numero_PID>;
 
 KILL 54;
 