<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!-- #INCLUDE FILE="includes/abre.asp" -->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Consulta Natureza de Operação	", "", "history.go(-1);")
%>
<script language=javascript>
function navselecao()
{
    document.formulario.submit();
}
</script>
<form name="formulario" method="post" action="alt_cad_no.asp">
<table width="100%">
	<tr>
		<div class=texto>
		<%if request("msg") <> "" then
			if cint(request("msg")) = 1 then response.write "Natureza de Operação alterada com sucesso.<br><br>"
			if cint(request("msg")) = 2 then response.write "Natureza de Operação excluída com sucesso.<br><br>"
		end if
		%></div></td>
	</tr> 
    <tr> 
		<td class="titulo">Editar / Excluir Natureza de Operação</td>
	</tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr>
		<td VALIGN="TOP" class=texto>
			<%ssql = "select * from sce_natureza_operacao order by no_descricao"
			set rec = conn.execute(ssql)
			if not rec.eof then%>
				<select name="no_id" size="15" class="form" style="width:600" >
				<%while not rec.eof%>
					<option value="<%=rec("no_id")%>"><%=rec("no_descricao")%></option>
					<%rec.movenext
				wend%>
				</select>
			<%else
				response.write "Não existem Naturezas de Operação cadastradas no momento."
			end if%>
		</td>
	</tr>
	<tr>
		<td class="texto" align="left"><br><br><input type=submit value=" Editar " class=form></td>
    </tr>
  </table>
</form>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
