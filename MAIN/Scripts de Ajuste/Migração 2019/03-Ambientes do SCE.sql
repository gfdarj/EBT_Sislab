/* faz o ajuste dos dados da tabela ambientes */

BEGIN TRANSACTION

INSERT INTO CentroReferencia (ID_CRT, NM_CRT, SIGLA_CRT) VALUES (1, 'CRT FUNDÃO', 'FUN')
GO
INSERT INTO CentroReferencia (ID_CRT, NM_CRT, SIGLA_CRT) VALUES (2, 'CRT MORUMBI', 'MRB')
GO
INSERT INTO CentroReferencia (ID_CRT, NM_CRT, SIGLA_CRT) VALUES (3, 'CRT CAMPINAS', 'CPS')
GO


UPDATE AMBIENTES SET AMB_MODULO = 1, ID_CRT = 1
GO


UPDATE SCE_EQUIPAMENTOS
	SET EQ_LOCALIZACAO = NULL
	WHERE 
		EQ_LOCALIZACAO IS NOT NULL
		AND (EQ_LOCALIZACAO = '' OR EQ_LOCALIZACAO = ' ')
GO

UPDATE SCE_EQUIPAMENTOS
	SET EQ_LOCALIZACAO = 'CRT09AAP01'
	WHERE 
		EQ_LOCALIZACAO = 'CERT09AAP01'
GO


INSERT INTO AMBIENTES
	SELECT DISTINCT EQ_LOCALIZACAO, 0 AS 'AMB_USADOPORAG', 2 AS AMB_MODULO, 1 AS 'ID_CRT'
	FROM SCE_EQUIPAMENTOS
GO


UPDATE SCE_Equipamentos
SET AMB_ID = amb.AMB_ID
FROM 
	SCE_Equipamentos e 
	INNER JOIN Ambientes amb ON e.EQ_LOCALIZACAO = amb.AMB_NOME
WHERE
	amb.AMB_MODULO = 2 AND amb.ID_CRT = 1


UPDATE UserCRT SET ID_CRT = 1
GO


ROLLBACK TRANSACTION
COMMIT TRANSACTION



/*

select * from ambientes

select --amb.AMB_NOME, 
		e.*
	from 
		SCE_Equipamentos e inner join Ambientes amb ON e.EQ_LOCALIZACAO = amb.AMB_NOME
	where
		amb.AMB_MODULO = 2 and amb.ID_CRT = 1
--	order by EQ_LOCALIZACAO
except 
	select *
	from 
		SCE_Equipamentos e 
	where EQ_LOCALIZACAO is not null
--order by EQ_LOCALIZACAO

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
*/
