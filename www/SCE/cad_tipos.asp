<!-- #include file="includes/controlesHTML_SCE.asp" -->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Cadastra Família Tipo", "", "history.go(-1);")
%>
<script language="javascript">
function ValidaCampos()
{
	var frm = document.formulario;
	if (frm.tipo_descricao.value.length == 0)
	{
		alert('Defina a Descrição da Família Tipo!')
		frm.tipo_descricao.focus();
		return false;
	}
	return true;
}
</script>
<form method=post action="insCad_tipos.asp" name="formulario"  onsubmit="return ValidaCampos();">
<table width="100%">
	<tr>
		<td class=texto><%
		msg = request("msg")
		if msg  = 1 then
		response.write "Tipo cadastrado com sucesso!<br><br>"
		elseif msg = 2 then
		response.write "Tipo já existente!<br><br>"
		end if%></td>
	</tr> 
	<tr class="texto">
		<td>Filho de:&nbsp;<br>
			<%call comboBDSQL( "super_tipo", conn, "select tipo_id as VALOR, tipo_descricao as DESCRICAO from sce_tipos order by tipo_descricao", "", "N")%>
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr class="texto"><td>Tipo:<br><input type="text" class="form" name="tipo_descricao" style="width:600" maxlength="100"></td></tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr><td><input type="submit" name="Submit" value=" Cadastrar " class="form"></td></tr>
 </table>
</form>
<%
conn.close
set conn=nothing

call ImprimeRodape (RODAPE_OFF)
%>