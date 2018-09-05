<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!-- #include file="includes/controlesXLS.asp" -->
<%
Dim RS
Dim chr_SQL
Dim int_Cols

If RQ("exportaExcel") = "S" Then

	Set RS = Env.oConn.Execute("select * from " & RQ("tb"))

	Call CriaExcelGeral("Dados da Tabela " & RQ("tb"), RS, Null)

Else
	Call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "*", "Gerenciador de Dados", "location.href='sislab.asp'", "")
%>
<script language='javascript'>
//Exporta os dados de uma tabela para o excel
function exportaParaExcel()
{
	var f = document.forms[0];

	f.target = '_blank';
	f.exportaExcel.value = 'S';
	f.tb.value = '<%=RQ("tb")%>';
	f.target = '_blank';
	f.action = '';
	f.submit();
}
</script>

<form name='frm' target='_blank'>
<input type='hidden' name='exportaExcel' value='N'>
<input type='hidden' name='tb' value='N'>

<table border="0" width='100%' class="tabela1" cellpadding="2" cellspacing="0">
<tr>
	<td valign='top'>
		<table border="1" class="tabela1" cellpadding="2" cellspacing="0">
		<tr><th align="left" colspan="7"><b>Tabelas do SISLAB</b></th></tr>
<%
	Set RS = Env.oConn.Execute("select LOWER(name) from sysobjects where xtype = 'U' order by name")

	While Not RS.Eof
		RW "		<tr><td><a href='GerenciadorDeDados.asp?tb=" & RS(0) & "'>" & RS(0) & "</a></td></tr>" & VbCrLf

		RS.MoveNext
	WEnd
%>
		</table>
	</td>
	<td width='100%' valign='top'>
<%
	If Not VVVN(Request("tb")) Then

		Set RS = Env.oConn.Execute("select * from " & Request("tb"))

		If Not (RS.Eof And RS.Bof) Then

			RW "<table border='1' width='100%' class='tabela1' cellpadding='2' cellspacing='0' title='Clique no ícone do excel para exportar os dados'>" & VbCrLf
			RW "<tr>" & VbCrLf

			RW "<th><a href='#' onclick='javascript:exportaParaExcel();'><img src='img/excel_logo.jpg' width='24' border='0' alt='Exportar para Excel'></a></th>" & VbCrLf

			For Each Col In RS.Fields
				RW "<th>" & UCase(Col.Name) & "</th>" & VbCrLf
			Next

			RW "</tr>" & VbCrLf

			RS.MoveFirst

			While Not RS.Eof
				RW "<tr>" & VbCrLf

				RW "<td>&nbsp;</td>" & VbCrLf

				For Each Col In RS.Fields
					RW "<td>" & IIf(VVVN(Col.Value), "&nbsp;", Col.Value) & "&nbsp;</td>" & VbCrLf
				Next

				RW "</tr>" & VbCrLf

				RS.MoveNext
			WEnd

			RW "</table>" & VbCrLf
		End If

	End If
%>
	</td>
</tr>

</table>

</form>

<%
	Call ImprimeRodape(RODAPE_OFF)

End If

Set RS = Nothing
%>
