-- Atenção antes de criar a procedure excute este arquivo tabelas_estoque.sql
-- drop procedure proc_atualiza_estoque
-- objetivo atualizar ou inserir dados nas tabelas ztok e ztok_lote e gravar dados
-- na tabela mov_ztok para gera razao de movimento
-- as tabelas deve manter os saldo consistentes entre elas
DELIMITER //
Create PROCEDURE proc_atualiza_estoque (tipo_mov VARCHAR(1),
                                        p_cod_mat  VARCHAR(50),
                                        p_lote     VARCHAR(15), 
                                        p_qtd_mov  DECIMAL(10, 2))  

main: begin
      
      DECLARE cod_erro CHAR(5) DEFAULT '00000';
      DECLARE msg TEXT;
	   DECLARE rows INT;
      DECLARE result TEXT;
      DECLARE saldo_estoque decimal(10,2) default 0;
      DECLARE saldo_lote decimal(10,2) default 0;
      DECLARE reg_z  int default 0; -- variavel de registros em estoque
	   DECLARE reg_zl int default 0; -- variavel de registros em estoque lote
      
      DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    	BEGIN
	      GET DIAGNOSTICS CONDITION 1
	      cod_erro = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
      END;
      -- verificando se operacao permitida e valor >0
		IF tipo_mov not in ('E','S') or p_qtd_mov<1
			THEN
				SELECT 'Operacao invalida ou valor menor que 1' AS ERRO;
				LEAVE main;
		END IF;
      -- verificando se o material existe cadastro 
      IF (SELECT Count(*) 
          FROM   material where cod_mat=p_cod_mat) = 0 THEN
		SELECT 'Material nao existe!' AS ERRO;
				LEAVE main;
		END IF;
		-- atribuindo saldo de estoque do material na variavel saldo_estoque
      SELECT SALDO INTO saldo_estoque FROM ZTOK
      where cod_mat=p_cod_mat;
      -- atribuindo saldo de estoque lote do material na variavel saldo_lote	
      SELECT saldo INTO saldo_lote FROM ZTOK_LOTE
      where cod_mat=p_cod_mat
      AND lote=p_lote;
      -- verificando se estoque ficara negativo
      IF tipo_mov='S' and saldo_estoque <p_qtd_mov THEN
		  SELECT 'Estoque Negativo, operacao Cancelada' AS ERRO;
				LEAVE main;
		END IF;
        -- verificando se estoque lote ficara negativo 
         IF tipo_mov='S' and saldo_lote <p_qtd_mov THEN
		SELECT 'Estoque Negativo, operacao Cancelada' AS ERRO;
				LEAVE main;
		END IF;
      
      START TRANSACTION;
		-- verifcando se o material ja tem registro na tabela ztok
	  SELECT SQL_CALC_FOUND_ROWS cod_mat FROM ZTOK where cod_mat=p_cod_mat;
     SELECT FOUND_ROWS() into reg_z;
      -- verifcando se o material ja tem registro na tabela ztok_lote
	  SELECT SQL_CALC_FOUND_ROWS cod_mat FROM ZTOK_LOTE where cod_mat=p_cod_mat
        AND lote=p_lote;
      SELECT FOUND_ROWS() into reg_zL;
      -- VERIFICACAOES
            IF (tipo_mov = 'S') then 
              -- ATUALIZAR
              update ZTOK set saldo=saldo-p_qtd_mov
              where  cod_mat=p_cod_mat;
              
              update ZTOK_lote set saldo=saldo-p_qtd_mov
              where  cod_mat=p_cod_mat
              and lote=p_lote;
              
              insert into mov_ztok
				   (mov,cod_mat,lote,qtd,usuario,dt_hor_mov) 
                values 
               (tipo_mov,p_cod_mat,p_lote,p_qtd_mov,user(),now());
              -- ENTRADA
              elseif (tipo_mov = 'E' and reg_z=1 and reg_zl=1) then
              -- atualiza saldo ztok
					update ZTOK set saldo=saldo+p_qtd_mov
					where  cod_mat=p_cod_mat;
              -- atualiza saldo ztok_lote
              update ZTOK_lote set saldo=saldo+p_qtd_mov
              where  cod_mat=p_cod_mat
              and lote=p_lote;
              -- insere valores na mov ztok
              insert into mov_ztok
				   (mov,cod_mat,lote,qtd,usuario,dt_hor_mov) 
                values 
               (tipo_mov,p_cod_mat,p_lote,p_qtd_mov,user(),now());
          -- verifica entrada se existe na ztok e nao existe na ztok_lote    
			elseif (tipo_mov = 'E' and reg_z=1 and reg_zl=0) then
					update ZTOK set saldo=saldo+p_qtd_mov
					where  cod_mat=p_cod_mat;
					-- NAO EXISTE NAO REALIZAR INSERT
              		insert into ztok_lote (cod_mat,lote,saldo)
						values
					  (p_cod_mat,p_lote,p_qtd_mov);
					  -- INSERT MOV ZTOK
					insert into mov_ztok
				(mov,cod_mat,lote,qtd,usuario,dt_hor_mov) 
                values 
                (tipo_mov,p_cod_mat,p_lote,p_qtd_mov,user(),now());
          -- verifica mov entrada ,nao existe na ztok e nao existe na ztok_lote        	
		elseif (tipo_mov = 'E' and reg_z=0 and reg_zl=0) then
					   -- INSERT
						insert into ZTOK (cod_mat,saldo)
						values
						(p_cod_mat,p_qtd_mov);

              		insert into ztok_lote (cod_mat,lote,saldo)
						values
					(p_cod_mat,p_lote,p_qtd_mov);
					-- INSERT MOVTO
					insert into mov_ztok
				   (mov,cod_mat,lote,qtd,usuario,dt_hor_mov) 
                values 
                (tipo_mov,p_cod_mat,p_lote,p_qtd_mov,user(),now());
		end if;
		
        
        IF cod_erro = '00000' THEN
    	  GET DIAGNOSTICS rows = ROW_COUNT;
		  SET result = CONCAT('Atualizacao com Sucesso  = ',rows);
	ELSE
		SET result = CONCAT('Erro na atualizacao, error = ',cod_erro,', message = ',msg);
  END IF;
  -- retorno do que aconteceu
  SELECT result;
  
   if cod_erro='00000' then 
		commit;
	else
		rollback;
   end if;
   end//
DELIMITER ;

/*
--param 1 mov - S saida E entrada
--param 2 cod_mat
--param 3 lote
--param 4 quantidade
*/
call proc_atualiza_estoque('E',2,'XYZ',9);

select * from ztok;
select * from ztok_lote;
select * from mov_ztok;
-- consultando
select * from material;

/*
--EXEC Atualiza_estoque S,2,QAZ,3

select * from stok;
select * from stok_lote;
select * from mov_stok;
*/
