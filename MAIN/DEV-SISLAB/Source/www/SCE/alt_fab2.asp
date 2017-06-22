<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<!-- #INCLUDE FILE="includes/estado.asp" -->
<%
ssql = "select * from sce_fabricantes where fab_id = "& request("fab_id")
set rec = conn.execute(ssql)

call ImprimeCabecalho ("", MENU_ON, true, "Alterar Fabricante", "", "history.go(-1);")
%>
<form method=post action="alt_fab3.asp" name="formulario">
<input type="hidden" name="fab_id" value="<%=request("fab_id")%>">
<table width="100%">
    <tr> 
		<td class="texto">Nome do Fabricante<br>
					<input type="text" class="form" name="fab_nome" style="width:600px" maxlength="100" value="<%=rec("fab_nome")%>">
		</td>
	</tr>
	<script>
	function func2(){
		document.formulario.action = "exc_fabricantes.asp"
	}
	</script>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr> 
		<td><input type="submit" name="Submit" value=" Alterar " class="form">&nbsp;&nbsp;<input type="submit" name="Submit" value=" Excluir " class="form" onclick="func2();"></td>
    </tr>
</form>
</table>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
