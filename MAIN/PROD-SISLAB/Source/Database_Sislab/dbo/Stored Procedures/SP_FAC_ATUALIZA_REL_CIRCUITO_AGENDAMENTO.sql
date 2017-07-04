CREATE PROCEDURE [dbo].[SP_FAC_ATUALIZA_REL_CIRCUITO_AGENDAMENTO]
@agNumeros	VARCHAR(8000),
@ctoID		INTEGER

AS

SET NOCOUNT ON

DECLARE @agNumero INTEGER, @ifim INTEGER

BEGIN TRAN

	DELETE FROM FAC_REL_CIRCUITO_AGENDAMENTO WHERE @ctoID = CTO_ID

	IF @@ERROR > 0 BEGIN
		ROLLBACK TRAN
		RETURN -1 --ocorreu um erro durante a exclusão
	END

	IF @agNumeros <> '' AND @agNumeros IS NOT NULL BEGIN
	
		SET @ifim = 1	
		WHILE ( @ifim != 0 ) BEGIN
			SET @ifim = PATINDEX('%,%', @agNumeros )

			IF @ifim = 0
				SET @agNumero = SUBSTRING( @agNumeros, 1, len(@agNumeros) )
			ELSE
				SET @agNumero = SUBSTRING( @agNumeros, 1, @ifim -1 )

			INSERT INTO FAC_REL_CIRCUITO_AGENDAMENTO ( AG_NUMERO, CTO_ID ) VALUES ( @agNumero, @ctoID )
			IF @@ERROR > 0 BEGIN
				ROLLBACK TRAN
				RETURN -2 --erro na inserção
			END

			SET @agNumeros = LTRIM(SUBSTRING( @agNumeros, @ifim + 1, LEN(@agNumeros) ))
		END
	END

COMMIT TRAN
RETURN 1

