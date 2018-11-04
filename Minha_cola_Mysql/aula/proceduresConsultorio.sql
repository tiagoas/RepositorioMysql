use vet_db;


# 1 - Insira um cliente e seu animal nas respectivas tabelas.

create procedure sp_insert_customer_animal (
    in nome_cliente varchar(120),
    in endereco varchar(255),
    in bairro varchar(9),
    in cep char(9),
    in cidade varchar(45),
    in estado char(2),
    in telefone char(9),
    in nome_animal varchar(120),
    in idade_animal int,
    in sexo_animal char,
    in id_especie_animal int
)
    begin
        set @customer_id = (select `auto_increment` from INFORMATION_SCHEMA.TABLES where table_name = 'cliente' and `auto_increment` is not null);
        insert into cliente values(@customer_id, nome_cliente, endereco, bairro, cep, cidade, estado, telefone);
        insert into animal values (null, nome_animal, idade_animal, sexo_animal, id_especie_animal, @customer_id);
    end;

call sp_insert_customer_animal("José Carlos Pereira", "Rua A", "Bairro B",
                               "123", "Cidade", "MG", "123456789", "Fluffy", 3, "F", 1);

# 2 - Apresente o nome do cliente e do animal que foi consultado por um determinado veterinário.

create procedure sp_atendimentos_veterinario (in id_veterinario int)
    begin
        select
            cl.nome as cliente,
            a.nome as animal
        from
            consulta co
            inner join tratamento t
                on (co.idTratamento = t.idTratamento)
            inner join animal a
                on (t.idAnimal = a.idAnimal)
            inner join cliente cl
                on (a.idCliente = cl.idCliente)
        where
            co.idVeterinario = id_veterinario;
    end;

call sp_atendimentos_veterinario(1);

# 3 - Apresente o nome do cliente e do animal que realizaram consulta no mês de setembro.

create procedure sp_atendimentos_setembro()
    begin
        select distinct
            cl.nome as cliente,
            a.nome as animal
        from
            consulta co
            inner join tratamento t
                on (co.idTratamento = t.idTratamento)
            inner join animal a
                on (t.idAnimal = a.idAnimal)
            inner join cliente cl
                on (a.idCliente = cl.idCliente)
        where
            month(co.data) = 9;
    end;

call sp_atendimentos_setembro();

# 4 - Apresente o nome do veterinário que já fez pedido de exames.

create procedure sp_veterinarios_com_exames()
    begin
        select
            v.nome
        from
            veterinario v
            inner join consulta c
                on (v.idVeterinario = c.idVeterinario)
            inner join exame e
                on (c.idConsulta = e.idConsulta);
    end;

call sp_veterinarios_com_exames();

# 5 - Atualize os dados de um cliente.

create procedure sp_atualizar_cliente(
    in id int,
    in nome varchar(120),
    in endereco varchar(255),
    in bairro varchar(9),
    in cep char(9),
    in cidade varchar(45),
    in estado char(2),
    in telefone char(9))
    begin
        update
            cliente
        set
            cliente.nome = nome,
            cliente.endereco = endereco,
            cliente.bairro = bairro,
            cliente.cep = cep,
            cliente.cidade = cidade,
            cliente.estado = estado,
            cliente.telefone =  telefone
        where
            cliente.idCliente = id;
    end;

call sp_atualizar_cliente(1, "Lucas Cesar Ferreira", "Viacast");