<%option explicit
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"
%>
<script language=javascript>
function Valida()	{
	var f = document.formulario;
	if (f.novolocal.value == "")
		alert( "Local genérico inválido" );
	else	{
		f.target = "escondido";
		f.action = "ins_novolocalgenerico.asp"
		f.submit();
	}
}
</script>
<html>
<head>
	<title>Site do Centro de Referência Tecnológica</title>
	<meta http-equiv="Pragma" content="no-cache">
	<link rel="stylesheet" href="includes/style.css">
</head>
<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 scroll="no">
<form name="formulario" method="post">
<table width="100%" height="100%" class="trcadtit1" border="1" align="center" cellpadding="6" align="center">
<tr><td>
<table width="100%" height="100%">
<tr> 
	<td><font class="Fonttit3Cad"><b>Novo local:</b></font></td>
	<td><input type="text" value="" name="novolocal" size="40" maxlength="50" class="textbox"></td>
</tr>
<tr> 
	<td><font class="Fonttit3Cad"><b>Tipo:</b></font></td>
	<td><font class="Fonttit3Cad"><input type="Radio" name="tipo" checked value="E">Externo&nbsp;&nbsp;&nbsp;&nbsp;<input type="Radio" name="tipo" value="I">Interno</font></td>
</tr>
<tr><td colspan="2"></td></tr>
<tr>
	<td colspan="2" align="center"><input type="button" name="btnOk" value="Ok" class="botao1" onclick="javascript:Valida();">
		&nbsp;&nbsp;<input type="button" name="btnCancela" value="Cancelar" class="botao1" onclick="javascript:window.close();">
	</td>
</tr>
</table>
</td></tr>
</table>
</form>	<!-- display:none; -->
<script language="JavaScript">document.all.novolocal.focus();</script>
<iframe name="escondido" frameborder="1" style="display:none; width:300px; height:100px;" scrolling="no"></iframe>
</body>
</html>