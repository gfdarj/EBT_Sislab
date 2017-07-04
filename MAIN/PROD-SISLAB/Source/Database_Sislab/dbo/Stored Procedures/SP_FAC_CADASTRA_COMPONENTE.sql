CREATE PROCEDURE [dbo].[SP_FAC_CADASTRA_COMPONENTE]
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

DECLARE @tmp INTEGER

DECLARE @intID INTEGER, @intQuant INTEGER, @ifim INTEGER, @ifim2 INTEGER

SELECT @tmp = CPT_ID FROM FAC_COMPONENTES WHERE UPPER( @cptNome ) = CPT_NOME AND @tpcID = TPC_ID AND @leeID = LEE_ID

IF @@ROWCOUNT > 0
	RETURN @tmp
ELSE BEGIN

	INSERT INTO FAC_COMPONENTES (CPT_NOME, TPC_ID, LEE_ID, CPT_COD_SGP_SCE,vsw_atu,vsw_std,obs) VALUES ( UPPER( @cptNome ), @tpcID, @leeID, @cptCodSGPSCE,@vsw_atu, @vsw_std,@obs)


/* Parte das Interfaces */

	SELECT @tmp = CPT_ID FROM FAC_COMPONENTES WHERE UPPER( @cptNome ) = CPT_NOME AND @tpcID = TPC_ID AND @leeID = LEE_ID


	DELETE FROM FAC_COMPONENTES_INTERFACE WHERE @tmp = CPT_ID
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

			INSERT INTO FAC_COMPONENTES_INTERFACE (TIPO_INTERFACE_ID, CPT_ID, Qtd_Int) VALUES (@intID, @tmp, @intQuant)
			IF @@ERROR > 0 BEGIN
				ROLLBACK TRAN
				RETURN -2 --erro na inserção
			END

			SET @intIDs = LTRIM(SUBSTRING( @intIDs, @ifim + 1, LEN(@intIDs) ))
			SET @intQuants = LTRIM(SUBSTRING( @intQuants, @ifim2 + 1, LEN(@intQuants) ))
		END
	END


/* Fim Parte das Interfaces */


	IF @@ERROR > 0
		RETURN -1
	ELSE
		RETURN @@IDENTITY
END

/*

CREATE PROCEDURE dbo.SP_FAC_ATUALIZA_REL_CARACTERISTICAS_TIPO
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







CREATE PROCEDURE dbo.SP_FAC_CADASTRA_COMPONENTE
@cptNome		VARCHAR(200),
@tpcID			INTEGER,
@leeID			INTEGER,
@cptCodSGPSCE	VARCHAR(50)

AS

SET NOCOUNT ON

DECLARE @tmp INTEGER

SELECT @tmp = CPT_ID FROM FAC_COMPONENTES WHERE UPPER( @cptNome ) = CPT_NOME AND @tpcID = TPC_ID AND @leeID = LEE_ID

IF @@ROWCOUNT > 0
	RETURN @tmp
ELSE BEGIN

	INSERT INTO FAC_COMPONENTES (CPT_NOME, TPC_ID, LEE_ID, CPT_COD_SGP_SCE) VALUES ( UPPER( @cptNome ), @tpcID, @leeID, @cptCodSGPSCE )

	IF @@ERROR > 0
		RETURN -1
	ELSE
		RETURN @@IDENTITY
END



*/



