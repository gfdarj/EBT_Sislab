<%If Err.Number <> 0 Then
	Response.Clear%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>ERRO!</title>
</head>

<body>
<table border="1" bgcolor="#ff0000" bordercolor="#ffffff" width="70%" align="center">
	<tr>
		<td align="center">
			<font color="#ffffff"><strong>Ocorreu um erro inesperado!<BR>Se o erro persistir, entre em contato com o webmaster deste site.<BR>Segue abaixo uma descrição mais detalhada do erro.</strong></font>
		</td>
	</tr>
</table>
<BR>
<table border="1" bordercolor="#0000ff" width="70%" align="center">
	<tr>
		<td width="50%" align="left"><strong>Número do erro:</strong></td>
		<td width="50%" align="right">&nbsp;<%=Err.Number%></td>
	</tr>
	<tr>
		<td width="50%" align="left"><strong>Descrição do erro:</strong></td>
		<td width="50%" align="right">&nbsp;<%=Err.Description%></td>
	</tr>
	<tr>
		<td width="50%" align="left"><strong>Script gerador do erro:</strong></td>
		<td width="50%" align="right">&nbsp;<%=Err.Source%></td>
	</tr>
</table>
<BR>
<table border="0" width="70%" align="center">
	<tr>
		<td align="center"><input type="button" value="Voltar" onclick="javascript:history.go(-1);"></td>
	</tr>
</table>

</body>
</html>
<%Err.Clear
End If
Response.End%>