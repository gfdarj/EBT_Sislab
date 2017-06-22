<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!-- #INCLUDE FILE="includes/abre.asp" -->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Consulta Área de Utilização", "", "history.go(-1);")
%>
<script language=javascript>
function navselecao()
{
    document.formulario.submit();
}
</script>
<form name="formulario" method="post" action="alt_areasutilizacao.asp">
<table width="100%">
	<tr>
		<td class=texto>
		<%if request("msg") <> "" then
			if cint(request("msg")) = 1 then response.write "Area de Utilização alterada com sucesso!<br><br>"
			if cint(request("msg")) = 2 then response.write "Area de Utilização excluída com sucesso!<br><br>"
		end if%>
		</td>
	</tr>
  	<tr>
	    <td  valign="middle" class="titulo">Editar Areas de Utilização Cadastradas:</td>
	</tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr>
		<td valign="top" valign="middle" class="texto">
		<%ssql = "select * from sce_areautilizacao order by au_descricao"
		set rec = conn.execute(ssql)
		if not rec.eof then%>
			<select name="au_id" size="15" class="form" style="width:600">
			<%while not rec.eof%>
				<option value="<%=rec("au_id")%>"><%=rec("au_descricao")%></option>
				<%rec.movenext
			wend%>
			</select>
		<%else
			response.write "Não Existem Areas de Utilização Cadastradas No Momento."
		end if%>
		</td>
    </tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr>
	    <td  valign="middle" class="titulo"><input type=submit value=" Alterar " class=form></td>
	</tr>
</table>
</form>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
