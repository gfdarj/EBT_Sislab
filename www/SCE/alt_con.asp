<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!-- #INCLUDE FILE="includes/abre.asp" -->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Consulta de Consumíveis", "", "history.go(-1);")
%>
<form name="formulario" method="post" action="alt_con2.asp">
<table width="100%">
	<tr>
	    <td  valign="middle" class="titulo">Busque o Consumível:<br><div class=texto>
		<%if request("msg") <> "" then
			if cint(request("msg")) = 1 then response.write "Consumível alterado com sucesso!<br><br>"
			if cint(request("msg")) = 2 then response.write "Consumível excluído com sucesso!<br><br>"
		end if%></div>
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr>
		<td class="texto" >
			Descrição:&nbsp;<input type="text" class="form" name="descricao" style="width:200px" maxlength="50">
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr>
		<td class="texto">
			Localizacao:&nbsp;<input type="text" class="form" name="localizacao" style="width:200px" maxlength="50">
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr>
		<td class="texto"align="center"><input type="submit" name="buscar" value="buscar &gt;&gt;" class="form"></td>
	</tr>
  </table>
</form>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
