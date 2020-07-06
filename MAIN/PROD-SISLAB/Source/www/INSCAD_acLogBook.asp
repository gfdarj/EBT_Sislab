<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp"-->
<!--#include file="includes/global.asp"-->
<!--#include file="includes/emailHTML.asp"-->
<!--#include file="includes/bib_str.asp" -->
<!--#include file="Lib/Classe_Arquivo.asp"-->
<%
Dim objSP, RS
Dim idacao, descricao, executante, prazo, conclusao, eficacia, obs, tipoacao, responsavel
Dim EhnovaAcao : EhnovaAcao = false
Dim int_Conta
Dim assunto
Dim msg
Dim Arquivo

Set Arquivo = New TArquivo

Arquivo.SetNomePasta = "LB_"
Arquivo.SetPastaRaiz = Application("SISLAB_FolderArquivosLB")
Arquivo.SetOverwrite = False

Call Arquivo.Init_UP()
Call Arquivo.Upload()

int_Conta = Arquivo.TotalArquivos

'-- Excluir um arquivo anexo da ação
If Arquivo.Campo("id_ArquivoExclusao") <> "" Then

'	rw "AQUI 1"
'	rw "<BR>id_ArquivoExclusaoNome: " & Arquivo.Campo("id_ArquivoExclusaoNome")
'	RE

	call Env.StoredProcedure(true, objSP, "sp_ApagaLogBookAcaoTomadaArquivos")
	with objSP
		.Parameters.item("@pACA_ID") = Arquivo.Campo("id_ArquivoExclusao")
	'	on error resume next
		.Execute
	'	on error goto 0
		idacao = .Parameters.item("@pACA_ID")
	end with
	call Env.StoredProcedure(false, objSP, "sp_ApagaLogBookAcaoTomadaArquivos")

	If idacao > -1 Then
		On Error Resume Next
		Arquivo.Exclui(Arquivo.Campo("id_ArquivoExclusaoNome"))
		On Error Goto 0
	End If

Else
	idacao = Arquivo.Campo("idacao")
	if idacao = "" then 
		idacao = null
		EhnovaAcao = true
	end if

	'-- Apaga uma ação tomada
	if Arquivo.Campo("remover") = "1" then

	'rw "AQUI 2"
	'RE

		'-- Pego o nome dos arquivos para excluir fisicamente
		Set RS = Env.oConn.Execute("SELECT ACA_LINK FROM LB_ACOESTOMADAS_ARQUIVOS WHERE ACT_ID = " & idacao)

		'-- Apago as Acoes tomada
		call Env.StoredProcedure(true, objSP, "sp_ApagaLogBookAcaoTomada")
		with objSP
			.Parameters.item("@pACT_ID") = idacao
		'	on error resume next
			.Execute
		'	on error goto 0
			idacao = .Parameters.item("@pACT_ID")
		end with
		call Env.StoredProcedure(false, objSP, "sp_ApagaLogBookAcaoTomada")

		On Error Resume Next
		While Not RS.Eof
			Arquivo.Exclui(RS(0))
			RS.MoveNext
		WEnd
		RS.Close
		On Error Goto 0
		Set RS = Nothing

	Else
		Arquivo.Salva(Arquivo.Campo("ocorrencia"))

		If Arquivo.Arquivos.Count > 0 Then
			chr_arquivo = Arquivo.ArquivoSubPasta(1)
		Else
			chr_arquivo = null
		End If
		If chr_arquivo = "" Then chr_arquivo = Null

		descricao = Arquivo.Campo("descricao")
		if descricao = "" then descricao = null
		executante = Arquivo.Campo("executor")
		if executante = "" then executante = null
		responsavel = Arquivo.Campo("responsavel")
		if responsavel = "" then responsavel = null
		prazo = Arquivo.Campo("anoprazo") & "-" & Arquivo.Campo("mesprazo") & "-" & Arquivo.Campo("diaprazo")
		if trim(prazo) = "--" then prazo = null
		conclusao = Arquivo.Campo("anoconc") & "-" & Arquivo.Campo("mesconc") & "-" & Arquivo.Campo("diaconc")
		if trim(conclusao) = "--" then conclusao = null
		eficacia = Arquivo.Campo("opteficacia")
		if eficacia = "" then eficacia = null
		obs = Arquivo.Campo("obs")
		if obs = "" then obs = null
		tipoacao = Arquivo.Campo("cmbAcao")
		if tipoacao = "" then tipoacao = null else tipoacao = cint(tipoacao)

