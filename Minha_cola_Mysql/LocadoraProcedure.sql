
-- 3)

delimiter $$
create procedure sp_clientes_sem_locacao()
    begin
        select
            distinct c.name
        from
            customers c
        left join
            locations l
            on (c.id = l.id_customers)
            and (l.id is null);
    end $$;
    delimiter;