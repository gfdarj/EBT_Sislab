<%Option Explicit%>
<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->
<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"

Dim objRS, objConn, s, localgenerico

localgenerico = request.querystring("local")
if localgenerico = "" then localgenerico = -1
%>
<html>
<head>
	<title>Site do Centro de Referência Tecnológica</title>
	<meta http-equiv="Pragma" content="no-cache">
	<link rel="stylesheet" href="includes/style.css">
</head>
<body topmargin=0 leftmargin=0 scroll="no">
<script type="text/javascript">
function Adicionar()
{
	var f = document.formulario;
	if(f.local.value == "" )
		alert( "Não é permitido adicionar um local vazio." );
	else
	{
		f.target = "escondido";
		f.action = "ins_localespecifico.asp";
		f.submit();
	}
}
function Remover()
{
	var f = document.formulario;
	if( (f.locais.selectedIndex < 0) || (f.locais.length < 1) )
		alert( "Nenhum local selecionado." );
	else
	{
		f.target = "escondido";
		f.action = "exc_localespecifico.asp";
		f.submit();
	}
}
function AtualizaLocais(s)
{ document.all.cel_locais.innerHTML = s;	document.formulario.local.value = ""; }
</script>

<form name="formulario" method="post">
<input type="hidden" name="localgenerico" value="<%=localgenerico%>">
<table width="100%" height="100%" class="trCadtit1" border="0">
<tr>
	<td valign="top" width="400">
		<font class="Fonttit3Cad"><b>Local Específico:</b></font><br>
		<input type="text" name="local" value="" size="40" maxlength="50">&nbsp;&nbsp;&nbsp;
		<input type="button" class="botao0" name="btnAdiciona" value="+" onclick="Adicionar();">
		<input type="button" class="botao0" name="btnRemove" value="-" onclick="Remover();">
	</td>
	<td align="left" valign="top" id="cel_locais">
		<font class="Fonttit3Cad"><b>Locais Espec&iacute;ficos:</b></font><br>
		<select multiple name="locais" style="width: 200px;" size="6" >
<%	s = "select e.LEE_ID, e.LEE_NOME from FAC_Locais_Especificos_Equip e "
		s = s & "where e.LGE_ID = " & localgenerico & " order by e.LEE_NOME"
		call Env.RecordSet(true, objRS, s)
		while not objRS.EOF	%>
			<option value="<%=objRS("LEE_ID")%>"><%=objRS("LEE_NOME")%></option><%
			objRS.MoveNext
		wend
		call Env.RecordSet(false, objRS, s)%>
		</select>
	</td>
</tr>
</table>
</form><!-- -->
<iframe name="escondido" scrolling="Yes" src="" frameborder="0" style="display:none; width:300px; height:100px;"></iframe>
</body>
</html>