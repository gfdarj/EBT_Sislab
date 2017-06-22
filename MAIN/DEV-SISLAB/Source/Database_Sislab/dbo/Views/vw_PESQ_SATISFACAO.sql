CREATE VIEW [dbo].[vw_PESQ_SATISFACAO]
AS
	select 
		case
			when PSQ_R11 = 5 then 'Muito Satisfeito'
			when PSQ_R11 = 4 then 'Satisfeito'
			when PSQ_R11 = 3 then 'Indiferente'
			when PSQ_R11 = 2 then 'Insatisfeito'
			when PSQ_R11 = 1 then 'Muito Insatisfeito'
			when PSQ_R11 is null then 'NÃO RESPONDIDO'
		end as [Tipo],
		case
			when PSQ_R11 = 5 then count(PSQ_R11)
			when PSQ_R11 = 4 then count(PSQ_R11) 
			when PSQ_R11 = 3 then count(PSQ_R11) 
			when PSQ_R11 = 2 then count(PSQ_R11) 
			when PSQ_R11 = 1 then count(PSQ_R11) 
			when PSQ_R11 is null then count(*)
		end as [indice]
	from pesquisaSatisfacao
	where PSQ_R11 is not null  
	Group by PSQ_R11

	union

	select 'Respostas' as Tipo, count(*) as indice
	from pesquisaSatisfacao
	where PSQ_R11 is not null