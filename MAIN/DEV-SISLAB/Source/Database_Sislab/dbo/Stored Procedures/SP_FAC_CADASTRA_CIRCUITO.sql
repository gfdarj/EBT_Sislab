CREATE PROCEDURE [dbo].[SP_FAC_CADASTRA_CIRCUITO]
@ctoNome		VARCHAR(200),
@tpcID			INTEGER, --tipo de circuito
@ASID			INTEGER, --tipo de circuito
@ctoPermanente	BIT,
@ctoAtivado		BIT

AS

SET NOCOUNT ON

INSERT INTO FAC_CIRCUITO (CTO_NOME, TPC_ID, CTO_PERMANENTE, CTO_ATIVADO, AG_NUMERO) VALUES ( UPPER( @ctoNome ), @tpcID, @ctoPermanente, @ctoAtivado, @ASID)

IF @@ERROR > 0
	RETURN -1
ELSE
	RETURN @@IDENTITY


