<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/funcoes.asp" -->
<% 
Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Sistema de Gestão de Facilidades", "location.href='../sislab.asp'", "../")
%>
<br />
<div class="container">
    <table width="500" class="tabela" border="1" align="center">
    <tr>
	    <th colspan="2" class="azul1Bg destaque">
		    <b>&nbsp;&nbsp;&nbsp;Selecione a opção desejada</b>
	    </th>
    </tr>
    <tr>
	    <td align="center">
		    <br>
		    <p><input type="button" value="Cadastrar Componente (Elemento)" class="botaoMenu" onclick="javascript:location.href='componentes.asp';"></p>
		    <p><input type="button" value="Editar Componente (Elemento)" class="botaoMenu" onclick="javascript:location.href='lista_compos.asp';"></p>
		    <p><input type="button" value="Consultar Componente (Elemento)" class="botaoMenu" onclick="javascript:location.href='lista_componentes.asp';"></p>
		    <p><input type="button" value="Cadastrar/Editar Tipo de Componente (Modelo)" class="botaoMenu" onclick="javascript:location.href='sel_tipocomponentes.asp';"></p>
		    <p><input type="button" value="Locais Genéricos" class="botaoMenu" onclick="javascript:location.href='sel_localgenerico.asp';"></p>
		    <p><input type="button" value="Circuitos" class="botaoMenu" onclick="javascript:location.href='circuitos.asp';"></p>
		    <br>
	    </td>
    </tr>
    </table>
</div>
<%
Call Tela.MostraRodape()
%>
