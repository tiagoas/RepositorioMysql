--realizando select
select * from openquery(link,'select * from alunos');
-- realizando insert
insert  openquery(link,'select nome from alunos') values ('Ricardo');

-- realizando update
update  openquery(link,'select nome from alunos where id_aluno=6') set nome='Richard';

-- realizando delete
delete  openquery(link,'select * from alunos where id_aluno=6');