'-- TESTE PARA RECEBER OS PARAMETROS PASSADOS A PROCEDURE sp_CadLogBookAcaoTomada
Dim p_msg1 : p_msg1 = ""
p_msg1 = p_msg1 & "<p><b>TESTE PARA RECEBER OS PARAMETROS PASSADOS A PROCEDURE sp_CadLogBookAcaoTomada</b></p>" & VbCrLf
p_msg1 = p_msg1 & "<BR>idacao: " & idacao & VbCrLf
p_msg1 = p_msg1 & "<BR>ocorrencia: " & Arquivo.Campo("ocorrencia") & VbCrLf
p_msg1 = p_msg1 & "<BR>descricao: " & descricao & VbCrLf
p_msg1 = p_msg1 & "<BR>executante: " & executante & VbCrLf
p_msg1 = p_msg1 & "<BR>prazo: " & prazo & VbCrLf
p_msg1 = p_msg1 & "<BR>conclusao: " & conclusao & VbCrLf
p_msg1 = p_msg1 & "<BR>eficacia: " & eficacia & VbCrLf
p_msg1 = p_msg1 & "<BR>obs: " & obs & VbCrLf
p_msg1 = p_msg1 & "<BR>tipoacao: " & tipoacao & VbCrLf
p_msg1 = p_msg1 & "<BR>arquivo: " & arquivo & VbCrLf
p_msg1 = p_msg1 & "<BR>" & replace(ucase(Request.ServerVariables("REMOTE_USER")),"EMBRATEL\","") & VbCrLf
Call Enviar_Email("gilbertorjo@gmail.com", "iLab", "[SISLAB] - InsCad_acLogBook.asp (" & Now & ")", p_msg1)

		call Env.StoredProcedure(true, objSP, "sp_CadLogBookAcaoTomada")
		with objSP
			.Parameters.item("@pACT_ID") = idacao
			.Parameters.item("@pACT_LB") = Arquivo.Campo("ocorrencia")
			.Parameters.item("@pACT_DESCRICAO") = descricao
			.Parameters.item("@pACT_EXECUTANTE") = executante
			.Parameters.item("@pACT_PRAZO") = prazo
			.Parameters.item("@pACT_DATACONCLUSAO") = conclusao
			.Parameters.item("@pACT_EFICACIA") = eficacia
			.Parameters.item("@pACT_OBS") = obs
			.Parameters.item("@pACT_TIPOACAO") = tipoacao
			.Parameters.item("@pACT_ARQUIVO") = chr_arquivo
			.Parameters.item("@pACT_USUARIOCADASTROU") = replace(ucase(Request.ServerVariables("REMOTE_USER")),"EMBRATEL\","")
			.Parameters.item("@pACT_RESPONSAVEL") = responsavel
		'	on error resume next
			.Execute
		'	on error goto 0
			idacao = .Parameters.item("@pACT_ID")
		end with
		call Env.StoredProcedure(false, objSP, "sp_CadLogBookAcaoTomada")

		'-- Usuario selecionou para responder por email ao Responsavel pela acao
		If Arquivo.Campo("resposta") = "S" Then

			assunto = "Gerenciamento do LogBook - Elaboração de Ações Tomadas"

			If EhnovaAcao Then msg = "criada." Else msg = "alterada."

			If Cstr(TipoAcao) = Cstr(LB_Acao_Imediata) Then
				msg = "<b>imediata</b> foi " & msg
			ElseIf Cstr(TipoAcao) = Cstr(LB_Acao_Corretiva) Then
				msg = "<b>corretiva</b> foi " & msg
			Else
				msg = "<b>preventiva</b> foi " & msg
			End If

			msg = _
				"Uma ação do logbook tipo " & msg & "<br><br>" & _
				"Nº da Ocorrência : " & Arquivo.Campo("ocorrencia") &  "<br>" & _
				"Prazo de conclusão: " & conclusao & "<br>" & _
				"Responsável pela Ação: " & responsavel &  "<br>" & _
				"Executor: " & executante & "<br>" & _
				"Descrição da ação: " & descricao &  "<br>"

'response.write "AQUI: " & msg
'response.end

			'###
			'### houve uma reclamacao de que o email nao estava sendo enviado, entao comentei
			'### a linha que verifica o usuário
			'###									Gilberto (06/09/2010)
			If Env.Ebt.ExisteUsuario(responsavel) then
'response.Write responsavel & "<BR>" & assunto & "<BR>" & msgv & "<BR>"
				Call Enviar_Email(responsavel & SUFIXOEMAIL, responsavel, assunto, msg)
'				Call Enviar_Email("gilberto.rjo@gmail.com", "GILBERTO", assunto, msg)
'response.Write "<BR>FIM"
'response.End
			End If

		End If

	End if

End If


call ImprimeCabecalho2("", MENU_ON, true, "", "Pesquisa de Satisfação - CRT", linkVoltar, "")

If idacao <= 0 Then
	Response.Write "<br><p class='texto1' style='font-size: 12px;'>&nbsp;&nbsp;<b>Ocorreu um erro na execução desta ação</b></p>" & VbCrLf
else
	Response.Write "<scr" & "ipt lang" & "uage='JavaSc" & "ript'>" & VbCrLf

	'-- Excluiu um arquivo anexo à ação
	If Arquivo.Campo("id_ArquivoExclusao") <> "" Then
		Response.Write "opener.location.href = 'cad_evLogBookAcoes.asp?ocorrencia=" & Arquivo.Campo("ocorrencia") & "';" & VbCrLf
		Response.Write "location.href = 'cad_acLogBook.asp?idacao=" & Arquivo.Campo("idacao") & "&ocorrencia=" & Arquivo.Campo("ocorrencia") & "';" & VbCrLf
	Else
		'-- Remove uma acao tomada
		if Arquivo.Campo("remover") = "1" then
			Response.Write "location.href = 'cad_evLogBookAcoes.asp?ocorrencia=" & Arquivo.Campo("ocorrencia") & "';" & VbCrLf
		else
			'-- se for nova acao chamo do form de ocorrencias! caso contrario
			'-- chamo do form de acoes
			if EhnovaAcao then
				Response.Write "opener.frame_LB_acao.location.href = 'cad_evLogBookAcoes.asp?ocorrencia=" & Arquivo.Campo("ocorrencia") & "';" & VbCrLf
			else
				Response.Write "opener.location.href = 'cad_evLogBookAcoes.asp?ocorrencia=" & Arquivo.Campo("ocorrencia") & "';" & VbCrLf
			end if
			Response.Write "window.close();" & VbCrLf
		end if
	End If

	Response.Write "</scri" & "pt>" & VbCrLf
end if

Set Arquivo = Nothing

call imprimeRodape(RODAPE_OFF)
%>
