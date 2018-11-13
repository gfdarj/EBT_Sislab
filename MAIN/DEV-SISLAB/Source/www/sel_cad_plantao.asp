<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<%
If IsEmpty(Env.usuarioCRT) Then response.redirect "msgAcessoNA.asp"

Dim objRS, cont, sSQL, AuxOrgao
cont=0

Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Plantão de Notícias do CRT"
Tela.SetLinkVoltar = "location.href='sislab.asp';"
Call Tela.MostraCabecalho()
'''''Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Plantão de Notícias do CRT", "location.href='sislab.asp';", "")
%>
<script type="text/javascript">
	function navselecao(noticiaID) {
		document.all.noticias.value = noticiaID;
	    document.formulario.submit();
	}
</script>

<div class="margem-10">
    <form name="formulario" method="post" action="cad_plantao.asp">
        <input type="hidden" name="tipocomando" value="Alterar">
        <input type="hidden" name="noticias" value="">

        <table class="largura-total">
        <tr valign="middle"> 
	        <td>
		        <a href="cad_plantao.asp"><b>&lt;Cadastrar Nova Notícia&gt;</b></a>
	        </td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr valign="top">
	        <td valign="top">
		        <b>Editar Notícia Cadastrada</b><br><br>
			    <table class="table-bordered table-condensed table-striped table-hover largura-total">
			    <tr>
				    <th >Notícia</th>
				    <th class="texto-centralizado">Data Início</th>
				    <th class="texto-centralizado">Data Término</th>
			    </tr>
<%
sSQL = "Select PLA_codNoticia, PLA_titNoticia, CONVERT(VARCHAR, PLA_DATAINICIO, 103) AS PLA_DATAINICIO, "
sSQL = sSQL & "CONVERT(VARCHAR, PLA_DATATERMINO, 103) AS PLA_DATATERMINO From plantao "
'sSQL = sSQL & "/* WHERE PLA_Datainicio<=getDate() AND PLA_Datatermino>=getDate() */ "
sSQL = sSQL & "ORDER BY CAST(PLA_Datainicio AS DATETIME) DESC, CAST(PLA_Datatermino AS DATETIME) DESC, PLA_titNoticia"
Call Env.RecordSet(true, objRS, sSQL)
If Not objRS.EOF Then 
	objRS.MoveFirst
	do while not objRS.EOF%>
			        <tr>
				        <td><a href="#" onclick="navselecao(<%=objRS("PLA_codNoticia")%>);" title="Clique aqui para editar esta notícia"><%=objRS( "PLA_titNoticia" )%></a>&nbsp;</td>
				        <td class="texto-centralizado"><%=objRS("PLA_DATAINICIO")%>&nbsp;</td>
				        <td class="texto-centralizado"><%=objRS("PLA_DATATERMINO")%>&nbsp;</td>
			        </tr>
<%		objRS.movenext
	loop
else %>
        			<tr><td align="center" colspan="3"><b><i>Não existem notícias cadastradas no momento</i></b></td></tr>
<%
end if %>
		        </table>
	        </td>
        </tr>
        </table>
    </form>
    <br />
</div>

<%
Call Tela.MostraRodape()
%>