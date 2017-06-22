CREATE PROCEDURE [dbo].[sp_Indicador_Nao_Conformidade]
        @datainicio as smalldatetime,
        @datafim as smalldatetime
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @numerador FLOAT, @denominador FLOAT

	-- não conformidades
	SELECT @numerador = count(L.LB_ID)
	FROM lb_acoestomadas R INNER JOIN LB_LogBook L on L.LB_ID = R.act_lb 
	WHERE (act_tipoacao = 2) AND (LB_DATAHORAOCO BETWEEN @datainicio AND @datafim)

	-- total de ocorrencias
	SELECT @denominador = count(*)
	FROM LB_LOGBOOK
	WHERE LB_DATAHORAOCO BETWEEN @datainicio AND @datafim

	IF @denominador = 0
		SELECT @numerador AS 'numerador', @denominador AS 'denominador', 0 AS 'porcentagem'
	ELSE
		SELECT @numerador AS 'numerador', @denominador AS 'denominador', (@numerador/@denominador)*100 AS 'porcentagem'
END
