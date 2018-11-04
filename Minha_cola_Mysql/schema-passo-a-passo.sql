Vamos criar um schema chamado fin e adm, dentro do Banco de
Dados Curso, da instância INFINITY Para isso, siga os passos a seguir:

1. Abra o SQL Server Management Studio.
2. Na janela Object Explorer, navegue até o Banco de Dados Curso.
3. Clique no sinal de + ao lado do Banco de Dados Curso.
4. Clique no sinal de + ao lado de Security.
5. Clique no sinal de + ao lado de Schema e observe a lista de schemas já
definidos.
6. Clique com o botão direito do mouse na opção Schema e selcione a opção
New Schema.
7. No campo Name digite nome schema e, para o dono deste schema, vamos
especificar a role Gerentes. No campo Schema Owner digite Gerentes.
8. Clique OK. O novo schema está criado. 

Ao criar um schema você poderá criar novos objetos e adicioná-los a este
schema, poderá alterar as propriedades dos objetos já existentes, para que
passem a fazer parte deste schema e poderá atribuir permissões de acesso,
diretamente ao schema.

Trabalhando com Schema
O SQL Server atribuirá o novo objeto que está sendo criado, ao schema definido
como Default schema (dbo), para o usuário logado.
Como exemplo vamos criar uma nova tabela (fcx) no Banco de Dados
Curso e associar esta tabela ao schema fin.
1. Selecione a opção New Table.
2. Abra a janela de propriedades (F4).
3. Selecione Schema > fin

Para alterar o dono de um schema, siga os seguintes passos:
1. Abra o SQL Server Management Studio.
2. Localize o schema a ser alterado.
3. Dê um clique duplo no schema, para abrir a janela de propriedades do schema.
4. Na janela propriedades, na Guia Geral, no campo schema Owner, basta digitar
o nome do novo dono (que pode ser um usuário ou uma role).
5. Clique OK.

select * from FIN.fcx

drop table FIN.fcx