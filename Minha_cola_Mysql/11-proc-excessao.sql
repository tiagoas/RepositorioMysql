-- criando tabela para teste
CREATE TABLE cad_cli (
   cod_cli INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
   nome_cli VARCHAR(20) NOT NULL,
  PRIMARY KEY (cod_cli)
);

-- criando exemplo de procedure para tratar erro

DELIMITER //
CREATE PROCEDURE proc_trata_exc(IN var_nome_cli VARCHAR(100), OUT resposta VARCHAR(50))
SALVAR:BEGIN
      -- setando variavel com zero default
		DECLARE excecao SMALLINT DEFAULT 0;
		-- caso ocorra erro setar a variavel excessao = 1
		DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET excecao = 1;
		-- inicia transacao
		START TRANSACTION;
		-- insert de valores
				INSERT INTO cad_cli (cod_cli, nome_cli) VALUES (NULL, var_nome_cli);
		-- checando excessao com IF
		IF excecao = 1 THEN
				SET resposta = 'Erro ao gravar dados';
				ROLLBACK;
				LEAVE SALVAR;
		ELSE
				SET resposta = 'Salvo com sucesso!';
				COMMIT;
		END IF;
END//
DELIMITER ;

-- testa ok
CALL proc_trata_exc ('Jose',@resposta);
select @resposta;

-- teste para dar erro
CALL proc_trata_exc ('Pedro de Alcantara Machado neto Rodrigues',@resposta);
select @resposta;

-- verificando dados
select * from cad_cli;
/*
drop table cad_cli;
drop procedure proc_trata_exc;
*/