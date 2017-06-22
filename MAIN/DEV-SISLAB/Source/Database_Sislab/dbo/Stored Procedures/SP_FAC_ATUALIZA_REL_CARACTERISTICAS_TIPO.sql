CREATE PROCEDURE [dbo].[SP_FAC_ATUALIZA_REL_CARACTERISTICAS_TIPO]
@carIDs	VARCHAR(8000),
@rctQuants	VARCHAR(8000),
@tpcID		INTEGER
AS

SET NOCOUNT ON

DECLARE @carID INTEGER, @rctQuant INTEGER, @ifim INTEGER, @ifim2 INTEGER

BEGIN TRAN

	DELETE FROM FAC_REL_CARACTERISTICAS_TIPO WHERE @tpcID = TPC_ID
	IF @@ERROR > 0 BEGIN
		ROLLBACK TRAN
		RETURN -1 --ocorreu um erro durante a exclusão
	END

	IF @carIDs <> '' AND @carIDs IS NOT NULL BEGIN
	
		SET @ifim = 1	
		WHILE ( @ifim != 0 ) BEGIN
			SET @ifim = PATINDEX('%,%', @carIDs )
			SET @ifim2 = PATINDEX('%,%', @rctQuants )
			IF @ifim = 0 BEGIN
				SET @carID = SUBSTRING( @carIDs, 1, len(@carIDs) )
				SET @rctQuant = SUBSTRING( @rctQuants, 1, len(@rctQuants) )
			END
			ELSE BEGIN
				SET @carID = SUBSTRING( @carIDs, 1, @ifim -1 )
				SET @rctQuant = SUBSTRING( @rctQuants, 1, @ifim2 -1 )
			END

			INSERT INTO FAC_REL_CARACTERISTICAS_TIPO (CAR_ID, TPC_ID, RCT_QUANTIDADE) VALUES (@carID, @tpcID, @rctQuant)
			IF @@ERROR > 0 BEGIN
				ROLLBACK TRAN
				RETURN -2 --erro na inserção
			END

			SET @carIDs = LTRIM(SUBSTRING( @carIDs, @ifim + 1, LEN(@carIDs) ))
			SET @rctQuants = LTRIM(SUBSTRING( @rctQuants, @ifim2 + 1, LEN(@rctQuants) ))
		END
	END

COMMIT TRAN
RETURN 1
