CREATE PROCEDURE [dbo].[SP_FAC_ATUALIZA_COMPONENTE]
@cptID			INTEGER,
@cptNome		VARCHAR(200),
@vsw_atu		VARCHAR(100),
@vsw_std		VARCHAR(100),
@obs			VARCHAR(255),
@tpcID			INTEGER,
@intIDs			VARCHAR(8000),
@intQuants		VARCHAR(8000),
@leeID			INTEGER,
@cptCodSGPSCE	VARCHAR(50)

AS

SET NOCOUNT ON

BEGIN TRAN

UPDATE FAC_COMPONENTES SET CPT_NOME =  UPPER( @cptNome ), TPC_ID = @tpcID, LEE_ID = @leeID, CPT_COD_SGP_SCE = @cptCodSGPSCE, vsw_atu = @vsw_atu, vsw_std = @vsw_std, obs = @obs  WHERE CPT_ID = @cptID


DECLARE @intID INTEGER, @intQuant INTEGER, @ifim INTEGER, @ifim2 INTEGER


/* Parte das Interfaces */


	DELETE FROM FAC_COMPONENTES_INTERFACE WHERE CPT_ID = @cptID
	IF @@ERROR > 0 BEGIN
		ROLLBACK TRAN
		RETURN -1 --ocorreu um erro durante a exclusão
	END

	IF @intIDs <> '' AND @intIDs IS NOT NULL BEGIN
	
		SET @ifim = 1	
		WHILE ( @ifim != 0 ) BEGIN
			SET @ifim = PATINDEX('%,%', @intIDs )
			SET @ifim2 = PATINDEX('%,%', @intQuants )
			IF @ifim = 0 BEGIN
				SET @intID = SUBSTRING( @intIDs, 1, len(@intIDs) )
				SET @intQuant = SUBSTRING( @intQuants, 1, len(@intQuants) )
			END
			ELSE BEGIN
				SET @intID = SUBSTRING( @intIDs, 1, @ifim -1 )
				SET @intQuant = SUBSTRING( @intQuants, 1, @ifim2 -1 )
			END

			INSERT INTO FAC_COMPONENTES_INTERFACE (TIPO_INTERFACE_ID, CPT_ID, Qtd_Int) VALUES (@intID, @cptID, @intQuant)
			IF @@ERROR > 0 BEGIN
				ROLLBACK TRAN
				RETURN -2 --erro na inserção
			END

			SET @intIDs = LTRIM(SUBSTRING( @intIDs, @ifim + 1, LEN(@intIDs) ))
			SET @intQuants = LTRIM(SUBSTRING( @intQuants, @ifim2 + 1, LEN(@intQuants) ))
		END
	END


/* Fim Parte das Interfaces */

COMMIT TRAN

IF @@ERROR > 0
	RETURN -1
ELSE
	RETURN 1



