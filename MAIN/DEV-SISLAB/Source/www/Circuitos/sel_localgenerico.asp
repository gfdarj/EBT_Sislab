<!-- #INCLUDE FILE="includes/montatela.inc" -->

<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->
<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"
%>
<html>
<head>
	<title>Site do Centro de Referência Tecnológica</title>
	<meta http-equiv="Pragma" content="no-cache">
	<link rel="stylesheet" href="includes/style.css">
</head>
<script language="JavaScript" src="includes/qtd_caract.js"></script>
<script language="JavaScript">
function DadosLocal(eu)
{	var f = document.all;
	if( eu.value == "" )
	{
//		alert( "Nenhum local selecionado" );
		f.localgenerico.style.display = "none";
	}
	else
	{
		f.localgenerico.style.display = "block";
		f.localgenerico.src = "cad_localespecifico.asp?local=" + eu.value;
	}
}
function CadastraLocais()
{
	var car = "", qtd = "", i, fc = window.frames["localgenerico"].document.formulario;

	for( i=0; i<fc.carac_comp.length; i++)
	{
		car += fc.carac_comp[i].value + ",";
		qtd += ExtraiQtdeSemPar(fc.carac_comp[i].text) + ",";
	}

	document.formulario.lista_car.value = car.substring(0, car.length-1);
	document.formulario.lista_qtd.value = qtd.substring(0, qtd.length-1);
	document.formulario.action = "ins_locais.asp";
	document.formulario.target = "escondido";
	document.formulario.submit(); 
}
function ApagaLocal()
{	var eu = document.formulario.local;
	if( eu.value == "" )
		alert( "Nenhum local selecionado" );
	else
		alert( 'Terminar o apagar');
}
</script>
<body topmargin=0 leftmargin=0 scroll="auto">
<%
Call MostraHeader
%>
<form name="formulario" method="post">
<input type="Hidden" name="lista_car" value="">
<input type="Hidden" name="lista_qtd" value="">
<table width="700" class="trcadtit1" border="1" align="center">
<tr> 
	<td width="60"></td>
	<td width="640"></td>
</tr>
<tr>
  <td colspan="2" bgcolor="#000030" align="right"><font face="tahoma" style="font-size=10pt" color="#FFFFFF">&nbsp;<B><a href="index.asp" class="Menu">Voltar</a></B>&nbsp;&nbsp;&nbsp;<br></font></td>
</tr>

<tr valign="middle" class="trcadtit2"> 
  <td colspan="2" align="left"><font  class="fonttit1cad"><b>&nbsp;&nbsp;&nbsp;Cadastro de Locais Gen&eacute;ricos - CRT</b></font></td>
</tr>

<tr>
	<td><font class="Fonttit3Cad"><b>Local:</b></font></td>
	<td>
		<%
		dim objRS, objConn
		call Env.RecordSet(true, objRS, "select * from FAC_LOCAIS_GENERICOS_EQUIP order by LGE_NOME")
		if not ( objRS.EOF and ObjRS.BOF ) then		%>
			<select name="local" class="combo" onchange="javascript:DadosLocal(this);">
			<option value="">-- Selecione o Local gen&eacute;rico --</option><%
			while not objRS.EOF	%>
				<option value="<%=objRS("LGE_ID")%>"><%
					response.write objRS("LGE_NOME")
					if objRS("LGE_TIPO") = "I" then
						response.write " (Interno)"
					else
						response.write " (Externo)"
					end if%>
					</option>		<%
				objRS.MoveNext
			wend	%>
			</select>	<%
		else	%>
			<font class="Fonttit3Cad"><b><i>Nenhum Local foi encontrado !</i></b></font>	<%
		end if
		call Env.RecordSet(false, objRS, null)
		%>
		&nbsp;&nbsp;&nbsp;
		<input type="Button" class="botao0" value="+" onclick="javascript:window.open('novolocalgenerico.asp', 'GENERICO', 'width=420, height=70, toolbar=no, status=no, menubar=no, scrollbars=no');">
		<input type="Button" class="botao0" value="-" disabled onclick="ApagaLocal();">
	</td>
</tr>
<tr><td width="100%" colspan="2"><iframe name="localgenerico" src="" scrolling="Auto" frameborder="0" style="display: none; width:690; height:110;"></iframe></td></tr>
<!--<tr id="botaoconfirma" style="display: none;">
	<td colspan="2" align="center">
		<input type="Button" class="botao1" value="Cadastrar" onclick="javascript:CadastraLocais();">&nbsp;
		<input type="Button" class="botao1" value="Cancelar" onclick="javascript:location.href = 'sel_localgenerico.asp';">
	</td>
</tr>-->
</table>
</form>
<iframe name="escondido" frameborder="0" style="display:none; width:300px; height:100px;"></iframe>
<script language="JavaScript">
<%if request.querystring("local") <> "" then%>
	DadosLocal( document.formulario.local );
	document.formulario.local.value="<%=request.querystring("local")%>";
<%end if%>
</script>
<%
Call MostraFooter
%>
