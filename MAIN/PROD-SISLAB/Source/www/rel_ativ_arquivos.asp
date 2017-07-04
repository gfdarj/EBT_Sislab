<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<%
if request("selecao") = "" then
%>
	<script language="JavaScript">
	window.close();
	</script>
<%
else
	Dim objRS, sSQL
	Dim bln_ehLogBook

	If request("oc") <> "" Then	'-- ocorrencia do logbook
		call ImprimeCabecalho2("Ocorrência " & request("oc") & " - Arquivos anexos", MENU_OFF, false, "100%", "Arquivos anexados a uma ação", "NENHUM", "")
		bln_ehLogBook = True

		sSQL = "Select 'LogBook' AS TIPOARQUIVO, '" & Replace(Application("SISLAB_FolderArquivosLB"),"\","") & "/' + REPLACE(ACA_LINK, '\', '/') AS NOMEARQUIVO, ACA_LINK AS LINK From LB_ACOESTOMADAS_ARQUIVOS WHERE ACT_ID = " & Request("selecao")
	Else
		call ImprimeCabecalho2("AS " & request("selecao") & " - Arquivos anexos", MENU_OFF, false, "100%", "Arquivos anexados ao agendamento " & request("selecao"), "NENHUM", "")
		bln_ehLogBook = False

		sSQL = "Select TAR_TipoArquivo AS TIPOARQUIVO, '" & Replace(Application("SISLAB_FolderArquivos"),"\","") & "/' + REPLACE(Arq_nomeArq, '\', '/') AS NOMEARQUIVO, Arq_Link AS LINK From vw_ArquivosTeste VW INNER JOIN Agendamento A ON VW.AG_Numero = A.Ag_Numero "
		sSQL = sSQL & " WHERE VW.AG_NUMERO=" & request("selecao")
	End If

	call Env.RecordSet(true, objRS, sSQL)
	if Not objRS.eof then%>
<br>
<table border="1" width="100%" cellpadding="2" cellspacing="0" class="tabela1">
<tr>
	<td width="30%"></td>
	<td width="70%"></td>
</tr>
<tr class="realce1">
	<td align="center">Tipo de Arquivo</td>
	<td align="center">Arquivo</td>
</tr>
<%		objRS.MoveFirst
		Do while Not objRS.eof%>
<tr class="texto1">
	<td>&nbsp;&nbsp;<b><%=objRS("TIPOARQUIVO")%>&nbsp;</b></td>
	<td>&nbsp;&nbsp;
		<a href="#" onclick="abreArquivo('<%=objRS("NOMEARQUIVO")%>');"><%=objRS("LINK")%></a>
		&nbsp;
	</td>
</tr>
<%			objRS.MoveNext
		Loop%>
</table>
<p class="texto1" align="center"><a href="javascript:window.close();">Fechar</a></p>
<script language="JavaScript">
function abreArquivo(nome){
	var janela;
	janela = window.open(nome, '', 'width=550,toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no');
	janela.focus();
}
</script>
<%
	end if

	call imprimeRodape2(RODAPE_OFF, "")
end if
%>