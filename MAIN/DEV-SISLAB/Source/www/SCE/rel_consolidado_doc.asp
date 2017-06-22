<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!-- #include file="../includes/controlesXLS.asp" -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/bib_str.asp"-->
<!--#include file="includes/bib_bd.asp"-->
<%
'-- RELATORIO CONSOLIDADO DE GERAÇAO DE DOCUMENTOS/TERMOS DE RESPOSABILIDADE
Dim chr_SQL
Dim RS
Dim ano
Dim mes
Dim conta
Dim bln_exportaExcel

bln_exportaExcel = (Request("ExportarExcel") = "S")
%>
<script language='javascript'>
function geraExcel()
{
	document.forms[0].exportarExcel.value = 'S';
	document.forms[0].target = '_blank';
	document.forms[0].submit();
	//9584-8133
}
</script>

<form name='frm' target='' action=''>
<input type='hidden' name='exportarExcel' value=''>

<table width="100%" class="texto" border="0">
<%
chr_SQL = 	VbCrLf & _
	"SELECT     m.Ano, m.Mes, ISNULL(d.Total, 0) as Total" & VbCrLf & _
	"FROM		(SELECT     YEAR(DOC_DATADOCUMENTO) AS Ano, MONTH(DOC_DATADOCUMENTO) AS Mes, COUNT(*) AS Total" & VbCrLf & _
	"		FROM		SCE_Documentacao d" & VbCrLf & _
	"		GROUP BY YEAR(DOC_DATADOCUMENTO), MONTH(DOC_DATADOCUMENTO)" & VbCrLf & _
	"	) d" & VbCrLf & _
	"right JOIN" & VbCrLf & _
	"	(" & VbCrLf & _
	"		SELECT a.ano, m.mes" & VbCrLf & _
	"		FROM" & VbCrLf & _
	"		(select 1 as mes union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9 union select 10 union select 11 union select 12) m" & VbCrLf & _
	"		,(SELECT DISTINCT YEAR(DOC_DATADOCUMENTO) AS Ano FROM SCE_Documentacao) a" & VbCrLf & _
	") m ON m.mes = d.mes and m.ano = d.ano" & VbCrLf & _
	"ORDER BY m.ano, m.mes" & VbCrLf

Set RS = Conn.Execute(chr_SQL)

If request("ExportarExcel") = "S" Then

	Call CriaExcelGeral("Relatório Consolidado de Documentos Gerados", RS, null)

Else
	call ImprimeCabecalho ("", MENU_ON, true, "Relatório Consolidado de Documentos Gerados", "", "history.go(-1);")
%>
<tr>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0" class="texto" border="1">
<%
	If RS.Eof And RS.Bof Then %>
		<tr><td align='center'><b><i>Nenhuma informação encontrada !</i></b></td></tr>
<%	Else %>
		<tr style="font-weight: bold;">
			<td>Ano</td>
			<td align="center">Jan</td>
			<td align="center">Fev</td>
			<td align="center">Mar</td>
			<td align="center">Abr</td>
			<td align="center">Mai</td>
			<td align="center">Jun</td>
			<td align="center">Jul</td>
			<td align="center">Ago</td>
			<td align="center">Set</td>
			<td align="center">Out</td>
			<td align="center">Nov</td>
			<td align="center">Dez</td>
			<td align="center">Total</td>
		</tr>
<%		conta = 0
		While Not RS.Eof
%>
		<tr valign="top" <%If (conta mod 2) = 0 Then Response.Write "class='linha_par'"%>>
			<td><b><%=RS("ano")%></b></td>
<%			int_Total = 0
			For mes = 1 To 12 %>
			<td align="center"><%=RS("Total")%></td>
<%				int_Total = int_Total + RS("Total")
				RS.MoveNext
			Next %>
			<td align="center"><b><%=int_Total%></b></td>
		</tr>
<%			conta = conta + 1
		WEnd %>
<%	End If%>
		</table>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr><td align='right'><a class="texto" href='#' onclick='javascript:geraExcel();'>Exportar para Excel</a></td></tr>
</table>
</form>

<%	Call ImprimeRodape (RODAPE_OFF)
End If
%>

<script language='javascript'>
	document.forms[0].exportarExcel.value = '';
	document.forms[0].target = '';
</script>

<%
conn.close
Set RS = Nothing
Set conn = Nothing
%>