<%Option Explicit%>
<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<!------- SISLAB ---->
<!--#inc lude file="../includes/Sislab_Lib.asp"-->
<!--#inc lude file="../includes/Geral_Lib.asp"-->
<!------- LIB ------->
<!--#incl ude file="../Classes/Classe_Mensagem.asp"-->
<%
Dim objSP, erroBD, int_Erro
Dim codbarrasanterior
Dim id, descricao, instrumental, fab_id, mod_id
'Dim categoria
Dim numeroserie, codbarras, unidade, estoque, localizacao
Dim obs, manutencaopreventiva, deltaoperacao, umidadeoperacao
Dim warmupoperacao, deltaarmazenagem, umidadearmazenagem
Dim propriedade, status, conforme
Dim lista_acessorios, acessorio, lista_controles, controle
Dim id_Plataforma, id_PlataformaAnterior, freq_calibracao
Dim chr_SQL
Dim oErro

id = request("eq_id")
if id = "" then id = null
'categoria = request("categoria")
mod_id = request("mod_id")
if mod_id = "" then mod_id = null
localizacao = ucase(trim(request("localizacao")))
if localizacao = "" then localizacao = null
obs = ucase(trim(request("obs")))
if obs = "" then obs = null
freq_calibracao = Request("freq_calibracao")
if freq_calibracao = "" then freq_calibracao = null

id_Plataforma = request("plataforma")
if id_Plataforma = "" then id_Plataforma = "null"
id_PlataformaAnterior = request("plataformaAnterior")
if id_PlataformaAnterior = "" then id_PlataformaAnterior = "null"

'response.write "fab_id:" & request("fab_id") & "<BR>"
'response.write "categoria:" & request("categoria") & "<BR>"
'response.write "instrumental:" & request("instrumental") & "<BR>"
'response.write "plataforma:" & request("plataforma") & "<BR>"
'response.write "plataforma:" & id_Plataforma & "<BR>"
'response.write "plataforma anterior:" & request("plataformaanterior") & "<BR>"
'response.write "plataforma anterior:" & id_PlataformaAnterior & "<BR>"
'response.end

codbarras = ucase(trim(request("codbarras")))
codbarrasanterior = ucase(trim(request("codbarrasanterior")))
numeroserie = ucase(trim(request("numeroserie")))
instrumental = request("instrumental")
if instrumental = "" then instrumental = 0
manutencaopreventiva = UCase(trim(request("manutencaopreventiva")))
deltaoperacao = ucase(trim(request("deltaoperacao")))
umidadeoperacao = ucase(trim(request("umidadeoperacao")))
warmupoperacao = ucase(trim(request("warmupoperacao")))
deltaarmazenagem = ucase(trim(request("deltaarmazenagem")))
umidadearmazenagem = ucase(trim(request("umidadearmazenagem")))
propriedade = request("propriedade")
conforme = request("conforme")
if VVVNZ(id) then status = STATUS_CADASTRADO else status = request("status")

'-- CONTROLE DE INSTRUMENTAL
'-- pega a lista de acessorios (campos separados por "¿!¿" e separa cada registro concatenando
'-- em uma string passada ao banco de dados
if request("lista_controles") = "" then
	lista_controles = null
else
	lista_controles = ""
	for each controle in request("lista_controles")
		lista_controles = lista_controles + controle + "»?«"
	next
	lista_controles = UCase(Left(lista_controles, Len(lista_controles)-3))

	lista_controles = Replace(lista_controles, "MANUTENÇÃO CORRETIVA", CONTROLE_MANUTENCAO)
	lista_controles = Replace(lista_controles, "MANUTENÇÃO PREVENTIVA", CONTROLE_MANUTENCAO_PREVENTIVA)
	lista_controles = Replace(lista_controles, "CALIBRAÇÃO", CONTROLE_CALIBRACAO)
	lista_controles = Replace(lista_controles, "QUALIFICAÇÃO", CONTROLE_QUALIFICACAO)
end if

'RESPONSE.WRITE lista_controles
'RESPONSE.END

'-- ACESSORIOS
'-- pega a lista de acessorios (campos separados por "¿!¿" e separa cada registro concatenando
'-- em uma string passada ao banco de dados
if request("lista_acessorios") = "" then
	lista_acessorios = null
else
	lista_acessorios = ""
	for each acessorio in request("lista_acessorios")
		lista_acessorios = lista_acessorios + acessorio + "»?«"
	next
	lista_acessorios = UCase(Left(lista_acessorios, Len(lista_acessorios)-3))
end if

