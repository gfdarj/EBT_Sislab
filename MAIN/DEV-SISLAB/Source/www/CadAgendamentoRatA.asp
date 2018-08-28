<!--#include file="includes/Sislab_Lib.asp"-->
<!--#in clude file="includes/conexao.inc" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/emailHTML.ASP" -->
<!--#include file="includes/bib_mensagem.asp" -->
<%
'-- redireciona caso expirado
if Env.usuario = "" or IsEmpty(Env.usuario) then response.redirect "msgAcessoNA.ASP"

Dim int_Achou
Dim int_Situacao
Dim situacao_atual
Dim listaParticipantesEBT : listaParticipantesEBT = ""
Dim chr_RAT_Original
Dim chr_RT_Original
Dim chr_AmbientesOriginal
Dim chr_TextoAmbiente
Dim chr_TextoMudanca
Dim chr_TextoMudancaDesalocacaoRT
Dim bln_MudouAmbiente
Dim bln_MudouRAT
Dim bln_MudouRT
Dim chr_tituloAG
Dim chr_TituloEmail

bln_MudouAmbiente = False
bln_MudouRAT = False
bln_MudouRT = False


'Dados Básico - Cliente -----------------------------------------------------------
situacao = RQ("cmbSituacao")
orgao = RQ("txtOrgao")
'data_inicio = request.form("diaINICIO") & "/" & request.form("mesINICIO") & "/" & request.form("anoINICIO")
'hora_inicio = request.form("horaINICIO") & ":" & request.form("minutoINICIO")
datahora = Trim(request.form("diaINICIO") & "/" & request.form("mesINICIO") & "/" & request.form("anoINICIO")) & " " & Trim(request.form("horaINICIO") & ":" & request.form("minutoINICIO"))
if datahora = "// :" then datahora = ""  '-- data vazia
responsavel = UCase(RQ("cmbRESP"))
rat = UCase(RQ("cmbRATRESP"))
tem_os = RQ("cmbOS")

chr_RAT_Original = UCase(RQ("RAT_Original"))
chr_RT_Original = UCase(RQ("RT_Original"))

motivo = RQ("motivo")
num_ag = RQ("hdAG")
relatAS = limpaTexto(RQ("relatAS"))

listaParticipantesEBT = Trim(trocaPlic2Aspas(request("strParticipantesEBT")))

tipoatividade = request.form("tipoatividade")
AUXExecutante = (request("chkExecutante") = "on")
IF AUXExecutante THEN AUXExecutante = 1 ELSE AUXExecutante = 0

AUXrepetido = (request("chkRepeticao") = "on")
IF AUXrepetido THEN AUXrepetido = 1 ELSE AUXrepetido = 0

ambientes = trim(request("strAmbientes")) '-- lista de ambientes
if ambientes = SEPARADOR_REGISTRO then ambientes = ""

chr_AmbientesOriginal = trim(request("strAmbientesOriginal")) '-- lista de ambientes Originais
if chr_AmbientesOriginal = SEPARADOR_REGISTRO then chr_AmbientesOriginal = ""

'--------------------------------------------------------

'-- pego a situacao atual da AS
ssql = "select ID_SITUACAO, AG_TITULO from vw_Agendamento where ag_numero = " & num_ag
call Env.RecordSet( true, objrs, sSQL)
situacao_atual = objRS("ID_SITUACAO")
chr_tituloAG = objRS("AG_TITULO")
if isNull(situacao_atual) then situacao_atual = 0
call Env.RecordSet( false, objrs, sSQL)

ssql = "select os_id from ordem_de_servico where ag_numero = " & num_ag
call Env.RecordSet( true, objrs, sSQL)

'Verifico se o agendamento tem os não finalizadas
estadosFinaisOS = "#" & OS_Indeferido & "#" & OS_Cancelado & "#" & OS_Finalizado & "#"
estadosFinaisAS = "#" & AS_Indeferido & "#" & AS_Cancelado & "#" & AS_Finalizado & "#"
tem_os_nao_finalizada = False

chr_TituloEmail = "SISLAB - AS" & num_ag & " - " & IIf(VVVN(chr_tituloAG), "***", chr_tituloAG)

while not objrs.eof 
	ssql = "select h.id_situacao from historico_eventosos h " & _
		" inner join situacoes s on h.id_situacao = s.id_situacao " & _
		" where heos_id in (select max(heos_id) from historico_eventosos where os_id = " & objrs("os_id") & " and ag_numero = " & num_ag & ")"
	call Env.RecordSet( true, objrs1, sSQL)

	If Not (objrs1.Eof And objrs1.Bof) Then
		int_Situacao = objrs1("id_situacao")
		If Not IsNull(int_Situacao) Then
			int_Achou = instr(estadosFinaisOS,"#" & int_Situacao & "#")

			If int_Achou = 0 Then
				tem_os_nao_finalizada = True
			End If
		End If
	End If

	objrs.movenext
