<!--#include file="../Sislab_Lib.asp"-->
<!doctype html>

<html>

<head>
    <meta charset="<%=Application("SISLAB_CHARSET")%>" />
	<title>Administração Remota de Banco de Dados SQL Server</title>
	<link rel="stylesheet" href="../../css/cirap_adm.css">
</head>

<body>
<%
'Server.ScriptTimeout = 10000000000000

'if Not Env.ehRat then response.redirect "../../index.asp"

Dim objConexao, objComando, objRS, Comando, tmp
On Error Resume Next

Sub ImprimeErros( objErro, cmd )
	Dim objTmp%>
<br/>
<table align="center" border="1">
	<tr>
		<td colspan="2"><strong>Ocorreu algum erro ao processar seu comando. Seguem maiores informações abaixo</strong></td>
	</tr>
	<tr>
		<td>Comando recebido:</td>
		<td><%=cmd%>&nbsp;</td>
	</tr>
<%	For Each objTmp in objErro%>
	<tr>
		<td>Código do Erro:</td>
		<td><%=objTmp.Number%>&nbsp;</td>
	</tr>
	<tr>
		<td>Código ADO do Erro:</td>
		<td><%=objTmp.NativeError%>&nbsp;</td>
	</tr>
	<tr>
		<td>Descrição:</td>
		<td><%=objTmp.Description%>&nbsp;</td>
	</tr>
	<tr>
		<td>Comando que gerou o erro:</td>
		<td><%=objTmp.SQLState%>&nbsp;</td>
	</tr>
	<tr>
		<td>Gerador do erro:</td>
		<td><%=objTmp.Source%>&nbsp;</td>
	</tr>
	<tr>
		<td>Arquivo de ajuda associado:</td>
		<td><%=objTmp.HelpFile%>&nbsp;</td>
	</tr>
	<tr>
		<td>Tópico de ajuda associado:</td>
		<td><%=objTmp.HelpContext%>&nbsp;</td>
	</tr>
</table>
<%	Next
End Sub
Comando = Request.Form("sql")
If Comando <> "" Then
'	Set objConexao = Server.CreateObject("ADODB.Connection")
'	objConexao.Open "Provider=sqloledb;User ID=ESP_ADMIN_ACESSO_REMOTO;Password=" + Request.Cookies("ADMPass") + "; Initial Catalog=ESPECIALISTAS; Data Source=DBD"

	Set objComando = Server.CreateObject("ADODB.Command")
	Set objComando.ActiveConnection = Env.oConn

	objcomando.CommandText = Comando
	objComando.CommandType = adCmdText
	objConexao.IsolationLevel = adXactSerializable

	Call Env.oConn.BeginTrans

	Set objRS = objComando.Execute
	If Env.oConn.Errors.Count > 0 Then
		Call Env.oConn.RollBackTrans
		Call ImprimeErrosConexao(Env.oConn.Errors)
	Else%>
<table align="center">
	<tr>
		<td align="justify">O seguinte comando foi executado com êxito no banco de dados:</td>
	</tr>
	<tr>
		<td align="justify" width="80%"><em><%=Replace(Comando, VbCrLf, "<br/>")%></em></td>
	</tr>
<%		If UCase(TypeName(objRS)) = "RECORDSET" Then%>
	<tr>
		<td align="justify">Este comando retornou o seguinte resultado:</td>
	</tr>
<%			Do Until objRS is Nothing
				If objRS.State <> 0 Then%>
	<tr>
		<td align="justify"><br/>
			<table border="1">
				<tr>
<%					For each tmp in objRS.Fields%>
					<td><strong><%=tmp.Name%></strong></td>
<%					Next%>
				</tr>
<%					While NOT objRS.EOF%>
				<tr>
<%						For each tmp in objRS.Fields%>
					<td><%=tmp.Value%>&nbsp;</td>
<%						Next
						objRS.MoveNext%>
				</tr>
<%					Wend%>
			</table>
		</td>
	</tr>
<%				End If
				Set objRS = objRS.NextRecordSet
			Loop
		End If%>
</table>
<%		Call Env.oConn.CommitTrans
	End If%>
<p align="center"><button type="button" onclick="javascript:history.go(-1);">Voltar...</button></p>
<%Else%>
<script language="JavaScript">
function vai(){
	if(document.admin_remoto.sql.value == ""){
		alert("Digite alguma coisa!!!\nComo você vai executar um comando em branco no Banco de Dados??? ");
		document.admin_remoto.sql.focus();
	}
	else
		document.admin_remoto.submit();
}
</script>
<form name="admin_remoto" action="bd.asp" method="post">
<table align="center">
	<tr>
		<td align="center">Comando SQL:</td>
		<td align="center"><textarea rows="20" cols="70" name="sql" wrap="off"></textarea></td>
	</tr>
	<tr>
		<td align="center" colspan="2"><br/><button type="button" onclick="vai();">Executar !</button></td>
	</tr>
</table>
</form>
<%End If%>
</body>

</html>