RESPONSE.Write "<BR>id: " & id
'RESPONSE.Write "<BR>" & codbarras
'RESPONSE.Write "<BR>" & codbarrasanterior
'RESPONSE.Write "<BR>" & numeroserie
'RESPONSE.Write "<BR>" & localizacao
'RESPONSE.Write "<BR>" & mod_id
'RESPONSE.Write "<BR>" & obs
'RESPONSE.Write "<BR>" & status
'RESPONSE.Write "<BR>" & deltaoperacao
'RESPONSE.Write "<BR>" & umidadeoperacao
'RESPONSE.Write "<BR>" & warmupoperacao
'RESPONSE.Write "<BR>" & deltaarmazenagem
'RESPONSE.Write "<BR>" & umidadearmazenagem
'RESPONSE.Write "<BR>" & manutencaopreventiva
'RESPONSE.Write "<BR>" & instrumental
'RESPONSE.Write "<BR>propriedade: " & propriedade
'RESPONSE.Write "<BR>" & conforme
'RESPONSE.Write "<BR>" & lista_acessorios
'RESPONSE.Write "<BR>" & lista_controles
'RESPONSE.Write "<BR>" & freq_calibracao
'response.End

Call Env.StoredProcedure(True, objSP, "SP_SCE_CADASTRA_EQUIPAMENTO")
With objSP
	.Parameters.item("@EQ_ID") = id
	.Parameters.item("@EQ_CODIGOBARRAS") = codbarras
	.Parameters.item("@EQ_CODIGOBARRASANTERIOR") = codbarrasanterior
	.Parameters.item("@EQ_NUMEROSERIE") = numeroserie
	.Parameters.item("@EQ_LOCALIZACAO") = localizacao
	.Parameters.item("@MOD_ID") = mod_id
	.Parameters.item("@EQ_OBS") = obs
	.Parameters.item("@STATUS") = status
	.Parameters.item("@EQ_OPER_DELTA") = deltaoperacao
	.Parameters.item("@EQ_OPER_UMIDADE") = umidadeoperacao
	.Parameters.item("@EQ_OPER_WARMUP") = warmupoperacao
	.Parameters.item("@EQ_ARMA_DELTA") = deltaarmazenagem
	.Parameters.item("@EQ_ARMA_UMIDADE") = umidadearmazenagem
	.Parameters.item("@EQ_MANUT_PREVENTIVA") = manutencaopreventiva
	.Parameters.item("@EQ_INSTRUMENTAL") = instrumental
	.Parameters.item("@EQ_PROPRIEDADE") = propriedade
	.Parameters.item("@EQ_CONFORME") = conforme
	.Parameters.item("@EQ_LISTA_ACESSORIOS") = lista_acessorios
	.Parameters.item("@EQ_LISTA_CONTROLE") = lista_controles
	.Parameters.item("@EQ_FREQ_CALIBRACAO") = freq_calibracao
	on error resume next
	.Execute
	oErro = Err
	int_Erro = oErro.Number
	on error goto 0
	id = .Parameters.item("@EQ_ID")
End With
Call Env.StoredProcedure(False, objSP, Null)

If int_Erro <> 0 Then
'response.Write "AQUI" & int_Erro
'response.end
    Tela.SCE = True
    Tela.SetNomeTela = "Cadastro > Item" : Tela.SetCaminhoRelativo = "../"
    Call Tela.MostraCabecalho()
    'Call Tela.ImprimeMenuSce()
	Call Tela.Mensagem.ObjetoErroSql(oErro)
    Call Tela.MostraRodape()
    Response.End
End If

