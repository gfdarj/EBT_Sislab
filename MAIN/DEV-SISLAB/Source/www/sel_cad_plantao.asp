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

<form name="formulario" method="post" action="cad_plantao.asp">

<input type="hidden" name="tipocomando" value="Alterar">
<input type="hidden" name="noticias" value="">
<table width="100%" border="0" class="table-bordered">
<tr valign="middle"> 
	<td>
		<a href="cad_plantao.asp"><b>&lt;Cadastrar Nova Notícia&gt;</b></a>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr valign="top">
	<td valign="top">
		<b>Editar Notícia Cadastrada</b><br><br>
		<div style="overflow: auto; width: 100%; height=200px; border: thin solid gray;">
			<table border="1" cellpadding="2" cellspacing="0" class="table-bordered" width="100%" style="border: solid thin;">
			<tr>
				<th style="font-size: xx-small;" align="left">Notícia</th>
				<th style="font-size: xx-small;" width="100px">Data Início</th>
				<th style="font-size: xx-small;" width="100px">Data Término</th>
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
				<td align="center"><%=objRS("PLA_DATAINICIO")%>&nbsp;</td>
				<td align="center"><%=objRS("PLA_DATATERMINO")%>&nbsp;</td>
			</tr>
<%		objRS.movenext
	loop
else %>
			<tr><td align="center" colspan="3"><b><i>Não existem notícias cadastradas no momento</i></b></td></tr>
<%
end if %>
		</table>
		</div>
	</td>
</tr>
</table>
</form>
<br>
<%
Call Tela.MostraRodape()
%>