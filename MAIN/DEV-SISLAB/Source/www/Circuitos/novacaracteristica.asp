<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"
%>
<script language=javascript>
function Valida()	{
	var f = document.formulario;
	if ( f.novacarac.value == "" )
		alert( "Característica inválida" );
	else if ( f.definicao.value.length > 5000 )
		alert( "Tamanho inválido para a Definição (5000 caracteres)." );
	else	{
		f.target = "escondido";
		f.method = "post";
		f.action = "ins_novacaracteristica.asp"
		f.submit();
	}
}
</script>
<html>
<head>
	<title>Nova Caracter&iacute;stica - Site do Centro de Referência Tecnológica</title>
	<meta http-equiv="Pragma" content="no-cache">
	<link rel="stylesheet" href="includes/style.css">
</head>
<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 scroll="no">
<form name="formulario" method="post">
<input type="Hidden" name="tipo" value="<%request.querystring("tipo")%>">
<table width="100%" height="100%" class="trcadtit1" border="1" align="center" cellpadding="6" align="center">
<tr><td>
<table>
<tr> 
	<td><font class="Fonttit3Cad"><b>Nome:</b></font></td>
	<td><input type="Text" value="" name="novacarac" size="50" maxlength="50" class="textbox"></td>
</tr>
<tr> 
	<td valign="top"><font class="Fonttit3Cad"><b>Defini&ccedil;&atilde;o:</b></font></td>
	<td><textarea name="definicao" rows="7" cols="43"></textarea></td>
</tr>
<tr>
	<td colspan="2" align="center"><input type="Button" name="btnOk" value="Ok" class="botao1" onclick="javascript:Valida();">
		&nbsp;&nbsp;<input type="Button" name="btnCancela" value="Cancelar" class="botao1" onclick="javascript:window.close();">
	</td>
</tr>
</table>
</td></tr>
</table>
</form>	<!-- display:none; -->
<script language="JavaScript">document.all.novacarac.focus();</script>
<iframe name="escondido" frameborder="0" style=" width:300px; height:100px;" scrolling="no"></iframe>
</body>
</html>