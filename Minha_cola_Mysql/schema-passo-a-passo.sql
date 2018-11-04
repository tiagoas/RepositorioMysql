Vamos criar um schema chamado fin e adm, dentro do Banco de
Dados Curso, da inst�ncia INFINITY Para isso, siga os passos a seguir:

1. Abra o SQL Server Management Studio.
2. Na janela Object Explorer, navegue at� o Banco de Dados Curso.
3. Clique no sinal de + ao lado do Banco de Dados Curso.
4. Clique no sinal de + ao lado de Security.
5. Clique no sinal de + ao lado de Schema e observe a lista de schemas j�
definidos.
6. Clique com o bot�o direito do mouse na op��o Schema e selcione a op��o
New Schema.
7. No campo Name digite nome schema e, para o dono deste schema, vamos
especificar a role Gerentes. No campo Schema Owner digite Gerentes.
8. Clique OK. O novo schema est� criado. 

Ao criar um schema voc� poder� criar novos objetos e adicion�-los a este
schema, poder� alterar as propriedades dos objetos j� existentes, para que
passem a fazer parte deste schema e poder� atribuir permiss�es de acesso,
diretamente ao schema.

Trabalhando com Schema
O SQL Server atribuir� o novo objeto que est� sendo criado, ao schema definido
como Default schema (dbo), para o usu�rio logado.
Como exemplo vamos criar uma nova tabela (fcx) no Banco de Dados
Curso e associar esta tabela ao schema fin.
1. Selecione a op��o New Table.
2. Abra a janela de propriedades (F4).
3. Selecione Schema > fin

Para alterar o dono de um schema, siga os seguintes passos:
1. Abra o SQL Server Management Studio.
2. Localize o schema a ser alterado.
3. D� um clique duplo no schema, para abrir a janela de propriedades do schema.
4. Na janela propriedades, na Guia Geral, no campo schema Owner, basta digitar
o nome do novo dono (que pode ser um usu�rio ou uma role).
5. Clique OK.

select * from FIN.fcx

drop table FIN.fcx