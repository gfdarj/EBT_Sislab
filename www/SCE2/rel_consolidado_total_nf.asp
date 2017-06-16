<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
'-- RELATORIO CONSOLIDADO POR TOTAL DE NOTAS FISCAIS
Dim RS
Dim ano
Dim mes
Dim conta
Dim dtt_Criacao

Tela.SetNomeTela = "SCE > Relatório > Consolidado de Total por Nota Fiscal" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Call Tela.ImprimeMenuSce()
%>
<table width="100%" class="texto1" border="0">

<%If Request("ano") <> "" Then Response.Write "<tr><td colspan='3' class='destaque'>Posição em <i>" & Request("ano") & "</i></td></tr>" End If %>

<tr><td>&nbsp;</td></tr>

<%    If request("ano") = "" Then %>
<tr>
	<td valign="top">
		<form name="formulario" method="post">
		Selecione o ano desejado:&nbsp;
		<input type="Text" class="texto1" size="5" maxlength="4" name="ano" value="<%=Year(Date)%>">&nbsp;
		<input type="Submit" class="texto1" value="Pesquisar">
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
<%  Else %>
<tr>
	<td>
<%      ano = Request("ano")

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

	    Set RS = Env.oConn.Execute(chr_SQL)

    	'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    	If RS.Eof And RS.Bof Then %>
		<center><b><i>Nenhuma informação encontrada !</i></b></center>
<%	    ElseIf RS("MES") > 12 Then %>
		<center><b><i>Nenhuma informação encontrada !</i></b><center>
<%	    Else %>
		<table align="center" cellpadding="2" cellspacing="0" class="texto1" border="1">
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
			<td align="right"><%If RS("MES") > 12 Then Response.Write "<B>"%><%If IsNull(RS("total_saida")) Then Response.Write "&nbsp" Else Response.Write FormatCurrency(RS("total_saida")) End If%></td>
		</tr>
<%	    		RS.MoveNext
		    	conta = conta + 1
    		WEnd%>
<%	    End If%>
		</table>
	</td>
</tr>
<%
    End If
%>
<tr><td>&nbsp;</td></tr>
</table>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>