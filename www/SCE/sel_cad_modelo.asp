<!--#include file="includes/controlesHTML_SCE.asp" -->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#INCLUDE FILE="includes/abre.asp" -->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Consulta de Modelos", "", "history.go(-1);")
%>
<form name="formulario" method="post" action="busca_modelo.asp">
<table>
<tr>
	<td>
	<table width="100%">
		<tr valign="top">
			<td class="titulo">Editar / Excluir Modelo Cadastrado:
			<div class="texto"><%if request("msg") <> "" then
				if cint(request("msg")) =1 then response.write "<br>Modelo atualizado com sucesso!<br><br>"
				if cint(request("msg")) =2 then response.write "<br>Modelo excluído com sucesso!<br><br>"
			end if%></div>
			</td>
		</tr>
		<tr><td class="texto">&nbsp;</td></tr>
		<tr class="texto">
			<td>
				Busque por Modelo:&nbsp;<input type="text" name="modelo" class="form">
			</td>
		</tr>
		<tr><td class="texto">&nbsp;</td></tr>
		<tr class="texto">
			<td>
				Busque por Part Number:&nbsp;<input type=text name="partnumber" class="form">
			</td>
		</tr>
		<tr><td class="texto">&nbsp;</td></tr>
		<tr class="texto">
			<td>
			Busque por Fabricante:&nbsp;
			<%call comboBDSQL( "fab_id", conn, "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "N")%>
			</td>
		</tr>
		<tr><td class="texto">&nbsp;</td></tr>
		<tr class="texto">
			<td>
			Busque por Descri&ccedil;&atilde;o:&nbsp;<input type="text" name="descricao" class="form" size="50">
			</td>
		</tr>
		<tr><td class="texto">&nbsp;</td></tr>
		<tr><td align="center"></td></tr>
	</table>
	</td>
	<td width="50px">&nbsp;</td>
	<td align="center" valign="middle">
		<input type="button" class="form" value="Pesquisar &gt;&gt;" onclick="javascript:validaCampos();">
	</td>
</tr>
</table>
</form>
<script language="JavaScript">
var f = document.all.formulario;
function validaCampos() {
	if((f.modelo.value == '') && (f.partnumber.value == '') && (f.fab_id.value == '') && (f.descricao.value == ''))
		alert('Preencha pelo menos um dos campos da pesquisa.');
	else
		f.submit();
}
f.modelo.focus();
</script>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
