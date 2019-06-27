select * from ambientes


select distinct eq_localizacao from sce_equipamentos

select * from sce_equipamentos
where 
	eq_localizacao = 'CERT09AAP01'


select distinct eq_localizacao, 'FUNCRT-' + eq_localizacao
from sce_equipamentos
where 
	eq_localizacao is not null
	and LEFT(eq_localizacao, 3) <> 'CRT'
union
select distinct eq_localizacao, 'FUNCRT-' + SUBSTRING(eq_localizacao, 4, LEN(eq_localizacao))
from sce_equipamentos
where 
	eq_localizacao is not null
	and LEFT(eq_localizacao, 3) = 'CRT'


select * from sce_reserva
select * from SCE_Reserva_Equipamentos

begin transaction

update sce_equipamentos
set eq_localizacao = NULL
where 
	eq_localizacao is not null
	AND eq_localizacao = ''


update sce_equipamentos
set eq_localizacao = 'CRT09AAP01'
where 
	eq_localizacao = 'CERT09AAP01'


update sce_equipamentos
set eq_localizacao = 'FUNCRT-' + eq_localizacao 
where 
	eq_localizacao is not null
	and LEFT(eq_localizacao, 3) <> 'CRT'

update sce_equipamentos
set eq_localizacao = 'FUNCRT-' + SUBSTRING(eq_localizacao, 4, LEN(eq_localizacao))
where 
	eq_localizacao is not null
	and LEFT(eq_localizacao, 3) = 'CRT'

rollback transaction
commit transaction
