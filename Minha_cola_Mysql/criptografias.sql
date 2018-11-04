
-- funcao MD5
select md5('abcdef1234') retorno;

-- criando tabela para teste

 create table usuario
 (
  id_usuario int not null auto_increment,
  nome varchar(20),
  senha varchar(32),
  primary key (id_usuario)
  );
  
-- inserindo registros
insert into usuario (nome,senha) values ('Andre',md5('123456'));

-- verifando senha

select * from usuario

-- atualizando a senha
update usuario set senha=md5('654321abdc')
where id_usuario='1'; 


-- mesma criptografia sha e sha1
select sha('123456')  as sha,
       sha1('123456') as sha1
       

 -- sha2 hashs -- (SHA-224, SHA-256, SHA-384, and SHA-512)
    SELECT SHA2('abc', 224) as hash224,
		     SHA2('abc', 256) as hash256,
           SHA2('abc', 384) as hash384,
           SHA2('abc', 512) as hash516;



 -- sha2 hashs -- (SHA-224, SHA-256, SHA-384, and SHA-512)
    SELECT BIT_LENGTH(SHA2('abc', 224)) as hash224,
		   BIT_LENGTH(SHA2('abc', 256)) as hash256,
           BIT_LENGTH(SHA2('abc', 384))as hash384,
           BIT_LENGTH(SHA2('abc', 512))as hash516



 -- sha2 hashs -- (SHA-224, SHA-256, SHA-384, and SHA-512)
    SELECT LENGTH(SHA2('abc', 224)) as hash224,
		   LENGTH(SHA2('abc', 256)) as hash256,
           LENGTH(SHA2('abc', 384))as hash384,
           LENGTH(SHA2('abc', 512))as hash516
