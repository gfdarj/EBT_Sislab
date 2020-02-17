<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<%
if request("selecao") = "" then
%>
	<script type="text/javascript">
	window.close();
	</script>
<%
else
	Dim objRS, sSQL
	Dim bln_ehLogBook, AuxIdSigilo, AuxUsername

    AuxIdSigilo = 0
    AuxUsername = ""

    sSQL = "SELECT AG_SIGILO, AG_USERNAME FROM AGENDAMENTO WHERE AG_NUMERO = " & request("selecao")
	call Env.RecordSet(true, objRS, sSQL)
    If Not (objRS.Eof And objRS.Bof) Then
        AuxIdSigilo = objRS("AG_SIGILO")
        AuxUsername = objRS("AG_USERNAME")
    End If

	If request("oc") <> "" Then	'-- ocorrencia do logbook
		Call Tela.ImprimeCabecalho2("Ocorrência " & request("oc") & " - Arquivos anexos", MENU_OFF, false, "100%", "Arquivos anexados a uma ação", "NENHUM", "")
		bln_ehLogBook = True

		sSQL = "Select 'LogBook' AS TIPOARQUIVO, '" & Replace(Application("SISLAB_FolderArquivosLB"),"\","") & "/' + REPLACE(ACA_LINK, '\', '/') AS NOMEARQUIVO, ACA_LINK AS LINK From LB_ACOESTOMADAS_ARQUIVOS WHERE ACT_ID = " & Request("selecao")
	Else
		Call Tela.ImprimeCabecalho2("AS " & request("selecao") & " - Arquivos anexos", MENU_OFF, false, "100%", "Arquivos anexados ao agendamento " & request("selecao"), "NENHUM", "")
		bln_ehLogBook = False

		sSQL = "Select TAR_TipoArquivo AS TIPOARQUIVO, '" & Replace(Application("SISLAB_FolderArquivos"),"\","") & "/' + REPLACE(Arq_nomeArq, '\', '/') AS NOMEARQUIVO, Arq_Link AS LINK From vw_ArquivosTeste VW INNER JOIN Agendamento A ON VW.AG_Numero = A.Ag_Numero "
		sSQL = sSQL & " WHERE VW.AG_NUMERO=" & request("selecao")
	End If

	Call Env.RecordSet(true, objRS, sSQL)

	If Not objRS.eof then%>
<br>
<table border="1" width="100%" cellpadding="2" cellspacing="0" class="table-bordered">
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
<tr >
	<td>&nbsp;&nbsp;<b><%=objRS("TIPOARQUIVO")%>&nbsp;</b></td>
	<td>&nbsp;&nbsp;
<%          If MostraDadoSigiloso(AuxIdSigilo, AuxUsername) Then %>
		<a href="#" onclick="abreArquivo('<%=objRS("NOMEARQUIVO")%>');"><%=objRS("LINK")%></a>
<%          Else%>
        <%=Left(objRS("LINK"),5) & "***"%>
<%          End If %>
		&nbsp;
	</td>
</tr>
<%			objRS.MoveNext
		Loop%>
</table>
<p  align="center"><a href="javascript:window.close();">Fechar</a></p>
<script type="text/javascript">
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