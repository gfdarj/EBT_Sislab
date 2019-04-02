<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim auxEHRESP, auxEHGQ, auxusername,i

auxusername = Env.Usuario
%>
<script type="text/javascript">
    function navselecao(idOC)
    {
	    document.all.ocorrencia.value = idOC;
        document.formulario.submit();
    }
</script>
<%
Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Log Book"
Call Tela.MostraCabecalho()

If Env.UsuarioCRT Then

    Dim objSiteRS, cont, sSQL, AuxOrgao
    Dim objSiteRSTipoArquivo

    cont=0

    Descricao = replace(request("Descricao"),"*","")
    tipoOcorrencia = request("tipoOcorrencia")

    sSQL = "Select tar_codtipoarquivo as valor,tar_tipoarquivo as descricao from tipoarquivo order by tar_tipoarquivo asc"
    call Env.RecordSet( true, objSiteRSTipoArquivo, sSQL)
%>
<div class="margem-10">

    <form name="formulario" method="post" action="sel_cad_logbook.asp">
        <input type="hidden" name="enviei" value="SIM">
        <input type="hidden" name="ocorrencia" value="">

        <p><a href="cad_evLogBook.asp"><b>&lt;Cadastrar Nova Ocorrência&gt;</b></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="rel_logbook_filtro.ASP"><b>&lt;Consultar andamento das Ocorrências (OCs)&gt;</b></a></p>

        <p><b>Tipo de Ocorrência :</b><%call comboBDSQL( "tipoOcorrencia", objConn,"select LBTO_ID AS VALOR,lBTO_DESCRICAO AS DESCRICAO from LB_TipoOcorrencia", tipoOcorrencia, true)%></p>

        <p><b>Descrição :</b><input type="text" name="descricao" value="<%=request("descricao")%>"></p>

        <p><input type="submit" value="Pesquisar" name="btnPesq"></p>

<%
If Request("enviei") = "SIM" Then
%>
        <br />
        <h4>Ocorrências encontradas</h4>

	    <table class="table-bordered table-striped table-hover table-condensed" style="width: 100%;">
	    <tr>
		    <th style="text-align: center; width: 60px;">Nº OC</th>
		    <th>Descrição</th>
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
	    <tr style="vertical-align: top;">
		    <td style="text-align: center;">
                <a href="#" onclick="navselecao(<%=objSiteRS("LB_ID")%>);" title="Clique aqui para editar esta ocorrência"><b><%=objSiteRS("LB_ID")%></b></a>
		    </td>
		    <td>
<%			If objSiteRS("QTD_ARQUIVOS") = 1 Then%>
    		    <img align="absmiddle" src="img/icnote.gif" border="0" title="Esta ocorrência possui arquivo anexo">
<%			ElseIf objSiteRS("QTD_ARQUIVOS") > 1 Then%>
	    		<img align="absmiddle" src="img/icnote.gif" border="0" title="Esta ocorrência possui arquivos anexos">
<%			End If%>
		    	<%=objSiteRS("LB_Descricao")%>&nbsp;
		    </td>
	    </tr>
<%			objSiteRS.MoveNext
		Loop
	Else %>
	    <tr>
		    <td colspan="2" align='center'><b><i>Não Existem Ocorrências Cadastradas No Momento</i></b></td>
	    </tr><%
	end if

	objSiteRS.Close
	Set objSiteRS = Nothing
%>
		</table>
        <br />
<%
End If %>
    </form>
</div>

<%
Else
    Response.Write "<br />" & Env.MensagemAcessoExclusivo()
End If %>

<%
Call Tela.MostraRodape()
%>