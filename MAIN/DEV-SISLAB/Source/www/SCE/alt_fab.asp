<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!-- #INCLUDE FILE="includes/abre.asp" -->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Consulta de Fabricantes", "", "history.go(-1);")
%>
<script language=javascript>
function navselecao()
{
    document.formulario.submit();
}
</script>
<form name="formulario" method="post" action="alt_fab2.asp">
<table width="100%">
	<tr>
		<td class=texto>
		<%if request("msg") <> "" then
			if cint(request("msg")) = 1 then response.write "Fabricante alterado com sucesso<br><br>"
			if cint(request("msg")) = 2 then response.write "Fabricante excluído com sucesso<br><br>"
		end if%></td>
	</tr>
   <tr>
	    <td class="texto">
			<table>
				<tr>
					<td class="titulo">Editar / Excluir Fabricantes Cadastrados:</td>
				</tr>
				<tr><td class="texto">&nbsp;</td></tr>
				<tr>
					<td valign="top" class=texto>
						<%ssql = "select * from sce_fabricantes order by fab_nome"
						set rec = conn.execute(ssql)
						if not rec.eof then%>
							<select name="fab_id" size="15" class="form" style="width:600px">
							<%while not rec.eof%>
				<option value="<%=rec("fab_id")%>"><%=rec("fab_nome")%></option>
								<%rec.movenext
							wend%>
							</select>
						<%else
							a = 1
							response.write "Não existem Fabricantes cadastradas no momento."
						end if%>
					</td>
				</tr>
				<tr><td class="texto">&nbsp;</td></tr>
				<tr>
					<td class="texto"><%if a <> 1 then%><input type=submit value=" Alterar " class=form><%end if%></td>
			    </tr>
			</table>
		</td>
	</tr>
 </table>
</form>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
