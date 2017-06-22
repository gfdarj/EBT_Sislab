CREATE PROCEDURE [dbo].[SP_Indicador_Eficiencia_Geral] 
AS
BEGIN
	DECLARE @numerador AS float, @denominador AS float, @porcentagem AS float

	DELETE FROM auxilio_eficiencia where tipo = 'G'

	SELECT @numerador= Count(distinct A.AG_Numero) 
	FROM Historico_Eventos H INNER JOIN Agendamento A on A.AG_Numero = H.AG_numero
	Where (dateadd(day, 1, A.AG_DATATERMINO) >= H.HE_DataTermino and H.Id_Situacao = 8)
	or 7 in (SELECT Id_Situacao FROM Historico_Eventos where AG_numero = A.AG_Numero)

	SELECT @denominador = Count (distinct A.AG_Numero) 
	FROM Historico_Eventos H INNER JOIN Agendamento A on A.AG_Numero = H.AG_numero
	Where H.Id_Situacao = 8

	set @porcentagem = (@numerador/@denominador)*100

	INSERT INTO auxilio_eficiencia (numerador,denominador,porcentagem,tipo) 
	values (@numerador, @denominador, @porcentagem, 'G')

	/*PRINT CAST(@numerador AS varchar) + ' Agendamentos terminaram no prazo.'
	PRINT CAST(@denominador AS varchar) + ' Agendamentos foram finalizados.'
	set @porcentagem = (@numerador/@denominador)*100
	PRINT 'A média de eficiência é de ' + CAST(@porcentagem AS varchar) + '%'
	*/
END
