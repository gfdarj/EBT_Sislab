/****** Object:  StoredProcedure [dbo].[SP_AG_ALOCA]    Script Date: 07/19/2018 18:45:13 ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[F_ListaCRT]') AND OBJECTPROPERTY(id,N'IsFunction') = 1)
	drop FUNCTION dbo.F_ListaCRT
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION dbo.F_ListaCRT (@AG_NUMERO INT)
	RETURNS VARCHAR(200)
AS
BEGIN
	DECLARE @nm_crt VARCHAR(200)
	DECLARE @ret VARCHAR(200)

	SET @ret = ''

	DECLARE cur_CRT CURSOR FOR 
		SELECT DISTINCT crt.NM_CRT
		FROM Reserva_ambientes ra 
			INNER JOIN Ambientes amb ON amb.AMB_ID = ra.AMB_ID 
			INNER JOIN CentroReferencia crt ON crt.ID_CRT = amb.ID_CRT
		WHERE ra.RAM_AS = @AG_NUMERO
		ORDER BY
			crt.NM_CRT

	OPEN cur_CRT

	FETCH NEXT FROM cur_CRT INTO @nm_crt

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @ret = @ret + ISNULL(@nm_crt, '') + ', '

		FETCH NEXT FROM cur_CRT INTO @nm_crt
	END

	CLOSE cur_CRT
	DEALLOCATE cur_CRT

	IF RIGHT(@ret, 2) = ', '
	BEGIN
		SET @ret = LEFT(@ret, LEN(@ret)-1)
	END

    RETURN @ret
END
GO
