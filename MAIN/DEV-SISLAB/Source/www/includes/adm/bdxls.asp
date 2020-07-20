<!DOCTYPE html>

<!--#include file="../controlesXLS.asp" -->
<!--#include file="../Sislab_Lib.asp"-->
<html>
<head>
	<title>[XLS] Administração Remota de Banco de Dados SQL Server</title>
	<link rel="stylesheet" href="../../estilos/principal.css">
	<meta charset="UTF-8">
</head>
<body>
<%
Server.ScriptTimeout = 10000

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
Comando = UCase(Request.Form("sql"))
If Comando <> "" Then
'	Set objConexao = Server.CreateObject("ADODB.Connection")
'	objConexao.Open "Provider=sqloledb;User ID=ESP_ADMIN_ACESSO_REMOTO;Password=" + Request.Cookies("ADMPass") + "; Initial Catalog=ESPECIALISTAS; Data Source=DBD"

	If (InStr(Comando, "INSERT") <> 0) Or (InStr(Comando, "UPDATE") <> 0) Or (InStr(Comando, "DELETE") <> 0) Then
%>
<table align="center">
	<tr>
		<td align="justify">O seguinte comando não pode ser executado pois não é um comando de consulta (Select) ou existem comandos inválidos de consulta</td>
	</tr>
	<tr>
		<td align="justify" width="80%"><em><%=Replace(Comando, VbCrLf, "<br/>")%></em></td>
	</tr>
</table>
<%
	Else
		Set objComando = Server.CreateObject("ADODB.Command")
		Set objComando.ActiveConnection = Env.oConn

		objcomando.CommandText = Comando
		objComando.CommandType = adCmdText
		Env.oConn.IsolationLevel = adXactSerializable

		Set objRS = objComando.Execute
		If Env.oConn.Errors.Count > 0 Then
			Call ImprimeErrosConexao(Env.oConn.Errors)
		Else
			If UCase(TypeName(objRS)) = "RECORDSET" Then
				call criaExcelGeral("Exportação Geral", objRS, null)
			End If
		End If
	End If
%>
<p align="center"><button type="button" class="btn btn-primary" onClick="javascript:history.go(-1);">Voltar...</button></p>
<%Else%>
<script type="text/javascript">
function vai(){
	if(document.admin_remoto.sql.value == ""){
		alert("Digite alguma coisa!!!\nComo você vai executar um comando em branco no Banco de Dados??? ");
		document.admin_remoto.sql.focus();
	}
	else
		document.admin_remoto.submit();
}
</script>
<form name="admin_remoto" action="bdxls.asp" method="post">
<table align="center">
	<tr>
		<td align="center" colspan="2"><b>Exportação de Consultas para Excel</b><br><br></td>
	</tr>
	<tr>
		<td align="center">Comando SQL:</td>
		<td align="center"><textarea rows="20" cols="70" name="sql" wrap="off"></textarea></td>
	</tr>
	<tr>
		<td align="center" colspan="2"><br/><button type="button" class="btn btn-primary" onClick="vai();">Executar !</button></td>
	</tr>
</table>
</form>
<%End If%>
</body>
</html>
