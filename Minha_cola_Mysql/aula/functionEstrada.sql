create database estradas_db;

use estradas_db;

create table cidade(
    cidadeid varchar(5),
    nome varchar(1000) not null,
    primary key (cidadeid)
);

create table estrada(
    estradaid varchar(5),
    nome varchar(100) not null,
    cidade_origem varchar(5),
    cidade_destino varchar(5),
    extensao_km int,
    primary key (estradaid),
    foreign key (cidade_origem) references cidade(cidadeid),
    foreign key (cidade_destino) references cidade(cidadeid)
);

create table trajeto(
    trajetoid varchar(5),
    cidade_origem varchar(5),
    cidade_destino varchar(5),
    extensao_km int,
    primary key (trajetoid),
    foreign key (cidade_origem) references cidade(cidadeid),
    foreign key (cidade_destino) references cidade(cidadeid)
);

create table segmento(
    trajetoid varchar(5),
    estradaid varchar(5),
    ordem int,
    primary key (trajetoid, estradaid)
);

insert into cidade values ("A","A");
insert into cidade values ("B","B");
insert into cidade values ("C","C");
insert into cidade values ("D","D");

insert into estrada values("AB", "AB", "A", "B", 10);
insert into estrada values("AD", "AD", "A", "D",  5);
insert into estrada values("BD", "BD", "B", "D", 50);
insert into estrada values("BC", "BC", "B", "C", 25);

insert into trajeto values("001", "D", "C", null);
insert into trajeto values("002", "D", "C", null);

insert into segmento values("001", "AD", 1);
insert into segmento values("001", "AB", 2);
insert into segmento values("001", "BC", 3);
insert into segmento values("002", "BD", 1);
insert into segmento values("002", "BC", 2);

-- 1
create procedure sp_consultar_extensao_trajeto(in id varchar(5))
    begin
        select
            SUM(e.extensao_km) distancia
        from
            segmento s
            inner join estrada e
            on (s.estradaid = e.estradaid)
        where
            s.trajetoid = id;
    end;

call sp_consultar_extensao_trajeto("001");

-- 2
create procedure sp_atualizar_extensao_trajeto(in id varchar(5))
    begin
        update trajeto set extensao_km = (
        select
            SUM(e.extensao_km)
        from
            segmento s
            inner join estrada e
            on (s.estradaid = e.estradaid)
        where
            s.trajetoid = id
        ) where trajeto.trajetoid = id;
    end;

call sp_atualizar_extensao_trajeto("002");

-- 3
create procedure sp_adicionar_estrada_trajeto(in id_estrada varchar(5), in id_trajeto varchar(5))
    begin
        set @ordem = (select MAX(ordem) + 1 from segmento where trajetoid = id_trajeto);
        insert into segmento values (id_trajeto, id_estrada, @ordem);
        call sp_atualizar_extensao_trajeto(id_trajeto);
    end;

insert into estrada values ("BC2", "BC2", "B", "C", 100);
call sp_adicionar_estrada_trajeto("BC2", "001");

-- 4
create procedure sp_remover_estrada_trajeto(in id_estrada varchar(5), in id_trajeto varchar(5))
    begin
        delete from segmento where segmento.estradaid = id_estrada and segmento.trajetoid = id_trajeto;
        call sp_atualizar_extensao_trajeto(id_trajeto);
    end;

call sp_remover_estrada_trajeto("BC2", "001");