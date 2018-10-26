<!--#include file="includes/Sislab_Lib.asp"-->
<!--#INCLUDE FILE="includes/PadraoHTML.asp" -->
<!--#INCLUDE FILE="includes/global.asp" -->
<%
call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Localização / Área", "", "")
%>
<script language="JavaScript">
function AbreJanela(str, nomejan)
{
	var w = window.open(str, nomejan, "toolbar=1,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=640,height=480,top=10,left=10");
	w.focus();
}
</script>
<table class="table-bordered" border="0" width="100%" cellpadding="3" cellspacing="0">
<tr>
	<td>
	<p align="justify">O Centro de Refer&ecirc;ncia Tecnol&oacute;gica ocupa uma &aacute;rea de 1200m<sup>2</sup> no Parque Tecnol&oacute;gico da Ilha do Fund&atilde;o, onde foram construídos os prédios do Laboratório e o de apoio.</p>
	<p align="center">
		<b>Mapa de Localização / Acesso ao CRT:</b><br>
		<i>(Clique no mapa para ampliá-lo)</i><br><br>
		<!--<img src="img/mapaufrj.jpg" width=550>-->
		<a href="#" onclick="javascript:AbreJanela('img/mapa_fundao.gif', 'mapaufrj');"><img src="img/mapa_fundao.gif" width=650 border="0"></a>
	</p>

	<br>

	<p align="center">
		<b>A seguir vemos a planta baixa do pr&eacute;dio do Laborat&oacute;rio:</b><br>
		<i>(Clique no mapa para ampliá-lo)</i><br><br>
		<!--<img width="400" src="img/labp2.jpg">-->
		<a href="#" onclick="javascript:AbreJanela('img/labp2.jpg', 'mapaplantabaixa');"><img src="img/labp2.jpg" width=650 border="0"></a>
	</p>

	<br>

	<p align="center">
		<b>A seguir vemos a planta baixa do pr&eacute;dio de apoio:</b><br>
		<i>(Clique no mapa para ampliá-lo)</i><br><br>
		<!--<img width="400" src="img/labp1.jpg">-->
		<a href="#" onclick="javascript:AbreJanela('img/labp1.jpg', 'mapaplantabaixa1');"><img src="img/labp1.jpg" width=650 border="0"></a>
	</p>
	</td>
</tr>
</table>
<br>
<%
Call imprimeRodape(RODAPE_ON)
%>
