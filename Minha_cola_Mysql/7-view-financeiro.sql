
create view v_financeiro
as
select a.num_nota,
       a.id_cliente,
       d.nome,
		 a.id_pagto,
		 b.descricao,
		 b.tipo,
       a.total_nf,
		 a.data_nf,
		 c.parcela,
		 c.percentual,
		 c.dias,
		 cast(a.total_nf/100*c.percentual as decimal(10,2)) valor_parcela,
		 cast(date_add(a.data_nf,interval c.dias day) as date) vencimento
from nota_fiscal a
inner join cond_pagto b
on a.id_pagto=b.id_pagto
inner join cond_pagto_det c
on a.id_pagto=b.id_pagto
and a.id_pagto=c.id_pagto
inner join clientes d
on a.id_cliente=d.id_cliente
where a.status_nf='N'

-- view

select * from v_financeiro