wend

'SE FOR ESTADO FINAL E AINDA TIVER OS NÃO FINALIZADAS
if (tem_os_nao_finalizada and instr(estadosFinaisAS, "#" & situacao & "#") > 0 ) then%>
	<SCRIPT>
		alert("Não é possível finalizar este agendamento pois existem OS's não finalizadas para este agendamento.")
		window.location.replace("CadAgendamentoRAT.asp?hdAG=<%=num_ag%>")
	</SCRIPT>
<%
Else
	'### Grava a AS
	if num_ag = "" then num_ag = "null"
	ssql = "exec sp_CadAgendamentoRAT '" & SEPARADOR_CAMPO & "','" & SEPARADOR_REGISTRO & "'," & num_ag & "," & tipoatividade & "," & situacao & ",'" & motivo & "','" & responsavel & "','" & _
		   rat & "','" & datahora &  "'," & tem_os & ",'" & relatAS & "'," & AUXrepetido & "," & AUXExecutante & ",'" & ambientes & "','" & listaParticipantesEBT & "'"

	ssql = PreparaStrSQL(ssql)

	'response.write ssql
	'response.end

	Dim objRet, rsAmbNovo, rsAmbRetirado
	Set objRet = Env.oConn.execute(ssql)
	If objRet(0) > 0 then	'-- gravacao OK

		'-- Envia email caso a situação seja diferente
		If CStr(situacao) <> CStr(situacao_atual) then

			'### se finalizar a AS, manda uma mensagem extra e "amigável" com o nome do RT, solicitando ao
			'### usuário para que responda a pesquisa
			If CStr(situacao) = CStr(AS_Finalizado) Then
				Call EnviaEmailRespondaPesquisa(num_ag)
				Call EnviaEmailTemEquipamentoTerceiro(num_ag)
			End If

			Dim pesq
			pesq = "pesqsCR.asp?num_ag=" & num_ag
			ssql = "SELECT S_DESCRICAO, S_MENSAGEM FROM Situacoes WHERE ID_SITUACAO = " & situacao
			Call Env.RecordSet(True, objrs1, sSQL)

			''Call Enviar_Email("gilberto.rj@ig.com.br", "gilberto.rj@ig.com.br", chr_TituloEmail & " (" & objrs1("S_DESCRICAO") & ")", replace(objrs1("S_MENSAGEM"), "pesqscr.asp", pesq))
			'If CStr(situacao) = CStr(AS_Finalizado) Then
			'	Call enviaEmailsASFinalizada(objConn, num_ag, chr_TituloEmail & " (" & objrs1("S_DESCRICAO") & ")", replace(objrs1("S_MENSAGEM"), "pesqscr.asp", pesq) & "<BR><BR>")
			'Else
				Call enviaEmailsAS(Env.oConn, num_ag, chr_TituloEmail & " (" & objrs1("S_DESCRICAO") & ")", replace(objrs1("S_MENSAGEM"), "pesqscr.asp", pesq) & "<BR><BR>")
			'End If

			Call Env.RecordSet(False, objrs1, Null)
		Else
			'>>> VERIFICA SE HOUVE MUDANCA NOS AMBIENTES
			Set rsAmbNovo = Env.oConn.execute(_
				"/*** AMBIENTES ADICIONADOS ***/" & VbCrLf & _
				"--ambiente novo" & VbCrLf & _
				"select amb_id, amb_nome" & VbCrLf & _
				"from ambientes" & VbCrLf & _
				"where amb_id in (" & Replace(Ambientes, SEPARADOR_REGISTRO, ",") & "-99)" & VbCrLf & _
				"and amb_id not in (" & VbCrLf & _
				"	--ambiente atual" & VbCrLf & _
				"	select amb_id" & VbCrLf & _
				"	from ambientes" & VbCrLf & _
				"	where amb_id in (" & Replace(chr_AmbientesOriginal, SEPARADOR_REGISTRO, ",") & "-99)" & VbCrLf & _
				")" & VbCrLf _
			)

			Set rsAmbRetirado = Env.oConn.execute(_
				"/*** AMBIENTES RETIRADOS ***/" & VbCrLf & _
				"--ambiente atual" & VbCrLf & _
				"select amb_id, amb_nome" & VbCrLf & _
				"from ambientes" & VbCrLf & _
				"where amb_id in (" & Replace(chr_AmbientesOriginal, SEPARADOR_REGISTRO, ",") & "-99)" & VbCrLf & _
				"and amb_id not in (" & VbCrLf & _
				"	--ambiente novo" & VbCrLf & _
				"	select amb_id" & VbCrLf & _
				"	from ambientes" & VbCrLf & _
				"	where amb_id in (" & Replace(Ambientes, SEPARADOR_REGISTRO, ",") & "-99)" & VbCrLf & _
				")" & VbCrLf _
			)

			bln_MudouAmbiente = ((Not (rsAmbNovo.Eof And rsAmbNovo.Bof)) Or (Not (rsAmbRetirado.Eof And rsAmbRetirado.Bof)))

			If bln_MudouAmbiente Then
				chr_TextoAmbiente = ""

				If Not rsAmbNovo.Eof Then
					chr_TextoAmbiente = "Adicionados:<BR>"
					While Not rsAmbNovo.Eof
						chr_TextoAmbiente = chr_TextoAmbiente & rsAmbNovo(0) & " - " & rsAmbNovo(1) & "<BR>"
						rsAmbNovo.MoveNext
					WEnd
				End If

				If Not rsAmbRetirado.Eof Then
					If chr_TextoAmbiente <> "" Then chr_TextoAmbiente = chr_TextoAmbiente & "<BR><BR>"
					chr_TextoAmbiente = chr_TextoAmbiente & "Retirados:<BR>"
					While Not rsAmbRetirado.Eof
						chr_TextoAmbiente = chr_TextoAmbiente & rsAmbRetirado(0) & " - " & rsAmbRetirado(1) & "<BR>"
						rsAmbRetirado.MoveNext
					WEnd
				End If
				chr_TextoAmbiente = "Os ambientes de teste sofreram as seguintes alterações:<BR><BR>" & chr_TextoAmbiente & "<BR><BR>(Mensagem automática)<BR>"
			End If

			rsAmbNovo.Close
			rsAmbRetirado.Close
			Set rsAmbNovo = Nothing
			Set rsAmbRetirado = Nothing

			bln_MudouRAT = (chr_RAT_Original <> Rat)
			bln_MudouRT = (chr_RT_Original <> Responsavel)

			'>>> Avisa ao novo RAT que ele foi selecionado para uma AS
			If bln_MudouRAT Then
				chr_TextoMudanca = "Você foi designado para ser o RAT deste Agendamento de Serviço.<BR><BR>"
				If bln_MudouAmbiente Then chr_TextoMudanca = chr_TextoMudanca & "<BR>" & chr_TextoAmbiente Else chr_TextoMudanca = chr_TextoMudanca & "(Mensagem automática)<BR>"

				Call Enviar_Email(Rat, Rat, chr_TituloEmail & " (Mudança de RAT)", chr_TextoMudanca)

			ElseIf bln_MudouAmbiente Then
				Call Enviar_Email(Rat, Rat, chr_TituloEmail & " (Mudança de Ambiente)", chr_TextoAmbiente)
			End If

			'>>> Avisa ao novo RT que ele foi selecionado para uma AS
			If bln_MudouRT Then
				chr_TextoMudanca = "Você foi designado para ser o Responsável Técnico deste Agendamento de Serviço.<BR><BR>"
				If bln_MudouAmbiente Then chr_TextoMudanca = chr_TextoMudanca & "<BR>" & chr_TextoAmbiente Else chr_TextoMudanca = chr_TextoMudanca & "(Mensagem automática)<BR>"

				Call Enviar_Email(Responsavel, Responsavel, chr_TituloEmail & " (Mudança de RT)", chr_TextoMudanca)

				If chr_RT_Original <> "" Then
					chr_TextoMudancaDesalocacaoRT = "Este agendamento mudou de Responsável Técnico. O novo Responsável é <b>" & Responsavel & "</b>.<BR><BR>(Mensagem automática).<BR>"
					Call Enviar_Email(chr_RT_Original, chr_RT_Original, chr_TituloEmail & " (Mudança de RT)", chr_TextoMudancaDesalocacaoRT)
				End If

			ElseIf bln_MudouAmbiente Then
				Call Enviar_Email(Responsavel, Responsavel, chr_TituloEmail & " (Mudança de Ambiente)", chr_TextoAmbiente)
			End If

		End If

		Response.Redirect "CadAgendamentoRAT.asp?hdAG=" & num_ag
	Else
		Call MsgGravacaoDados(True, False, "<br><p class='texto1' style='font-size: 12px;'>&nbsp;&nbsp;<b>Erro na gravação deste agendamento</b>", "CadAgendamentoRat.asp?hdAG=" & num_ag, "")
	End If

	objRet.Close
	Set objRet = Nothing
End If
%>