<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim auxEHRESP, auxEHGQ, auxusername,i

auxusername = Env.Usuario
%>
<script language=javascript>
function navselecao(idOC)
{
	document.all.ocorrencia.value = idOC;
    document.formulario.submit();
}
function pesquisar()
{
	var frm;
	frm = document.forms[0];
	frm.action="sel_cad_logbook.asp";
	frm.submit();
}
</script>
<%
call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Log Book", "", "")

Dim objSiteRS, cont, sSQL, AuxOrgao
Dim objSiteRSTipoArquivo

cont=0

Descricao = replace(request("Descricao"),"*","")
tipoOcorrencia = request("tipoOcorrencia")

sSQL = "Select tar_codtipoarquivo as valor,tar_tipoarquivo as descricao from tipoarquivo order by tar_tipoarquivo asc"
call Env.RecordSet( true, objSiteRSTipoArquivo, sSQL)
%>
<form name="formulario" method="post" action="cad_evLogBook.asp">
<input type="Hidden" name="enviei" value="SIM">
<input type="Hidden" name="ocorrencia" value="">
<table width="100%" class="tabela1">
<tr>
	<td height="40">
		<a href="cad_evLogBook.asp"><b>&lt;Cadastrar Nova Ocorrência&gt;</b></a>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="REL_LOGBOOK_FILTRO.ASP"><b>&lt;Consultar andamento das Ocorrências (OCs)&gt;</b></a>
	</td>
</tr>
<tr>
	<td>
		<table class="tabela1">
		<tr>
			<td><b>Tipo de Ocorrência :</b>
			<td><%call comboBDSQL( "tipoOcorrencia", objConn,"select LBTO_ID AS VALOR,lBTO_DESCRICAO AS DESCRICAO from LB_TipoOcorrencia", tipoOcorrencia, true)%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td><b>Descrição :</b></td>
			<td><input name="descricao" type="Text" value="<%=request("descricao")%>"></td>
			<td><input type="button" class="texto1" value="Pesquisar" name="btnPesq" onClick="pesquisar();"></td>
		</tr>
		</table>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr valign="top">
	<td valign="top">
<%
If Request("enviei") = "SIM" Then
%>
		<b>Pesquisa de Ocorrências</b><br><br>
			<table border="1" cellpadding="2" cellspacing="0" class="tabela1" width="100%" style="border: solid thin;">
			<tr>
				<th style="font-size: xx-small;" align="left">Nº OC</th>
				<th style="font-size: xx-small;" align="left">Descrição</th>
			</tr>
<%
	sSQL = "Select *, (SELECT COUNT(A.LB_ID) FROM LB_ACOESTOMADAS_ARQUIVOS A WHERE A.LB_ID = LB.LB_ID) QTD_ARQUIVOS From lb_logbook lb "
	if Descricao <> "" then
		sSQL = sSQL & "Where lb.lb_descricao like '%" & Descricao & "%'"
	end if
	if tipoOcorrencia <> "" and  Descricao <> "" then
		sSQL = sSQL & "and lb.lbto_ID = " & tipoOcorrencia & ""
	elseif tipoOcorrencia <> "" then
		sSQL = sSQL & "Where lb.lbto_ID = " & tipoOcorrencia & ""
	end if
	sSQL = sSQL & " Order by lb.LB_ID desc;"
	call Env.RecordSet( true, objSiteRS, sSQL )

	If Not objSiteRS.EOF Then
		do while not objSiteRS.EOF%>
			<tr valign="top">
				<td width="35px"><a href="#" onclick="navselecao(<%=objSiteRS("LB_ID")%>);" title="Clique aqui para editar esta ocorrência"><b><%=objSiteRS("LB_ID")%></b></a></td>
				<td>
<%			If objSiteRS("QTD_ARQUIVOS") = 1 Then%>
					<img align="absmiddle" src="img/icnote.gif" border="0" title="Esta ocorrência possui arquivo anexo">
<%			ElseIf objSiteRS("QTD_ARQUIVOS") > 1 Then%>
					<img align="absmiddle" src="img/icnote.gif" border="0" title="Esta ocorrência possui arquivos anexos">
<%			End If%>
					<a href="#" onclick="navselecao(<%=objSiteRS("LB_ID")%>);" title="Clique aqui para editar esta ocorrência"><%=objSiteRS("LB_Descricao")%>&nbsp;
				</td>
			</tr>
<%			objSiteRS.MoveNext
		loop
	else
%>
			<tr>
				<td colspan="2" align='center'><b><i>Não Existem Ocorrências Cadastradas No Momento</i></b></td>
			</tr><%
	end if

	objSiteRS.Close
	Set objSiteRS = Nothing
	%>
			</table>
</form>
<%
End If

Call imprimeRodape(RODAPE_OFF)
%>