<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->

<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"
%>
<script language=javascript>
function Valida()	{
	var f = document.formulario;
	if (f.novafamilia.value == "")
		alert( "Família do componente inválida" );
	else	{
		f.target = "escondido";
		f.method = "post";
		f.action = "ins_novafamilia.asp"
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
<input type="hidden" name="fabricante" value="<%=Request.querystring("fabricante")%>">
<table width="100%" height="100%" class="trcadtit1" border="1" align="center" cellpadding="6" align="center">
<tr><td>
	<table width="100%" height="100%">
	<tr> 
		<td><font class="Fonttit3Cad"><b>Nome Fam&iacute;lia:</b></font></td>
		<td><input type="text" value="" name="novafamilia" size="40" maxlength="200" class="textbox"></td>
	</tr>
	</tr>
	<tr>
		<td colspan="2" align="center"><input type="button" name="btnOk" value="Ok" class="botao1" onclick="javascript:Valida();">
			&nbsp;&nbsp;<input type="button" name="btnCancela" value="Cancelar" class="botao1" onclick="javascript:window.close();">
		</td>
	</tr>
	</table>
</td></tr>
</table>
</form>
<script type="text/javascript">document.all.novafamilia.focus();</script>
<iframe name="escondido" frameborder="1" style="display:none; width:300px; height:100px;" scrolling="no"></iframe>
</body>
</html>