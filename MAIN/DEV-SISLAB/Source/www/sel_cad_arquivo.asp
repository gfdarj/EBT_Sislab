<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/controleshtml.asp" -->
<%
Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Arquivos do Site do CRT", "", "")
%>
<script type="text/javascript">
    function navselecao(id_arq)
    {
	    document.all.arquivos.value = id_arq;
	    document.formulario.submit();
    }
    function pesquisar()
    {
	    var frm;
	    frm = document.forms[0];
	    frm.action="sel_cad_arquivo.asp";
	    frm.submit();
    }
</script>
<%
Dim objSiteRS, cont, sSQL, AuxOrgao, linha
cont = 0

dim nomeArquivo, tipoArquivo
nomeArquivo = replace(request("txNomeArq"),"*","%")
tipoArquivo = request("sbtipoarquivo")
%>
<div class="margem-10">
    <form name="formulario" method="post" action="cad_arquivo.asp">
        <input type="hidden" name="arquivos" value="">
        <input type="hidden" name="Pesquisou" value="S">
        
        <table >
        <tr>
	        <td colspan="2">
		        <a href="cad_arquivo.asp"><b>&lt;Cadastrar Novo Arquivo&gt;</b></a>
	        </td>
        </tr>
        <tr><td>&nbsp;</td></tr>
		<tr>
			<td>Tipo Arquivo:&nbsp;</td>
			<td>
                <%  sSQL = "Select tar_codtipoarquivo as valor, tar_tipoarquivo as descricao from tipoarquivo where tar_codtipoarquivo <> " & Application("SISLAB_id_TipoArquivo_Imagem") & " order by tar_tipoarquivo asc"
			        Call comboBDSQL("sbtipoarquivo", Env.oConn, sSQL, "", "N") %>
			</td>
		</tr>
        <tr><td>&nbsp;</td></tr>
		<tr>
			<td>Arquivo:</td>
			<td><input name="txNomeArq" type="text" value="<%=nomeArquivo%>"></td>
		</tr>
        <tr><td>&nbsp;</td></tr>
        <tr valign="top"> 
			<td colspan="2"><input type="button" value="Pesquisar" class="texto1" name="btnPesq" onClick="pesquisar();"></td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        </table>

        <table class="largura-total">
        <tr valign="top">
	        <td valign="top">
<%
If (nomeArquivo <> "") Or (tipoArquivo <> "") Then
%>
		<b>Pesquisa de arquivos cadastrados</b><br><br>
		<!--<div style="overflow: auto; width: 100%; height=200px; border: thin solid gray;">-->
			<table class="table-bordered table-condensed table-striped table-hover largura-total">
			<tr>
                <th class="texto-centralizado">#</th>
				<th>Tipo do arquivo</th>
				<th>Nome</th>
				<th class="texto-centralizado">Situa&ccedil;&atilde;o</th>
				<th class="texto-centralizado">Vers&atilde;o</th>
				<th class="texto-centralizado">Ação</th>
			</tr>
<%
	sSQL = "Select *, arq_nomearq collate SQL_Latin1_General_CP1_CI_AS as arq_nomearq1 From vw_ArqRes "

	if nomeArquivo <> "" then
		sSQL = sSQL & "Where Arq_link like '" & nomeArquivo & "%'"
	end if

	if TipoArquivo <> "" and  nomeArquivo <> "" then
		sSQL = sSQL & "and Tar_CodTipoArquivo = " & tipoArquivo & ""
	elseif TipoArquivo <> "" then
		sSQL = sSQL & "Where Tar_CodTipoArquivo = " & tipoArquivo & ""
	end if

	sSQL = sSQL & " Order by Arq_CodArqTipo, ARQ_NomeArq asc;"
	call Env.RecordSet( true, objSiteRS, sSQL)
	If Not objSiteRS.EOF Then 
		objSiteRS.MoveFirst
        linha = 1
		do while not objSiteRS.EOF %>
			<tr>
                <td class="texto-centralizado"><%=linha%></td>
				<td><%=objSiteRS("TAR_TipoArquivo")%></td>
				<td><a href="arquivos/<%=objSiteRS("ARQ_NOMEARQ")%>"  target="_blank" title="Clique aqui para editar este arquivo"><%=UCase(objSiteRS("ARQ_Link"))%></a>&nbsp;</td>
				<td class="texto-centralizado"><%=objSiteRS("SAR_SitArquivo")%>&nbsp;</td>
				<td class="texto-centralizado""><%=objSiteRS("ARQ_Versao")%>&nbsp;</td>
				<td class="texto-centralizado"><a href="#" onclick="navselecao(<%=objSiteRS("ARQ_codARQ")%>);" title="Clique aqui para editar este arquivo">Editar</a></td>
			</tr>
<%			linha = linha + 1
            objSiteRS.movenext
		loop
	else %>
			<tr><td colspan="5" align="center"><b><i>Não existem arquivos cadastrados no Momento</i></b></td></tr>
<%	end if%>
		</table>
		<!--</div>-->
<%
ElseIf RQ("Pesquisou") = "S" Then
%>
        		<p align="center"><b><i>Informe um parâmetro para a pesquisa</i></b></p>
<%
End If
%>
	        </td>
        </tr>
        </table>
    </form>
    <br>
</div>

<script type="text/javascript">
    document.forms[0].sbtipoarquivo.value = '<%=tipoArquivo%>';
</script>
<%
Call Tela.MostraRodape()
%>
