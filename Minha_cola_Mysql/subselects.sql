-- subselect

-- descobrir todos atores que fizeram o filme com seguintes parametros
-- film_id= 1 com tile= ACADEMY DINOSAUR
-- conhecer a estrura das tabelas alvo

use sakila;

select * from actor;
select * from film_actor;
select * from film; 

select * from actor
where actor_id in (select actor_id from film_actor 
where film_id='1');


-- descobrir quais filmes actor Penelope Guiness fez
-- parametros actor_id = 1

select * from film
where film_id in (select film_id from film_actor 
	where actor_id='1');
    

-- descobrir qual filmes actor Penelope Guiness fez
-- parametros actor_id = 1 e rating='PG'

select * from film
where film_id in (select film_id from film_actor 
	where actor_id='1')
and  rating='PG';


-- descobrir qual filmes actor Penelope Guiness fez
-- parametros NOT IN actor_id = 1 e rating='PG'

select * from film
where film_id not in (select film_id from film_actor 
	where actor_id='1' and rating='PG');



-- descobrir quantas cidades tem cada pais
-- conhecendo a estrutura das tabelas alvo
 select * from country;
 select * from city;

 select a.country_id,a.country,
 (select count(*) from city b 
  where a.country_id=b.country_id) as qtda
 from country a;

 -- Calcula total populacao do pais pela tabela cidade
 -- com subselec trazer o nome do pais e filtra por linguas
 -- conhecendo as tabelas
 use world;
 
 select * from city;
 select * from country;
 select * from countrylanguage;
 
 
 select a.countrycode,sum(a.population)as total_pop,
 (select name from country b where a.countrycode=b.code) as pais
 from city a
 where a.countrycode in (select c.countrycode from countrylanguage c
   where language='Spanish')
 group by a.countrycode;
 
 -- outra solucão para mesmo problema
 
 select a.countrycode,sum(a.population)as total_pop,
 b.name
 from city a
 inner join country b 
 on	a.countrycode=b.code
 inner join countrylanguage c
 on a.countrycode=c.countrycode 
   where language='Spanish'
 group by a.countrycode,b.name;
 
 
 