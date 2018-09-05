<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
Dim EH_CRT, EH_RAT
Dim sSql, iPagina, RS
Dim registroporpagina

EH_CRT = Env.UsuarioCRT()
EH_RAT = Env.EhRat()

If Not EH_RAT Then
	RR "index.asp"
	RE
End If

registroporpagina = IIf(VVVNZ(RQ("registroporpagina")), 10, RQ("registroporpagina"))

If VVVN(RQ("ssql")) then	'-- foi submetido por este mesmo form
	sSql = RQ("ssql2")
	iPagina = RQ("pagina")
Else	'-- veio do form Rel_Ativ_A.asp
	ssql = RQ("ssql")
	iPagina = 1
End If

'RW "<br><br>1 !!!" & sSql
'RW "<br><br>2 !!!" & RQ("ssql2")
'RW "<br><br>3 !!!" & RQ("pagina")
'RW "<br><br>4 !!!" & RQ("ssql")
'RE

Call Env.RecordSet(True, RS, sSQL)

total_registros = RS.RecordCount

call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Relatório para Inventário de Equipamentos", "location.href='rel_inv_equip.asp'", "")
%>
<script language="javascript" src="includes/manipulaObj.js"></script>
<script language="javascript">
function proximaPagina()
{
	var frm = document.forms[0];
	frm.pagina.value = <%=iPagina+1%>;
	frm.submit();
}
function VaiPagina(pagina)
{
	var frm = document.forms[0];
	frm.pagina.value = pagina;
	frm.submit();
}

function paginaAnterior()
{
	var frm = document.forms[0];
	frm.pagina.value = <%=iPagina-1%>;
	frm.submit();
}
</script>
<form action="rel_inv_equip_B.asp" method="post">
<input type="Hidden" name="total_registros" value="<%=total_registros%>">
<input type=hidden name="pagina">
<input type="Hidden" name="ssql2" value="<%=ssql%>">
<input type="Hidden" name="registroporpagina" value="<%=registroporpagina%>">
<br>
<%
If Not(RS.EOF) Then

	if VVVNZ(RQ("Pagina")) then contpagina = 1 else contpagina = CInt(RQ("Pagina"))
	RS.AbsolutePage = contpagina
	RS.PageSize = registroporpagina
%>
<table width="100%" border="0" cellspacing="2" cellpadding="0" class="tabela1" style="background: #E8E8E8;">
<tr>
	<td align="left" width="150px">
		<%if contpagina > 1 then%>
			<a href="javascript:paginaAnterior()" class="menu"><span class="cinza1">&laquo;</span> Voltar</a>
		<%end if%>
	</td>
	<td align="center">
		<B>&nbsp;&nbsp;Página atual: <%=contpagina%></B>&nbsp;&nbsp;&nbsp;&nbsp;
		<B>&nbsp;&nbsp;Total de Registros: <%=total_registros%></B>&nbsp;&nbsp;&nbsp;&nbsp;
	</td>
	<td align="right" width="150px">
		<%if Not RS.Eof then%>
			<a href="javascript:proximaPagina()" class="menu">Avançar <span class="cinza1">&raquo;</span></a>
		<%end if%>
	</td>
</tr>
</table>

<table border="1" width="100%" cellpadding="2" cellspacing="0" class="tabela1" style="border: solid thin;">
<tr>
	<th width="35px" style="font-size: xx-small;">Cód Barras</th>
	<th style="font-size: xx-small;">Localização</th>
	<th style="font-size: xx-small;">Num. Série</th>
	<th style="font-size: xx-small;">Propriedade</th>
	<th style="font-size: xx-small;">Status</th>
	<th style="font-size: xx-small;">Modelo</th>
	<th style="font-size: xx-small;">Descrição</th>
	<th style="font-size: xx-small;">Fabricante</th>
	<th style="font-size: xx-small;">Nota Fiscal</th>
	<th style="font-size: xx-small;">Emissão</th>
	<th style="font-size: xx-small;">N.OP</th>
	<th style="font-size: xx-small;">Último Movimento</th>
	<th style="font-size: xx-small;">Qtd. Mov.</th>
