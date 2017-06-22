
CREATE PROCEDURE [dbo].[sp_CadDePara]
	@separa_campo varchar(4),
	@separa_registro varchar(4),
	@pTabela VARCHAR(20),
	@pDE	 VARCHAR(8000),
	@pPARA 	 VARCHAR(510)
AS
BEGIN
	SET NOCOUNT ON 
	BEGIN TRANSACTION

	--VARIÁVEIS NECESSÁRIAS PARA QUEBRA DAS STRINGS
	DECLARE @reg VARCHAR(7000), @fim BIT, @iini INT, @ifim INT
	DECLARE @DADOS VARCHAR(7000)
	DECLARE @st1 VARCHAR(255), @st2 VARCHAR(255)
	SET @DADOS = @pDE

	--RETIRO O ULTIMO SEPARADO DE REGISTRO
	SET @DADOS = REVERSE(SUBSTRING(REVERSE(@DADOS),LEN(@separa_registro)+1,LEN(@DADOS)))

	IF @pTabela = 'ClienteExterno' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
		IF @DADOS IS NOT NULL BEGIN
			SET @DADOS = rtrim(ltrim(@DADOS))
			SET @fim = 0
			SET @iini = 1

			WHILE ( @fim = 0 ) BEGIN
				SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
				IF @ifim = 0 begin
					SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
				end 
				ELSE begin
					SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
				end
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				UPDATE AGENDAMENTO 
				SET AG_CLIENTEEXTERNO  = @pPARA
				WHERE AG_CLIENTEEXTERNO = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END

	IF @pTabela = 'Orgao' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
		IF @DADOS IS NOT NULL BEGIN
			SET @DADOS = rtrim(ltrim(@DADOS))
			SET @fim = 0
			SET @iini = 1

			WHILE ( @fim = 0 ) BEGIN
				SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
				IF @ifim = 0 begin
					SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
				end 
				ELSE begin
					SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
				end
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				UPDATE AGENDAMENTO 
				SET ag_orgao  = @pPARA
				WHERE ag_orgao = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END

	IF @pTabela = 'TipoAtividade' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
		IF @DADOS IS NOT NULL BEGIN
			SET @DADOS = rtrim(ltrim(@DADOS))
			SET @fim = 0
			SET @iini = 1

			WHILE ( @fim = 0 ) BEGIN
				SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
				IF @ifim = 0 begin
					SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
				end 
				ELSE begin
					SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
				end
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				UPDATE AGENDAMENTO 
				SET TA_ID  = CONVERT(INTEGER,@pPARA)
				WHERE TA_ID = CONVERT(INTEGER,@st1)
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)

					RETURN -1
				END
	
				--CRIADO PARA CONTROLAR CASOS EM QUE ENTRE O CONJUNTO  DAS CLAUSULAS "DE" TENHA UM ELEMENTO DA CLAUSULA PARA
				IF @pPARA <> @st1 BEGIN
					DELETE FROM TIPO_ATIVIDADE WHERE TA_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END

	IF @pTabela = 'Tecnologia' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
		IF @DADOS IS NOT NULL BEGIN
			SET @DADOS = rtrim(ltrim(@DADOS))
			SET @fim = 0
			SET @iini = 1

			WHILE ( @fim = 0 ) BEGIN
				SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
				IF @ifim = 0 begin
					SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
				end 
				ELSE begin
					SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
				end
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				UPDATE AGENDAMENTO 
				SET TEC_ID  = CONVERT(INTEGER,@pPARA)
				WHERE TEC_ID = CONVERT(INTEGER,@st1)
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END

				--CRIADO PARA CONTROLAR CASOS EM QUE ENTRE O CONJUNTO  DAS CLAUSULAS "DE" TENHA UM ELEMENTO DA CLAUSULA PARA	
				IF @pPARA <> @st1 BEGIN
					DELETE FROM TECNOLOGIA WHERE TEC_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END

	IF @pTabela = 'Testes' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
		IF @DADOS IS NOT NULL BEGIN
			SET @DADOS = rtrim(ltrim(@DADOS))
			SET @fim = 0
			SET @iini = 1

			WHILE ( @fim = 0 ) BEGIN
				SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
				IF @ifim = 0 begin
					SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
				end 
				ELSE begin
					SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
				end
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				--CRIADO PARA CONTROLAR CASOS EM QUE ENTRE O CONJUNTO  DAS CLAUSULAS "DE" TENHA UM ELEMENTO DA CLAUSULA PARA	
				IF @pPARA <> @st1 BEGIN
					-------------------------------------------------------------------
					UPDATE ORDEM_DE_SERVICO
					SET T_ID  = CONVERT(INTEGER,@pPARA)
					WHERE T_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
					-------------------------------------------------------------------
					DELETE FROM TESTES WHERE T_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END

		END
	END

	IF @pTabela = 'LB_TipoOcorrencia' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
		IF @DADOS IS NOT NULL BEGIN
			SET @DADOS = rtrim(ltrim(@DADOS))
			SET @fim = 0
			SET @iini = 1

			WHILE ( @fim = 0 ) BEGIN
				SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
				IF @ifim = 0 begin
					SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
				end 
				ELSE begin
					SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
				end
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				--CRIADO PARA CONTROLAR CASOS EM QUE ENTRE O CONJUNTO  DAS CLAUSULAS "DE" TENHA UM ELEMENTO DA CLAUSULA PARA	
				IF @pPARA <> @st1 BEGIN
					-------------------------------------------------------------------
					UPDATE LB_LogBook
					SET LBTO_ID  = CONVERT(INTEGER,@pPARA)
					WHERE LBTO_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
					-------------------------------------------------------------------
					DELETE FROM LB_TipoOcorrencia WHERE LBTO_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END


	IF @pTabela = 'TipoArquivo' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
		IF @DADOS IS NOT NULL BEGIN
			SET @DADOS = rtrim(ltrim(@DADOS))
			SET @fim = 0
			SET @iini = 1

			WHILE ( @fim = 0 ) BEGIN
				SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
				IF @ifim = 0 begin
					SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
				end 
				ELSE begin
					SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
				end
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				--CRIADO PARA CONTROLAR CASOS EM QUE ENTRE O CONJUNTO  DAS CLAUSULAS "DE" TENHA UM ELEMENTO DA CLAUSULA PARA	
				IF @pPARA <> @st1 BEGIN
					-------------------------------------------------------------------
					UPDATE Arquivos
					SET ARQ_CODARQTIPO  = CONVERT(INTEGER,@pPARA)
					WHERE ARQ_CODARQTIPO = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
					-------------------------------------------------------------------
					DELETE FROM TipoArquivo WHERE TAR_CODTIPOARQUIVO = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END


	IF @pTabela = 'OrgaoInterno' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
		IF @DADOS IS NOT NULL BEGIN
			SET @DADOS = rtrim(ltrim(@DADOS))
			SET @fim = 0
			SET @iini = 1

			WHILE ( @fim = 0 ) BEGIN
				SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
				IF @ifim = 0 begin
					SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
				end 
				ELSE begin
					SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
				end
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				--CRIADO PARA CONTROLAR CASOS EM QUE ENTRE O CONJUNTO  DAS CLAUSULAS "DE" TENHA UM ELEMENTO DA CLAUSULA PARA	
				IF @pPARA <> @st1 BEGIN
					-------------------------------------------------------------------
					UPDATE UserCRT
					SET ORGA_ID = CONVERT(INTEGER,@pPARA)
					WHERE ORGA_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
					-------------------------------------------------------------------
					UPDATE Arquivos
					SET ARQ_IDORGAO = CONVERT(INTEGER,@pPARA)
					WHERE ARQ_IDORGAO = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
					-------------------------------------------------------------------
					DELETE FROM Orgao WHERE ORGA_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END


	IF @pTabela = 'TipoTeste' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
		IF @DADOS IS NOT NULL BEGIN
			SET @DADOS = rtrim(ltrim(@DADOS))
			SET @fim = 0
			SET @iini = 1

			WHILE ( @fim = 0 ) BEGIN
				SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
				IF @ifim = 0 begin
					SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
				end 
				ELSE begin
					SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
				end
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				UPDATE Testes
				SET TIT_ID = @pPARA
				WHERE TIT_ID = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------

				DELETE FROM Tipo_Teste
				WHERE TIT_ID = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END


	IF (@pTabela = 'Plataformas') OR (@pTabela = 'Servicos') BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
		IF @DADOS IS NOT NULL BEGIN
			SET @DADOS = rtrim(ltrim(@DADOS))
			SET @fim = 0
			SET @iini = 1

			WHILE ( @fim = 0 ) BEGIN
				SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
				IF @ifim = 0 begin
					SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
				end 
				ELSE begin
					SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
				end
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				IF (@pTabela = 'Plataformas') 
				BEGIN

					--apaga o histórico de eventos, caso a OS venha a ser excluída
					DELETE FROM Historico_EventosOS 
					WHERE AG_NUMERO IN (
						SELECT AG_NUMERO FROM Ordem_de_Servico a1
						WHERE S_ID_PLATAFORMA = @pPARA
						AND EXISTS (
							SELECT a2.ag_numero FROM Ordem_de_Servico a2
							WHERE a2.S_ID_PLATAFORMA = @st1 and a1.ag_numero = a2.ag_numero
						)
					)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END

					--Verifica os casos que existem OS com os 2 servicos/plataformas
					DELETE FROM Ordem_de_Servico
					WHERE S_ID_PLATAFORMA = @pPARA AND AG_NUMERO IN (
						SELECT AG_NUMERO FROM Ordem_de_Servico a1
						WHERE S_ID_PLATAFORMA = @pPARA
						AND EXISTS (
							SELECT a2.ag_numero FROM Ordem_de_Servico a2
							WHERE a2.S_ID_PLATAFORMA = @st1 and a1.ag_numero = a2.ag_numero
						)
					)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END

					UPDATE Ordem_de_Servico
					SET S_ID_PLATAFORMA = @pPARA
					WHERE S_ID_PLATAFORMA = @st1
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END

				-----------------------------------------------------------------------------------

				IF (@pTabela = 'Servicos')
				BEGIN
					--Verifica os casos que existem OS com os 2 servicos/plataformas
					DELETE FROM Ordem_de_Servico
					WHERE S_ID_SERVICO = @pPARA AND AG_NUMERO IN (
						SELECT AG_NUMERO FROM Ordem_de_Servico a1
						WHERE S_ID_SERVICO = @pPARA
						AND EXISTS (
							SELECT a2.ag_numero FROM Ordem_de_Servico a2
							WHERE a2.S_ID_SERVICO = @st1 and a1.ag_numero = a2.ag_numero
						)
					)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END

					UPDATE Ordem_de_Servico
					SET S_ID_SERVICO = @pPARA
					WHERE S_ID_SERVICO = @st1
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END
				-----------------------------------------------------------------------------------
				UPDATE Historico_Plataforma_Equipamentos
				SET S_ID = @pPARA
				WHERE S_ID = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------

				--Apaga os equipamentos que ficarao duplicados em uma plataforma
				DELETE FROM Plataforma_Equipamentos
				WHERE S_ID = @pPARA AND EQ_ID IN (
					SELECT EQ_ID FROM Plataforma_Equipamentos a1
					WHERE s_id = @pPARA
					AND EXISTS (
						SELECT a2.EQ_ID FROM Plataforma_Equipamentos a2
						WHERE a2.s_id = @st1 and a1.EQ_ID = a2.EQ_ID
					)
				)
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END

				UPDATE Plataforma_Equipamentos
				SET S_ID = @pPARA
				WHERE S_ID = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------
				DELETE FROM Agenda_Servicos_Plataforma
				WHERE S_ID = @pPARA AND AG_NUMERO IN (
					SELECT AG_NUMERO FROM Agenda_Servicos_Plataforma a1
					WHERE s_id = @pPARA
					and EXISTS (
						SELECT a2.ag_numero FROM Agenda_Servicos_Plataforma a2
						WHERE a2.s_id = @st1 and a1.ag_numero = a2.ag_numero
					)
				)
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END

				UPDATE Agenda_Servicos_Plataforma
				SET S_ID = @pPARA
				WHERE S_ID = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( '222 Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------
				UPDATE Servicos_Plataformas
				SET S_ID_PAI = @pPARA
				WHERE S_ID_PAI = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------
				/*DELETE FROM Servicos_Plataformas
				WHERE S_ID = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END*/
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END

	COMMIT TRANSACTION
	RETURN 1
END
