############################ EXERCICIOS 6 ############################
create database produto;
use produto;
create table produto (
    cod_pro int primary key,
    valor float,
    cod_cat char(1)
);

create table aliquota (
    cod_cat char(1) primary key,
    ipi float
);

insert into produto values (1001, 120, 'A');
insert into produto values (1002, 250, 'B');

insert into aliquota values ('A', 10);
insert into aliquota values ('B', 15);

-- 1)

delimiter $$
create procedure sp_consultar_valor_reais(in cod_prod int)
    begin

        select
            (p.valor * (a.ipi  / 100)) as valor_ipi
        from
            produto p
        inner join aliquota a
            on (p.cod_cat = a.cod_cat)
        where
            p.cod_pro = cod_prod;

    end $$
delimiter ;

call sp_consultar_valor_reais(1002);

-- 2)


create table lucro(
    ano int,
    valor float
);

create table salario(
    matricula int,
    valor float,
    bonus float
);

insert into lucro values (2007, 1200000);
insert into lucro values (2008, 1500000);
insert into lucro values (2009, 1400000);

insert into salario values (1001, 2500, null);
insert into salario values (1002, 3200, null);


delimiter $$
create procedure sp_calcular_bonus()
    begin

        declare id_salario int default null;
        declare eof bool default false;
        declare salarios_calcular cursor for select matricula from salario;
        declare continue handler for not found set eof = true;

        open salarios_calcular;
        while (!eof) do

            fetch salarios_calcular into id_salario;

            set @bonus = ((select valor from lucro order by ano desc limit 1) * 0.01) +
                         ((select valor from salario where matricula = id_salario) * 0.05);

            update salario set bonus = @bonus where matricula = id_salario;

        end while;
        close salarios_calcular;
        
    end $$
    delimiter ;
   

call sp_calcular_bonus();

select * from salario;

