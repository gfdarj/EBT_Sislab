--DROP PROCEDURE dbo.sp_IndiceRetornoSatisfacao
--GO
--CREATE PROCEDURE dbo.sp_IndiceRetornoSatisfacao
CREATE PROCEDURE [dbo].[sp_IndiceRetornoSatisfacao]
	@ta_id INT,
	@tec_id INT,
	@chr_Rat VARCHAR(20),
	@chr_Rt VARCHAR(20),
	@dtt_Inicio DATETIME,
	@dtt_Final DATETIME
AS
BEGIN
	SET NOCOUNT ON

	CREATE TABLE #TabFinalizado (
		ag_numero INT
	)

	DECLARE @int_Finalizado NUMERIC(15,2),
		@id_Finalizado INT,
		@int_Pesquisa NUMERIC(15,2),
		@int_IndiceRetorno NUMERIC(15,2),
		@int_ERRO INT

	SELECT @id_Finalizado = id_Situacao FROM Situacoes WHERE s_descricao = 'Finalizado' AND s_os = 0

	-- seleciona os agendamentos finalizados
	INSERT INTO #TabFinalizado
		SELECT
			ag_numero
		FROM
			vw_Agendamento A
		WHERE
			A.id_Situacao = @id_Finalizado
			AND
			(@ta_id IS NULL OR @ta_id = A.ta_id)
			AND
			(@chr_Rt IS NULL OR @chr_Rt = A.ag_responsavel)
			AND
			(@chr_Rat IS NULL OR @chr_Rat = A.ag_rat)
			AND
			(@tec_id IS NULL OR @tec_id = A.tec_id)
			AND
			(A.ag_datatermino BETWEEN @dtt_Inicio AND @dtt_Final)

	SELECT @int_Finalizado = @@ROWCOUNT, @int_ERRO = @@ERROR

	IF @int_ERRO <> 0
	BEGIN
		SELECT 1 AS ERRO, NULL AS INDICE, @int_Finalizado AS TOTALAGENDAMENTO, NULL AS TOTALPESQUISA
		RETURN 1
	END

	IF @int_Finalizado = 0
	BEGIN
		SELECT 0 AS ERRO, NULL AS INDICE, @int_Finalizado AS TOTALAGENDAMENTO, NULL AS TOTALPESQUISA
		RETURN 0
	END


	IF @dtt_Inicio IS NULL SET @dtt_Inicio = '1980-01-01 00:00'
	IF @dtt_Final IS NULL SET @dtt_Final = GETDATE()


	SELECT
		@int_Pesquisa = COUNT(DISTINCT psq_nag)
	FROM
		PesquisaSatisfacao P
	WHERE
		EXISTS (SELECT ag_numero FROM #TabFinalizado WHERE ag_numero = P.psq_nag)
		--AND
		--P.psq_datahoracadastro BETWEEN @dtt_Inicio AND @dtt_Final


	SET @int_IndiceRetorno = (@int_Pesquisa * 100) / @int_Finalizado

	DROP TABLE #TabFinalizado

	SELECT 0 AS ERRO, CAST(@int_IndiceRetorno AS VARCHAR) + '%' AS INDICE, @int_Finalizado AS TOTALAGENDAMENTO, @int_Pesquisa AS TOTALPESQUISA
	RETURN 0
END