</tr>
<%
	while (intrec < RS.PageSize and not RS.EOF)
		intrec = intrec + 1
%>
<tr valign="middle">
	<td align="left" valign="middle"><%=IIf(VVVNZ(RS("CODIGOBARRAS")), "&nbsp;", RS("CODIGOBARRAS"))%></td>
	<td align="left" valign="middle"><%=IIf(VVVNZ(RS("LOCALIZACAO")), "&nbsp;", RS("LOCALIZACAO"))%></td>
	<td align="left" valign="middle"><%=IIf(VVVNZ(RS("NUMEROSERIE")), "&nbsp;", RS("NUMEROSERIE"))%></td>
	<td align="left" valign="middle"><%=IIf(VVVNZ(RS("PROPRIEDADE")), "&nbsp;", RS("PROPRIEDADE"))%></td>
	<td align="left" valign="middle"><%=IIf(VVVNZ(RS("STATUS")), "&nbsp;", RS("STATUS"))%></td>
	<td align="left" valign="middle"><%=IIf(VVVNZ(RS("MODELO")), "&nbsp;", RS("MODELO"))%></td>
	<td align="left" valign="middle"><%=IIf(VVVNZ(RS("DESCRICAO")), "&nbsp;", RS("DESCRICAO"))%></td>
	<td align="left" valign="middle"><%=IIf(VVVNZ(RS("FABRICANTE")), "&nbsp;", RS("FABRICANTE"))%></td>
	<td align="right" valign="middle"><%=IIf(VVVNZ(RS("NOTAFISCAL")), "&nbsp;", RS("NOTAFISCAL"))%></td>
	<td align="left" valign="middle"><%=IIf(VVVNZ(RS("DATAEMISSAO")), "&nbsp;", RS("DATAEMISSAO"))%></td>
	<td align="left" valign="middle"><%=IIf(VVVNZ(RS("NATUREZAOP")), "&nbsp;", RS("NATUREZAOP"))%></td>
	<td align="left" valign="middle"><%=IIf(VVVNZ(RS("MOVIMENTACAO")), "&nbsp;", RS("MOVIMENTACAO"))%></td>
	<td align="right" valign="middle"><%=IIf(VVVNZ(RS("QTDMOVIMENTOS")), "&nbsp;", RS("QTDMOVIMENTOS"))%></td>
</tr>
<%		RS.MoveNext
	wend
%>
</table>
<script language="JavaScript">
	var frm = document.forms[0]
	frm.pagina.value = <%=contpagina%>
</script>

<table width="100%" border="0" cellspacing="2" cellpadding="0" class="tabela1" style="background: #E8E8E8;">
<tr>
	<td align="left" width="150px">
		<%if contpagina > 1 then%>
			<a href="javascript:paginaAnterior()" class="menu"><span class="cinza1">&laquo;</span> Voltar</a>
		<%end if%>
	</td>
	<td align="center">
		<B>&nbsp;&nbsp;Página atual: <%=contpagina%></B>&nbsp;&nbsp;&nbsp;&nbsp;
		<B>&nbsp;&nbsp;Total de Registros: <%=total_registros%></B>&nbsp;&nbsp;&nbsp;&nbsp;
	</td>
	<td align="right" width="150px">
		<%if Not RS.Eof then%>
			<a href="javascript:proximaPagina()" class="menu">Avançar <span class="cinza1">&raquo;</span></a>
		<%end if%>
	</td>
</tr>
<%
else
%>
<tr>
	<td colspan="8" align="center"><b><i>Nenhum equipamento encontrado.</i></b></td>
</tr>
<%
end if
%>
</table>
</form>
<%
Call imprimeRodape(RODAPE_OFF)
%>
