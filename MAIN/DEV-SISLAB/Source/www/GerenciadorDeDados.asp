<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!-- #include file="includes/controlesXLS.asp" -->
<%
Dim RS
Dim chr_SQL
Dim int_Cols, int_Conta

If RQ("exportaExcel") = "S" Then

	Set RS = Env.oConn.Execute("select * from " & RQ("tb"))

	Call CriaExcelGeral("Dados da Tabela " & RQ("tb"), RS, Null)

Else
	Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "100%", "Gerenciador de Dados", "location.href='sislab.asp'", "")
%>
<script type="text/javascript">
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

<div class="margem-10">
    <form name='frm' target='_blank'>
        <input type='hidden' name='exportaExcel' value='N'>
        <input type='hidden' name='tb' value='N'>

        <table style="width: 100%;">
        <tr>
	        <td style="width: 300px; vertical-align: top;">
		        <table class="table-bordered table-condensed" style="width: 100%;">
		        <tr>
                    <th align="left" colspan="7"><b>Tabelas do SISLAB</b></th>
		        </tr>
<%
	Set RS = Env.oConn.Execute("select LOWER(name) from sysobjects where xtype = 'U' order by name")

	While Not RS.Eof %>
		        <tr><td><a href="GerenciadorDeDados.asp?tb=<%=RS(0)%>"><%=RS(0)%></a></td></tr>
<%		RS.MoveNext
	WEnd %>
		        </table>
	        </td>
	        <td style="width: auto; vertical-align: top;">
<%
	If Not VVVN(Request("tb")) Then

        int_Conta = 0
		Set RS = Env.oConn.Execute("select * from " & Request("tb"))

		If Not (RS.Eof And RS.Bof) Then %>

			<table class="table-condensed table-bordered table-striped table-hover" title='Clique no ícone do excel para exportar os dados' style="width: 100%;">
			<tr>
			    <th><a href='#' onclick='javascript:exportaParaExcel();'><img src='img/excel_logo.jpg' width='24' border='0' alt='Exportar para Excel'></a></th>
<%			For Each Col In RS.Fields %>
				<th><%=UCase(Col.Name)%></th>
<%			Next %>
			</tr>

<%			RS.MoveFirst
			While Not RS.Eof %>
			<tr>
			    <td>&nbsp;</td>
<%				For Each Col In RS.Fields %>
				<td><%=IIf(VVVN(Col.Value), "&nbsp;", Col.Value)%>&nbsp;</td>
<%				Next %>
			</tr>
<%              int_Conta = int_Conta + 1
                If int_Conta Mod 100 Then Response.Flush

        		RS.MoveNext
			WEnd %>

			</table>
<%		End If
    Else %>
        <br />
<%	End If
%>
	</td>
</tr>

</table>

</form>

</div>

<%
    Call Tela.MostraRodape()
End If

Set RS = Nothing
%>
