<!--#include file="adovbs.inc"-->
<%Sub Connection(opcao, conexao)
	On Error Resume Next 'necessário novamente devido à forma como este comando foi implementado
	If(opcao)Then
		Set conexao = Server.CreateObject("ADODB.Connection")
		conexao.Open "Provider=sqloledb;User ID=sislab1;Password=sislab1001; Initial Catalog=SISLAB; Data Source=ntspo006"
'		conexao.Open "Provider=sqloledb;User ID=sislab1;Password=sislab1; Initial Catalog=SISLAB1; Data Source=dbd"
'		conexao.Open "Provider=sqloledb;User ID=sislab1;Password=sislab1; Initial Catalog=SISLAB1_SEGURANCA; Data Source=dbd"
		If conexao.Errors.Count > 0 Then Call ImprimeErrosConexao(conexao.Errors)
	Else
		conexao.Close
		Set conexao = Nothing
	End If
End Sub

Sub RecordSet(opcao, record, strExec, conexao)
	If(opcao)Then
		Set record = Server.CreateObject("ADODB.RecordSet")
		record.Open strExec, conexao', adOpenKeySet
	Else
		record.close
		Set record = Nothing
	End If
End Sub

Sub StoredProcedure(opcao, command, strExec, conexao)
	If(opcao)Then
		Set command = Server.CreateObject("ADODB.Command")
		command.CommandType = adCmdStoredProc
		command.CommandText = strExec
		Set command.ActiveConnection = conexao
	Else
		Set command.ActiveConnection = Nothing
		Set command = Nothing
	End If
End Sub

Sub ImprimeErrosConexao( objErro )
	Dim objTmp

	Response.Clear%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Erro de conexão</title>
	<link rel="stylesheet" type="text/css" href="../css/cirap.css"/>
</head>

<body>
<br/>
<table width="70%" align="center" bordercolor="#000099" border="1">
	<tr class="tlabel">
		<td align="center" colspan="2">Ocorreu algum erro ao tentar se conectar ao banco de dados.<br/>Se o erro persistir, contacte o webmaster deste site, fornecendo as seguintes informações:</td>
	</tr>
<%	For Each objTmp in objErro%>
	<tr>
		<td><br/>Código do Erro:</td>
		<td><br/><%=objTmp.Number%>&nbsp;</td>
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
<%	Next%>
</table>
</body>
</html>
<%	Response.End
End Sub%>
