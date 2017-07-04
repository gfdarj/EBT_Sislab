<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!-- #INCLUDE FILE="includes/abre.asp" -->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Consulta Família Tipo", "", "history.go(-1);")
%>
<script language=javascript>
function navselecao()
{
    document.formulario.submit();
}
</script>
<form name="formulario" method="post" action="alt_tipos.asp">
<table width="100%">
	<tr>
		<td class=texto>
		<%if request("msg") <> "" then
			if cint(request("msg")) = 1 then response.write "Família Tipo alterada com sucesso!<br><br>"
			if cint(request("msg")) = 2 then response.write "Família Tipo excluída com sucesso!<br><br>"
		end if%></td>
	</tr> 
   <tr>
	    <td  valign="middle" class="titulo">Editar / Excluir Família Tipo :</td>
	</tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr>
		<td valign="top" class="texto">
			<%ssql = "select * from sce_tipos order by tipo_descricao"
			set rec = conn.execute(ssql)
			if not rec.eof then%>
				<select name="tipo_id" size="15" class="form" style="width:600">
				<%while not rec.eof%>
					<option value="<%=rec("tipo_id")%>"><%=rec("tipo_descricao")%></option>
					<%rec.movenext
				wend%>
				</select>
			<%else%>
				Não Existem Familia Tipo Cadastrada No Momento.
			<%end if%>
		</td>		
    </tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr>
		<td valign=top class="texto"><input type=submit value=" Editar " class=form></td>
	</tr>
  </table>
</form>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
