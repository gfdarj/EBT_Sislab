<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/ControlesXLS.asp"-->
<%
'-- RELATORIO CONSOLIDADO DE GERAÇAO DE DOCUMENTOS/TERMOS DE RESPOSABILIDADE
Dim chr_SQL
Dim RS
Dim ano
Dim mes
Dim conta
Dim bln_exportaExcel

bln_exportaExcel = (Request("ExportarExcel") = "S")

Tela.SetNomeTela = "SCE > Relatório > Consolidado de Documentos Gerados" : Tela.SetCaminhoRelativo = "../"

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

Set RS = Env.oConn.Execute(chr_SQL)

If request("ExportarExcel") = "S" Then

    If Env.UsuarioSCE() Then
    	Call CriaExcelGeral("Relatório Consolidado de Documentos Gerados", RS, null)
    Else
'RW "AQUI 2"
'RE
        Tela.SCE = True
        Call Tela.MostraCabecalho()
        'Call Tela.ImprimeMenuSce()
        RW Tela.Mensagem.AcessoRestritoSCE()
        Call Tela.MostraRodape()
    End If

Else
    Tela.SCE = True
    Call Tela.MostraCabecalho()
    'Call Tela.ImprimeMenuSce()

    If Env.UsuarioSCE() Then
%>
<script language='javascript'>
    function geraExcel() {
        document.forms[0].exportarExcel.value = 'S';
        document.forms[0].target = '_blank';
        document.forms[0].submit();
    }
</script>

<div class="margem-10">

<form name='frm' target='' action=''>
<input type='hidden' name='exportarExcel' value=''>

<br />

<table class="largura-total">
<tr>
	<td>
		<table class="largura-total table-condensed table-bordered table-striped table-hover">
<%    	If RS.Eof And RS.Bof Then %>
		<tr><td align='center'><b><i>Nenhuma informação encontrada !</i></b></td></tr>
<%	    Else %>
		<tr>
			<th class="texto-centralizado">Ano</th>
			<th class="texto-centralizado">Jan</th>
			<th class="texto-centralizado">Fev</th>
			<th class="texto-centralizado">Mar</th>
			<th class="texto-centralizado">Abr</th>
			<th class="texto-centralizado">Mai</th>
			<th class="texto-centralizado">Jun</th>
			<th class="texto-centralizado">Jul</th>
			<th class="texto-centralizado">Ago</th>
			<th class="texto-centralizado">Set</th>
			<th class="texto-centralizado">Out</th>
			<th class="texto-centralizado">Nov</th>
			<th class="texto-centralizado">Dez</th>
			<th class="texto-centralizado">Total</th>
		</tr>
<%		    conta = 0
		    While Not RS.Eof
%>
		<tr>
			<td class="texto-centralizado">
                <%=RS("ano")%>
			</td>
<%			    int_Total = 0
    			For mes = 1 To 12 %>
			<td class="texto-centralizado"><%=RS("Total")%></td>
<%	    			int_Total = int_Total + RS("Total")
		    		RS.MoveNext
			    Next %>
			<td class="texto-centralizado"><b><%=int_Total%></b></td>
		</tr>
<%  			conta = conta + 1
	    	WEnd %>
<%	    End If%>
		</table>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr><td class="texto-direito"><a  href='#' onclick='javascript:geraExcel();'><small>&lt;Exportar para Excel&gt;</small></a></td></tr>
</table>
</form>
</div>
<%  Else
        RW Tela.Mensagem.AcessoRestritoSCE()
    End If

    Call Tela.MostraRodape()
End If
%>
<script language='javascript'>
	document.forms[0].exportarExcel.value = '';
	document.forms[0].target = '';
</script>
