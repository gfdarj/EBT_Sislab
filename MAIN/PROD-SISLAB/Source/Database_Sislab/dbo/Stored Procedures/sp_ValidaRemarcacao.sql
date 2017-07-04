
CREATE  PROCEDURE [dbo].[sp_ValidaRemarcacao]
	@pAG_NUMERO smallint,
	@pAG_FLAGREMARCADO bit
AS
BEGIN
	/*** Remarco um agendamento selecionado ***/
	declare @vAG_DATAINICIO smalldatetime, @vAG_DATATERMINO smalldatetime
	declare @vHD_DATAINICIO smalldatetime, @vHD_DATATERMINO smalldatetime
	declare @vHD_MARCACAO smallint
	declare @vPRIMEIRAMARCACAO bit

	BEGIN TRANSACTION

	select @vPRIMEIRAMARCACAO = count(*) from historico_datas
 	where AG_NUMERO = @pAG_NUMERO and HD_MARCACAO = 0

	select @vHD_MARCACAO = max(HD_MARCACAO) from historico_datas
 	where AG_NUMERO = @pAG_NUMERO

	if (@vPRIMEIRAMARCACAO = 0) and (@pAG_FLAGREMARCADO=1)begin
		select @vAG_DATAINICIO = AG_DATAINICIO, @vAG_DATATERMINO = AG_DATATERMINO
		from agendamento
	 	where AG_NUMERO = @pAG_NUMERO

		insert into historico_datas(AG_NUMERO, HD_MARCACAO, HD_DATAINICIO, HD_DATATERMINO, HD_FLAGREMARCADO, HD_MOTIVO)
 		values(@pAG_NUMERO, 0, @vAG_DATAINICIO, @vAG_DATATERMINO, 0, 'Primeira Marcação (datas originais do agendamento)')

		if @@error <> 0 begin
   			rollback transaction
   			return(@@error)
  		end
	end

	if (@pAG_FLAGREMARCADO=1) begin  -- remarca o agendamento
		select @vHD_DATAINICIO = HD_DATAINICIO, 
        	       @vHD_DATATERMINO = HD_DATATERMINO
  		from historico_datas
  		where AG_NUMERO = @pAG_NUMERO and HD_MARCACAO = @vHD_MARCACAO

	  	UPDATE AGENDAMENTO
	  		SET  AG_DATAINICIO = @vHD_DATAINICIO,
		  		AG_DATATERMINO = @vHD_DATATERMINO,
  				AG_FLAGREMARCACAO = 0
	  		where AG_NUMERO = @pAG_NUMERO
	  	if @@error <> 0 begin
   			rollback transaction
   			return(@@error)
  		end
 	end
	else begin  -- volta o agendamento como não remarcado
		UPDATE AGENDAMENTO
  		SET  AG_FLAGREMARCACAO = 0
  		where AG_NUMERO = @pAG_NUMERO
  		if @@error <> 0 begin
   			rollback transaction
   			return(@@error)
  		end
 	end

	-- indica se foi aceito ou nao a remarcação
  	UPDATE historico_datas
		SET HD_FLAGREMARCADO = @pAG_FLAGREMARCADO
		where AG_NUMERO = @pAG_NUMERO and HD_MARCACAO = @vHD_MARCACAO
  	if @@error <> 0 begin
		rollback transaction
		return(@@error)
	end

	COMMIT TRANSACTION
END

