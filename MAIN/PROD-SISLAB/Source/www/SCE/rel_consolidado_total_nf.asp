<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/bib_str.asp"-->
<!--#include file="includes/bib_bd.asp"-->
<%
'-- RELATORIO CONSOLIDADO POR TOTAL DE NOTAS FISCAIS
Dim RS
Dim ano
Dim mes
Dim conta
Dim dtt_Criacao

call ImprimeCabecalho ("", MENU_ON, true, "Relatório Consolidado de Total por Nota Fiscal", "", "history.go(-1);")
%>
<table width="100%" class="texto" border="0">
<tr><td class="titulo" colspan="3"><%If Request("ano") <> "" Then Response.Write "Posi&ccedil;&atilde;o em <i>" & Request("ano") & "</i>" Else Response.Write "&nbsp;"%></td></tr>
<tr><td>&nbsp;</td></tr>

<%
If request("ano") = "" Then
%>
<tr>
	<td>
		<form name="formulario" method="post">
		Selecione o ano desejado:&nbsp;
		<input type="Text" class="form" size="5" maxlength="4" name="ano" value="<%=Year(Date)%>">&nbsp;
		<input type="Submit" class="form" value="Pesquisar">
		</form>
		<script language="JavaScript">
			document.forms[0].ano.focus();
		</script>
	</td>
</tr>
<!--
<tr>
	<td>&nbsp;&nbsp;<b>(*)</b> <i>Este procedimento poderá levar algum tempo caso haja necessidade de reconstrução a tabela de consultas</i></td>
</tr>
-->
<%
Else
%>
<tr>
	<td>
<%
	ano = Request("ano")
	'Set RS = Conn.Execute("EXEC sp_SCE_REL_GERENCIAL_NF " & ano)
	'Set RS = Conn.Execute("SELECT *, CONVERT(VARCHAR, DATACRIACAO, 103) + ' ' + LEFT(CONVERT(VARCHAR, DATACRIACAO, 114), 5) AS DATAATUALIZACAO FROM SCE_Rel_Gerencial_Anual_NF_Mov WHERE ANO = " & ano & " ORDER BY ANO, CHAVE")


	'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

	Dim chr_SQL

	chr_SQL = 	VbCrLf & _
				"DECLARE @int_Ano INT" & VbCrLf & _
				"SET @int_Ano = " & Request("ano") & VbCrLf & _
				"SELECT" & VbCrLf & _
				"	e.mes, e.total_entrada, s.total_saida" & VbCrLf & _
				"FROM" & VbCrLf & _
				"(" & VbCrLf & _
				"	SELECT" & VbCrLf & _
				"		MONTH(nf.nf_dataemissao) AS MES, SUM(nf.NF_VALORTOTAL) AS total_entrada" & VbCrLf & _
				"	FROM" & VbCrLf & _
				"		sce_nota_fiscal nf" & VbCrLf & _
				"	WHERE" & VbCrLf & _
				"		nf.nf_tipo = 1 --entrada" & VbCrLf & _
				"	AND" & VbCrLf & _
				"		YEAR(nf.nf_dataemissao) = @int_Ano" & VbCrLf & _
				"	GROUP BY" & VbCrLf & _
				"		MONTH(nf.nf_dataemissao)" & VbCrLf & _
				") e LEFT JOIN " & VbCrLf & _
				"(" & VbCrLf & _
				"	SELECT" & VbCrLf & _
				"		MONTH(nf.nf_dataemissao) AS MES, SUM(nf.NF_VALORTOTAL) AS total_saida" & VbCrLf & _
				"	FROM" & VbCrLf & _
				"		sce_nota_fiscal nf" & VbCrLf & _
				"	WHERE" & VbCrLf & _
				"		nf.nf_tipo = 2 --saída" & VbCrLf & _
				"	AND" & VbCrLf & _
				"		YEAR(nf.nf_dataemissao) = @int_Ano" & VbCrLf & _
				"	GROUP BY" & VbCrLf & _
				"		MONTH(nf.nf_dataemissao)" & VbCrLf & _
				") s ON e.mes = s.mes" & VbCrLf & _
				"UNION" & VbCrLf & _
				"SELECT 13, " & VbCrLf & _
				"(" & VbCrLf & _
				"	SELECT" & VbCrLf & _
				"		SUM(nf.NF_VALORTOTAL)" & VbCrLf & _
				"	FROM" & VbCrLf & _
				"		sce_nota_fiscal nf" & VbCrLf & _
				"	WHERE" & VbCrLf & _
				"		nf.nf_tipo = 1 --entrada" & VbCrLf & _
				"	AND" & VbCrLf & _
				"		YEAR(nf.nf_dataemissao) = @int_Ano" & VbCrLf & _
				")," & VbCrLf & _
				"(" & VbCrLf & _
				"	SELECT" & VbCrLf & _
				"		SUM(nf.NF_VALORTOTAL)" & VbCrLf & _
				"	FROM" & VbCrLf & _
				"		sce_nota_fiscal nf" & VbCrLf & _
				"	WHERE" & VbCrLf & _
				"		nf.nf_tipo = 2 --saída" & VbCrLf & _
				"	AND" & VbCrLf & _
				"		YEAR(nf.nf_dataemissao) = @int_Ano" & VbCrLf & _
				")" & VbCrLf

	Set RS = Conn.Execute(chr_SQL)

	'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

	If RS.Eof And RS.Bof Then %>
		<center><b><i>Nenhuma informação encontrada !</i></b></center>
<%	ElseIf RS("MES") > 12 Then %>
		<center><b><i>Nenhuma informação encontrada !</i></b><center>
<%	Else %>
		<table align="center" cellpadding="2" cellspacing="0" class="texto" border="1">
		<tr style="font-weight: bold;">
			<td align="center">Mês</td>
			<td align="center">Total Entrada</td>
			<td align="center">Total Saída</td>
		</tr>
<%
		conta = 0
		While Not RS.Eof
%>
		<tr valign="top" <%If (conta mod 2) = 0 Then Response.Write "class='linha_par'"%>>
			<td align="left"><%If RS("MES") > 12 Then Response.Write "<B>Total</B>" Else Response.Write Nome_do_Mes(RS("MES"))%></td>
			<td align="right"><%If RS("MES") > 12 Then Response.Write "<B>"%><%If IsNull(RS("total_entrada")) Then Response.Write "&nbsp" Else Response.Write FormatCurrency(RS("total_entrada")) End If%></td>
			<td align="right"><%If RS("MES") > 12 Then Response.Write "<B>"%><%If IsNull(RS("total_entrada")) Then Response.Write "&nbsp" Else Response.Write FormatCurrency(RS("total_saida")) End If%></td>
		</tr>
<%			RS.MoveNext
			conta = conta + 1
		WEnd%>
<%	End If%>
		</table>
	</td>
</tr>
<%
End If
%>
<tr><td>&nbsp;</td></tr>
</table>
<%
conn.close
set conn=nothing

call ImprimeRodape (RODAPE_OFF)
%>