'Grava a Plataforma do equipamento - utiliza a estrutura do mesmo cadastro do SISLAB
'para guardar o histórico das mudanças
chr_SQL = "" & _
	"SET NOCOUNT ON " & VbCrLf & _
	"DECLARE @Hoje DATETIME" & VbCrLf & _
	"DECLARE @EQ_ID INT" & VbCrLf & _
	"DECLARE @CodBarras VARCHAR(20)" & VbCrLf & _
	"DECLARE @S_ID_ATUAL INT" & VbCrLf & _
	"DECLARE @S_ID_ANT INT" & VbCrLf & _
	"SET @Hoje = GETDATE()" & VbCrLf & _
	"SET @CodBarras = '" & CodBarras & "'" & VbCrLf & _
	"" & VbCrLf & _
	"SET @EQ_ID = (SELECT TOP 1 EQ_ID FROM SCE_Equipamentos WHERE EQ_CODIGOBARRAS = @CodBarras)" & VbCrLf & _
	"SET @S_ID_ATUAL = " & id_Plataforma & VbCrLf & _
	"SET @S_ID_ANT = " & id_PlataformaAnterior & VbCrLf & _
	"" & VbCrLf & _
	"BEGIN TRANSACTION" & VbCrLf & _
	"" & VbCrLf & _
	"IF (@S_ID_ANT IS NOT NULL) OR (@S_ID_ATUAL IS NULL)" & VbCrLf & _
	"BEGIN" & VbCrLf & _
	"	IF (@S_ID_ANT IS NOT NULL)" & VbCrLf & _
	"	BEGIN" & VbCrLf & _
	"		-- Retira o equipamento anterior" & VbCrLf & _
	"		INSERT INTO Historico_Plataforma_Equipamentos" & VbCrLf & _
	"			VALUES(@Hoje, 'S', @EQ_ID, @S_ID_ANT)" & VbCrLf & _
	"		IF @@ERROR <> 0 BEGIN" & VbCrLf & _
	"			GOTO ERRO" & VbCrLf & _
	"		END" & VbCrLf & _
	"	END" & VbCrLf & _
	"" & VbCrLf & _
	"	DELETE FROM PLATAFORMA_EQUIPAMENTOS WHERE S_ID = @S_ID_ANT AND EQ_ID = @EQ_ID" & VbCrLf & _
	"	IF @@ERROR <> 0 BEGIN" & VbCrLf & _
	"		GOTO ERRO" & VbCrLf & _
	"	END" & VbCrLf & _
	"" & VbCrLf & _
	"	--A plataforma atual NULA indica retirar apenas ela da associacao com o equipamento" & VbCrLf & _
	"	IF @S_ID_ATUAL IS NULL BEGIN" & VbCrLf & _
	"		GOTO OK" & VbCrLf & _
	"	END" & VbCrLf & _
	"END" & VbCrLf & _
	"" & VbCrLf & _
	"IF (@EQ_ID IS NULL) OR (@S_ID_ATUAL = @S_ID_ANT) BEGIN" & VbCrLf & _
	"	GOTO ERRO" & VbCrLf & _
	"END" & VbCrLf & _
	"" & VbCrLf & _
	"-- esta na lista, e nao esta na base" & VbCrLf & _
	"INSERT INTO Historico_Plataforma_Equipamentos (HPE_DATAALTERACAO, HPE_TIPOMOVIMENTO, EQ_ID, S_ID)" & VbCrLf & _
	"		VALUES(@Hoje, 'E', @EQ_ID, @S_ID_ATUAL)" & VbCrLf & _
	"IF @@ERROR <> 0 BEGIN" & VbCrLf & _
	"	GOTO ERRO" & VbCrLf & _
	"END" & VbCrLf & _
	"" & VbCrLf & _
	"INSERT INTO PLATAFORMA_EQUIPAMENTOS (S_ID, EQ_ID)" & VbCrLf & _
	"	VALUES(@S_ID_ATUAL, @EQ_ID)" & VbCrLf & _
	"IF @@ERROR <> 0 BEGIN" & VbCrLf & _
	"	GOTO ERRO" & VbCrLf & _
	"END" & VbCrLf & _
	"" & VbCrLf & _
	"GOTO OK" & VbCrLf & _
	"" & VbCrLf & _
	"ERRO:" & VbCrLf & _
	"	ROLLBACK TRANSACTION" & VbCrLf & _
	"	GOTO FIM" & VbCrLf & _
	"OK:" & VbCrLf & _
	"	COMMIT TRANSACTION" & VbCrLf & _
	"FIM:" & VbCrLf
on error resume next
Env.oConn.Execute(chr_SQL)
Set oErro = Env.oConn.Errors
on error Goto 0
'response.write replace(chr_sql, vbcrlf, "<BR>")
'response.end


'============ O CODIGO ACIMA CORRIGE A PROCEDURE ABAIXO QUE SO FUNCIONA PARA A TELA NO SISLAB =================='

''Call StoredProcedure(True, objSP, "sp_CadPlataformaEquipamento", Conn)
''With objSP
''	.Parameters.item("@pS_ID") = id_Plataforma
''	.Parameters.item("@pEQ_ID_LISTA") = CStr(id)
''	on error resume next
''	.Execute
''	on error goto 0
''End With
''Call StoredProcedure(False, objSP, Null, Null)


''	response.write "ERROS: " & conn.Errors.Count & "<BR><BR>"

If oErro.Count <> 0 Then
    Tela.SCE = True
    Tela.SetNomeTela = "Cadastro > Item" : Tela.SetCaminhoRelativo = "../"
    Call Tela.MostraCabecalho()
    'Call Tela.ImprimeMenuSce()
	Call Tela.Mensagem.ErroSql()
    Call Tela.MostraRodape()
    Response.End
Else
	response.redirect "cad_acess_item.asp?cadastrou=1&eq_id=" & id
End If
%>
