<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/emailHTML.ASP" -->
<%
Dim chr_Buf

'-- redireciona caso expirado
if Env.usuario = "" or IsEmpty(Env.usuario) then response.redirect "msgAcessoNA.ASP"


'Dados Básico - Cliente -----------------------------------------------------------
usuario = request.form("username")
orgao = request.form("txtOrgao")
titulo = trocaPlic2Aspas(request("txtTitulo"))
data_inicio = request.form("diaINICIO") & "/" & request.form("mesINICIO") & "/" & request.form("anoINICIO")
data_fim = request.form("diaFIM") & "/" & request.form("mesFIM") & "/" & request.form("anoFIM")
'tipoatividade = ""'request.form("tipoatividade")
tecnologia = request.form("cmbTec")
sigilo = request.form("cmbSigilo")

'response.Write "sigilo: " & sigilo
'response.End

receber_email = request.form("cmbEmail")
if receber_email = "" then receber_email = "0"
objetivos = trocaPlic2Aspas(request.form("objetivos"))
ambiente = trocaPlic2Aspas(request.form("ambiente"))
recursos = trocaPlic2Aspas(request.form("recursos"))
obs = trocaPlic2Aspas(request.form("obs"))
ag = request("hdAG")

if request("cmbPartExternos") = "1" then
	listaParticipantesExternos = Trim(trocaPlic2Aspas(request("strParticipantesExternos")))
else
	listaParticipantesExternos = ""
end if

if request("cmbPartEBT") = "1" then
	listaParticipantesEBT = Trim(trocaPlic2Aspas(request("strParticipantesEBT")))
else
	listaParticipantesEBT = ""
end if

if CStr(request("cmbCliExternos")) = "1" then  '-- cliente interno embratel
	Cliente_Nome =  trocaPlic2Aspas(ucase(request("txtNomeCliente")))
	Cliente_Retorno =  replace(replace(request("txtRetornoCliente"), ".", ""), ",", ".")
	Cliente_ValorContrato = replace(replace(request("txtValorContratoCliente"), ".", ""), ",", ".")
	planodemetas = ""
else  '-- cliente externo embratel
	Cliente_Nome =  ""
	Cliente_Retorno = ""
	Cliente_ValorContrato = ""
	planodemetas = request("cmbItem")
end if

if ag = "" then ag = "null"

ssql = "exec sp_CadAgendamento '" & SEPARADOR_CAMPO & "','" & SEPARADOR_REGISTRO & "'," & ag & ",'" & titulo & "'," & receber_email & "," & tecnologia & ",'" & _
	   data_inicio & "','" & data_fim & "','" & sigilo & "','" & objetivos & "','" & _
	   ambiente & "','" & recursos & "','" & obs & "','" & usuario & "','" & orgao & "','" & Cliente_Nome & "'," & Cliente_Retorno & "," & Cliente_ValorContrato & "," & planodemetas & ",'" & listaParticipantesEBT & "','" & listaParticipantesExternos & "'"
ssql = replace(ssql,",,",",null,")
ssql = replace(ssql,"''","null")
ssql = replace(ssql,"'//'","null")
ssql = replace(ssql,",,",",null,")
ssql = replace(ssql,",0.00,",",null,")
ssql = replace(ssql, "'null'", "null")

'response.write ssql
'response.end

set objrs = Env.oConn.execute(ssql)

''ssql = "select top 1 ag_numero from agendamento order by ag_numero desc"
''call RecordSet( true, objrs, sSQL, objConn)

if ag <> "null" then	'-- edicao do agendamento
	response.redirect "CadAgendamentoCliente.asp?selecao=" & ag
else	'-- novo agendamento

	'-- envio email de aviso de cadastramento
	Dim objrs1, objrs2
	ssql = "SELECT S_DESCRICAO, S_MENSAGEM FROM Situacoes WHERE ID_SITUACAO = " & AS_Cadastrado
	call Env.RecordSet(true, objrs1, sSQL)

	Call Env.RecordSet(True, objrs2, "select ag_titulo from agendamento WHERE ag_numero = " & objrs(0))

	'Call Enviar_Email("gilberto.rj@ig.com.br", "gilberto.rj@ig.com.br", "SISLAB - AS" & objrs(0) & " - " & objrs2(0) & " (" & objrs1("S_DESCRICAO") & ")", replace(objrs1("S_MENSAGEM"), "pesqscr.asp", "pesqscr.asp?num_ag=" & objrs(0)) & "<BR><BR>")
	Call enviaEmailsAS(Env.oConn, objrs(0), "SISLAB - AS" & objrs(0) & " - " & objrs2(0) & " (" & objrs1("S_DESCRICAO") & ")", replace(objrs1("S_MENSAGEM"), "pesqscr.asp", "pesqscr.asp?num_ag=" & objrs(0)) & "<BR><BR>")

	call Env.RecordSet(false, objrs1, null)

	'-- imprime tela de confirmação do agendamento
	call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Agendamento - Cliente", "location.href='CadAgendamentoCliente.asp?selecao=" & objrs(0) & "'", "")

	chr_Buf = _
		"<table border='0' width='100%' class='tabela1'>" & _
		"<tr><td>&nbsp;</td></tr>" & _
		"<tr>" & _
		"	<td>" & _
		"	&nbsp;<b>Seu agendamento foi criado com o número : <span class='vermelho2'>" & objrs(0) & "</b></span>" & _
		"	</td>" & _
		"</tr>" & _
		"<tr><td>&nbsp;</td></tr>" & _
		"<tr>" & _
		"	<td>" & _
		"	&nbsp;Para adicionar arquivos ao agendamento, volte à tela de cadastro e clique no botão 'Anexar Arquivos'." & _
		"	</td>" & _
		"</tr>" & _
		"<tr><td>&nbsp;</td></tr>" & _
		"<tr>" & _
		"	<td>" & _
		"	<input type='Button' value='Voltar' onclick=javascript:location.href='CadAgendamentoCliente.asp?selecao=" & objrs(0) & "';>" & _
		"	</td>" & _
		"</tr>" & _
		"</table>"
	response.write chr_Buf

	call imprimeRodape(RODAPE_OFF)

	Set objrs1 = Nothing
	Set objrs2 = Nothing
%>
<script>
//	var resp
//	resp = confirm("Seu agendamento foi criado com o numero : <%'=objrs(0)%>.\n\nSe deseja adicionar arquivos a seu agendamento selecione OK,\ncaso contrário selecione CANCELA.");

//	alert("ATENÇÃO !\n\nSeu agendamento foi criado com o numero : <%'=objrs(0)%>.");

//	if (resp == false)
//		window.location.replace("index.asp")
//	else
//		window.location.replace("CadAgendamentoCliente.asp?selecao=<%'=objrs(0)%>");
</script>
<%end if%>
