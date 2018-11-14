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
	if (f.novotipo.value == "")
		alert( "Tipo do componente inválido" );
	else if (f.familia.value == "")
		alert( "Nenhuma família selecionada" );
	else if (f.fabricante.value == "")
		alert( "Nenhum fabricante selecionado" );
	else	{
		f.target = "escondido";
		f.method = "post";
		f.action = "ins_novotipo.asp"
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
	<td><font class="Fonttit3Cad"><b>Novo Tipo:</b></font></td>
	<td><input type="text" value="" name="novotipo" size="40" maxlength="50" class="textbox"></td>
</tr>
<tr> 
	<td><font class="Fonttit3Cad"><b>Fam&iacute;lia:</b></font></td>
	<td><%
		dim objConn, objRS
		call Env.RecordSet(true, objRS, "select * from FAC_Familia_Tipo_Componente order by FTC_NOME")
		if not (objRS.EOF and objRS.BOF) then%>
			<select name="familia" ><option value="">-- Selecione uma fam&iacute;lia --</option><%
			while not objRS.EOF%>
				<option value="<%=objRS("FTC_ID")%>"><%=objRS("FTC_NOME")%></option>
<%			objRS.MoveNext
			wend%>
			</select>
<%	else%>
			<font class="Fonttit3Cad"><b><i>Nenhuma fam&iacute;lia cadastrada</i></b></font>
			<input type="hidden" name="familia" value="">
<%	end if
		call Env.RecordSet(false, objRS, null)%>
		&nbsp;&nbsp;<input type="button" value="+" class="botao0" onclick="javascript:window.open('novafamilia.asp?fabricante='+document.formulario.fabricante.value, 'FAMILIA', 'width=420, height=70, toolbar=no, status=no, menubar=no, scrollbars=no');">
	</td>
</tr>
<tr> 
	<td><font class="Fonttit3Cad"><b>Fabricante:</b></font></td>
	<td><%
		call Env.RecordSet(true, objRS, "select * from FAC_Fabricante_Tipo_Componente order by FAB_NOME")
		if not (objRS.EOF and objRS.BOF) then%>
			<select name="fabricante" ><option value="">-- Selecione um Fabricante --</option><%
			while not objRS.EOF%>
				<option value="<%=objRS("FAB_ID")%>"><%=objRS("FAB_NOME")%></option>
<%			objRS.MoveNext
			wend%>
			</select>
<%	else%>
			<font class="Fonttit3Cad"><b><i>Nenhum fabricante cadastrado</i></b></font>
			<input type="hidden" name="fabricante" value="">
<%	end if
		call Env.RecordSet(false, objRS, null)
%>
		&nbsp;&nbsp;<input type="button" value="+" class="botao0" onclick="javascript:window.open('novofabricante.asp?familia='+document.formulario.familia.value, 'FABRICANTE', 'width=420, height=70, toolbar=no, status=no, menubar=no, scrollbars=no');">
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2" align="center"><input type="button" name="btnOk" value="Ok" class="botao1" onclick="javascript:Valida();">
		&nbsp;&nbsp;<input type="button" name="btnCancela" value="Cancelar" class="botao1" onclick="javascript:window.close();">
	</td>
</tr>
</table>
</td></tr>
</table>
</form>
<script type="text/javascript"><%
if Request.querystring("familia") <> "" then%>
	document.all.familia.value = <%=Request.querystring("familia")%><%
end if
if Request.querystring("fabricante") <> "" then%>
	document.all.fabricante.value = <%=Request.querystring("fabricante")%><%
end if%>
document.all.novotipo.focus();
</script>
<iframe name="escondido" frameborder="1" style="display:none; width:300px; height:100px;" scrolling="no"></iframe>
</body>
</html>