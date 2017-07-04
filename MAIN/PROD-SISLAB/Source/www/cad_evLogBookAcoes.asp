<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim objRS, oc, s

call ImprimeCabecalho2(TITULO_SITE, MENU_OFF, false, "100%", "", "", "")

oc = request("ocorrencia")
if oc = "" then oc = "0"
s = _
	"SELECT ACT_ID, TAT_DESCRICAO, ACT_DESCRICAO, ACT_EXECUTANTE, " & _
	"CONVERT(VARCHAR, ACT_PRAZO, 103) AS ACT_PRAZO, " & _
	"CONVERT(VARCHAR, ACT_DATACONCLUSAO, 103) AS ACT_DATACONCLUSAO, ACT_EFICACIA, " & _
	"CASE (SELECT COUNT(*) FROM LB_ACOESTOMADAS_ARQUIVOS lbaa WHERE lbaa.ACT_ID = lba.ACT_ID) WHEN 0 THEN 'F' ELSE 'T' END AS TEM_ARQUIVO " & _
	"FROM LB_ACOESTOMADAS lba INNER JOIN LB_TIPOACAOTOMADA lbt " & _
	"ON TAT_ID = ACT_TIPOACAO WHERE ACT_LB = " & oc
call Env.RecordSet(true, objRS, s)
%>
<table class="tabela1" width="100%" cellpadding="2" cellspacing="0" border="0" style="border-bottom: solid thin;">
<%
if objRS.Eof and objRS.Bof then
%>
<tr>
	<td colspan="1"><b><i>Nenhuma ação tomada</i></b></td>
</tr>
<%
else
%>
<tr>
	<th style="font-size: xx-small;" align="center">Ação</th>
	<th style="font-size: xx-small;" align="left">Descrição</th>
	<th style="font-size: xx-small;">Executante</th>
	<th style="font-size: xx-small;">Prazo</th>
	<th style="font-size: xx-small;">Conclusão</th>
	<th style="font-size: xx-small;">Eficácia</th>
	<th>&nbsp;</th>
<%	if Env.ehRAT then%>
	<th>&nbsp;</th>
	<th>&nbsp;</th>
<%	end if%>
</tr>
<%	while not objRS.EOF%>
<tr valign="top">
	<td><b><%=objRS("TAT_DESCRICAO")%></b>&nbsp;</td>
	<td valign="top">
<%
		If objRS("tem_arquivo") = "T" Then
			Response.Write "<img src='img/icnote.gif' title='Esta ocorrência possui arquivo(s) anexo(s)'>&nbsp;&nbsp;"
		End If
%>
		<%=objRS("ACT_DESCRICAO")%>&nbsp;
	</td>
	<td><%=objRS("ACT_EXECUTANTE")%>&nbsp;</td>
	<td align="center"><%=objRS("ACT_PRAZO")%>&nbsp;</td>
	<td align="center"><%=objRS("ACT_DATACONCLUSAO")%>&nbsp;</td>
	<td align="center"><%if objRS("ACT_EFICACIA") = "1" then response.write "Sim" else if objRS("ACT_EFICACIA") = "0" then response.write "Não" else response.write "--" %></td>
<%		if Env.ehRAT then%>
	<td class="azul1Bg" align="center"><a href="#" onclick="javascript:alterar(<%=objRS("ACT_ID")%>, 'editar');"><b>Alterar</b></a></td>
	<td class="azul1Bg" align="center"><a href="#" onclick="javascript:remover(<%=objRS("ACT_ID")%>);"><b>Remover</b></a></td>
	<td class="azul1Bg" align="center"><a href="#" onclick="javascript:alterar(<%=objRS("ACT_ID")%>, 'finalizar');"><b>Finalizar</b></a></td>
<%		else%>
	<td class="azul1Bg" align="center"><a href="#" onclick="javascript:alterar(<%=objRS("ACT_ID")%>, 'visualizar');"><b>Visualizar</b></a></td>
<%		end if%>
</tr>
<%		objRS.MoveNExt
	wend
end if
%>
<table>
<form name="form_exclui_acao" action="INSCAD_acLogBook.asp" method="post" style="display: none;" ENCTYPE="multipart/form-data">
<input type="Hidden" name="remover" value="1">
<input type="Hidden" name="idacao" value="">
<input type="Hidden" name="ocorrencia" value="<%=oc%>">
</form>
<script language="JavaScript">
	function remover(idacao) {
		document.form_exclui_acao.idacao.value = idacao;
		document.form_exclui_acao.submit();
	}
	function alterar(idacao, acao) {
		var param='';
		if(acao == 'editar') {
			param = "?acao=editar&ocorrencia=<%=oc%>&idacao=" + idacao;
		}
		else if(acao == 'visualizar') {
			param = "?acao=visualizar&ocorrencia=<%=oc%>&idacao=" + idacao;
		}
		else {
			param = "?acao=finalizar&ocorrencia=<%=oc%>&idacao=" + idacao;
		}
		janela = window.open("CAD_acLogBook.asp" + param, "cad_contato", "width=600, height=410, toolbar=no, status=yes, menubar=no, scrollbars=yes");
		janela.focus();
	}
	document.marginheight = 0;
	document.marginwidth = 0;
	document.topmargin = 0;
	document.leftmargin = 0
</script>
<%
Call imprimeRodape(RODAPE_OFF)
%>