<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim objRS, s, plataforma

if not Env.ehRAT then RESPONSE.REDIRECT "INDEX.ASP"

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Histórico de Equipamentos em Plataformas", "location.href='sislab.asp'", "")

plataforma = request("plataforma")
if plataforma = "" then plataforma = "0"
%>
<form method="post" action="CadPlataformaEquipamentoHist.asp" name="frm">
<input type="hidden" name="hpe_id" value="">
<input type="hidden" name="idplataforma" value="<%=plataforma%>">
<table border="0" width="100%" cellpadding="2" cellspacing="0" class="table-bordered">
<tr><td>&nbsp;</td></tr>

<tr><th align="left">&nbsp;Selecione a Plataforma</td></tr>

<tr>
	<td>&nbsp;<b>Plataforma:</b> &nbsp;
		<%call comboServicosPlataformas("plataforma", Env.oConn, "N", "P")%>
		<script language="JavaScript">
			frm.plataforma.onchange = BuscarPlataformas;
			frm.plataforma.value = '<%=plataforma%>';
			function BuscarPlataformas() {
				frm.action = 'CadPlataformaEquipamentoHist.asp';
				frm.submit();
			}
		</script>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr><th align="left">&nbsp;Equipamentos da Plataforma</th></tr>

<tr>
	<td>
<%
s =	"SELECT f.EQ_CODIGOBARRAS, f.MOD_CODNOME, f.MOD_DESCRICAO " & _
	"FROM vw_SCE_Equipamentos_Fabricantes f INNER JOIN Plataforma_Equipamentos pe " & _
	"ON f.EQ_ID = pe.EQ_ID " & _
	"WHERE pe.S_ID = " & plataforma & " " & _
	"ORDER BY MOD_DESCRICAO, EQ_CODIGOBARRAS"
call Env.RecordSet(true, objRS, s)
if not objRS.Eof then%>
		<table class="table-bordered" width="100%">
		<tr>
			<td width="200px"><b>Cód.Barras</b></td><td><b>Modelo</b></td><td><b>Descrição</b></td>
		</tr>
<%		while not objRS.Eof%>
		<tr><td><%=objRS("EQ_CODIGOBARRAS")%></td><td><%=objRS("MOD_CODNOME")%></td><td><%=objRS("MOD_DESCRICAO")%></td></tr>
<%		objRS.MoveNext
	wend%>
		</table>
<%
else%>
		<table class="table-bordered" width="100%">
		<tr><td><b>Nenhum equipamento cadastrado neste momento</b></td></tr>
		</table>
<%
end if
call Env.RecordSet(false, objRS, null)
%>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr><th align="left">&nbsp;Histórico das mudanças na Plataforma</th></tr>

<tr>
	<td>
<%
s =	"SELECT HPE_ID, f.EQ_CODIGOBARRAS, f.MOD_CODNOME, f.MOD_DESCRICAO, " & _
	"CONVERT(VARCHAR, pe.HPE_DATAALTERACAO, 103) + ' ' + LEFT(CONVERT(VARCHAR, pe.HPE_DATAALTERACAO, 114), 5) AS HPE_DATAALTERACAO, " & _
	"CASE WHEN pe.HPE_TIPOMOVIMENTO = 'E' THEN 'Entrada' ELSE 'Saída' END AS HPE_TIPOMOVIMENTO " & _
	"FROM vw_SCE_Equipamentos_Fabricantes f INNER JOIN Historico_Plataforma_Equipamentos pe " & _
	"ON f.EQ_ID = pe.EQ_ID " & _
	"WHERE pe.S_ID = " & plataforma & " " & _
	"ORDER BY pe.HPE_DATAALTERACAO, f.EQ_CODIGOBARRAS, pe.HPE_TIPOMOVIMENTO"
call Env.RecordSet(true, objRS, s)
if not objRS.Eof then%>
		<table class="table-bordered" width="100%">
		<tr>
<%		if Env.ehRAT Then %>
			<td align="center">&nbsp;</td>
<%		End If %>
			<td width="200px"><b>Cód.Barras</b></td>
			<td><b>Modelo</b></td>
			<td><b>Descrição</b></td>
			<td><b>Data Mov.</b></td>
			<td align="center"><b>Movimento</b></td>
		</tr>
<%		while not objRS.Eof%>
		<tr>
<%			if Env.ehRAT Then %>
			<td align="center"><a onclick="javascript:ExcluirItem(<%=objRS("HPE_ID")%>)" href="#" title="Clique aqui para excluir o item <%=objRS("EQ_CODIGOBARRAS")%> do histórico"><img src="img/btn_excluir.gif" border="0"></a></td>
<%			End If %>
			<td><%=objRS("EQ_CODIGOBARRAS")%></td>
			<td><%=objRS("MOD_CODNOME")%></td>
			<td><%=objRS("MOD_DESCRICAO")%></td>
			<td><%=objRS("HPE_DATAALTERACAO")%></td>
			<td align="center"><%=objRS("HPE_TIPOMOVIMENTO")%></td>
		</tr>
<%		objRS.MoveNext
	wend%>
		</table>
<%
end if
call Env.RecordSet(false, objRS, null)
%>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr><td><input type="button" value=" Voltar " onclick="history.go(-1);"></td></tr>

</table>
</form>
<script language="JavaScript">
	var frm = document.forms[0];


	function ExcluirItem(hist)
	{
		frm.hpe_id.value = hist;
		frm.action = 'CadPlataformaEquipamentoHistExc.asp';
		frm.submit();
	}
</script>
<%
Call Tela.MostraRodape()
%>
