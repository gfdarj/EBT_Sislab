CREATE PROCEDURE [dbo].[SP_FAC_ATUALIZA_CIRCUITO]
@ctoID			INTEGER,
@ctoNome		VARCHAR(200),
@tpcID			INTEGER,
@ASID			INTEGER,
@ctoPermanente	BIT,
@ctoAtivado		BIT

AS

SET NOCOUNT ON

UPDATE FAC_CIRCUITO SET CTO_NOME = UPPER( @ctoNome ), AG_Numero = @ASID,  TPC_ID = @tpcID, CTO_PERMANENTE = @ctoPermanente, CTO_ATIVADO = @ctoAtivado WHERE CTO_ID = @ctoID

IF @@ERROR > 0
	RETURN -1 --erro na atualização
ELSE
	RETURN 1


