<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->
<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"

Dim objRS, objConn, s, tipo, cont

tipo = request.querystring("tipo")
if tipo = "" then tipo = -1
%>
<html>
<head>
	<title>Site do Centro de Referência Tecnológica</title>
	<meta http-equiv="Pragma" content="no-cache">
	<link rel="stylesheet" href="includes/style.css">
</head>
<script language="JavaScript" src="includes/qtd_caract.js"></script>
<script language="JavaScript">
//----- ORDENACAO DOS VETORES
//var vcarac_outras = new Array(), vcarac_comp = new Array();
var vcarac_outras[][], vcarac_comp[][];
<%
s = "select c.CAR_ID, c.CAR_NOME, c.CAR_DEFINICAO from FAC_Caracteristicas c "
s = s & "where c.CAR_ID not in (select t.CAR_ID from FAC_Rel_Caracteristicas_Tipo t "
s = s & "where t.TPC_ID = " & tipo & ") order by c.CAR_NOME"
call Env.RecordSet(true, objRS, s)
cont = 0
while not objRS.EOF	%>
vcarac_outras[<%=cont%>][0] = new Option("<%=objRS("CAR_NOME")%>", <%=objRS("CAR_ID")%>);
vcarac_outras[<%=cont%>][1] = "<%=objRS("CAR_DEFINICAO")%>";<%
	cont = cont + 1
	objRS.MoveNext
wend
call Env.RecordSet(false, objRS, s)

s = "select c.CAR_ID, c.CAR_NOME, c.CAR_DEFINICAO, t.RCT_QUANTIDADE from FAC_Caracteristicas c inner join "
s = s & "FAC_Rel_Caracteristicas_Tipo t on t.CAR_ID = c.CAR_ID "
s = s & "where t.TPC_ID = " & tipo & " order by c.CAR_NOME"
call Env.RecordSet(true, objRS, s)
cont = 0
while not objRS.EOF	%>
vcarac_comp[<%=cont%>][0] = new Option("<%=objRS("CAR_NOME") & " (" & objRS("RCT_QUANTIDADE") & ")"%>", <%=objRS("CAR_ID")%>);
vcarac_comp[<%=cont%>][1] = "<%=objRS("CAR_DEFINICAO")%>";<%
	cont = cont + 1
	objRS.MoveNext
wend
call Env.RecordSet(false, objRS, s)
%>

function compara(a, b){
	var tmp1 = a.text.toUpperCase();
	var tmp2 = b.text.toUpperCase();

	return (tmp1 < tmp2)?(-1):( (tmp1 > tmp2)?(1):(0) );
}

function sincroniza( select, vetor ){
	var i;

	vetor.sort(compara);
	select.length = vetor.length;
	for(i=0; i < vetor.length; i++)
		select[i] = vetor[i];
}

function adiciona( select1, vetor1, select2, vetor2 ){
	var i, qtd;

	for(i=0; i < select1.length; i++)
		if(select1[i].selected)
		{
			if ( select1.name == "carac_outras" )	{
				qtd = window.prompt("Entre com a quantidade da característica \"" + select1[i].text + "\"", "0");
				if( !isNaN( qtd ) && (qtd > 0) )
				{
					select1[i].selected = false;
					vetor2[vetor2.length++] = vetor1[i];
					vetor2[vetor2.length-1][0].text += " (" + qtd + ")";
					vetor1.splice(i, 1);
					select1[i--] = null;
				}
				else	{
					alert( "Quantidade informada é inválida" );
					return false;
				}
			}
			else	{
				select1[i].selected = false;
				vetor2[vetor2.length++] = vetor1[i];
				vetor2[vetor2.length-1][0].text = ExtraiTexto( vetor2[vetor2.length-1][0].text );
				vetor1.splice(i, 1);
				select1[i--] = null;
			}
		}
	sincroniza( select2, vetor2 );
}
function ad_novo(texto, valor, definicao){
	vcarac_outras[vcarac_outras.length][0] = new Option(texto, valor);
	vcarac_outras[vcarac_outras.length][1] = definicao;
	vcarac_outras[vcarac_outras.length-1].selected = true;
	sincroniza(document.formulario.carac_outras, vcarac_outras);
}
//----- FIM DA ORDENACAO DO VETOR
function MostraDef(mostra, oque) {
	var f = document.all;
//	if(mostra) {
//		f.id_definicao.style.display = "block";
//		if( oque == "OUTRAS" ) {
//		}
//	}
//	else {
//		f.id_definicao.style.display = "none";
//	}
}
</script>

<style>
div {
	background-color : #DBE7FB;
	cursor : hand;
	font-family : Verdana, Arial;
	font-size : 10px;
	top: 10px;
	left: 10px;
	width: 400px;
	height: 200px;
	position: absolute;
	filter: alpha(opacity=100);
}
</style>

<body topmargin=0 leftmargin=0 scroll="no" onload="javascript: sincroniza(document.formulario.carac_outras, vcarac_outras); sincroniza(document.formulario.carac_comp, vcarac_comp);">

<div id="id_definicao">
<table width="100%">
<tr><td bgcolor="#808080" align="right"><a href="#">X</a></td></tr>
<tr><td>TEste....</td></tr>
</table>
</div>

<form name="formulario" method="post">
<table width="100%" height="100%" class="trCadtit1" border="1">
<tr valign="top">
	<td width="150"><font class="Fonttit3Cad"><b>Outras Caracter&iacute;sticas:</b></font><br><select multiple name="carac_outras" style="width: 150px;" ondblclick="javascript:adiciona(document.formulario.carac_outras, vcarac_outras, document.formulario.carac_comp, vcarac_comp);" size="10" class="combo"></select></td>
	<td width="40" valign="middle" align="center"><input type="Button" class="botao0" onclick="javascript:adiciona(document.formulario.carac_outras, vcarac_outras, document.formulario.carac_comp, vcarac_comp);" value=">>"> <br/> <input type="Button" class="botao0" onclick="javascript:adiciona(document.formulario.carac_comp, vcarac_comp, document.formulario.carac_outras, vcarac_outras);" value="<<"></td>
	<td width="230"><font class="Fonttit3Cad"><b>Caracter&iacute;stica do componente (Qtde):</b></font><br><select multiple name="carac_comp" style="width: 150px;" ondblclick="javascript:adiciona(document.formulario.carac_comp, vcarac_comp, document.formulario.carac_outras, vcarac_outras);" size="10" class="combo"></select></td>
	<td valign="middle" align="left"><input type="button" value="Nova Caracteristica" class="botao3" onclick="javascript:window.open('novacaracteristica.asp?tipo=<%=tipo%>', 'CARACTERISTICA', 'width=460, height=200, toolbar=no, status=no, menubar=no, scrollbars=no');"></td>
	<td id="cel_definicao">definicoes...&nbsp;</td>
</tr>
</table>
</form>
</body>
</html>