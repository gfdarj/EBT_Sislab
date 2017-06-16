<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!-- #INCLUDE FILE="includes/abre.asp" -->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Altera Família Tipo", "", "history.go(-1);")
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
<%ssql = "select * from sce_tipos where tipo_id = "& request("tipo_id")
set rec = conn.execute(ssql)%>
<form method=post action="alt_tipos2.asp" name="formulario"  onsubmit="return ValidaCampos();">
<input type=hidden name=tipo_id value="<%=request("tipo_id")%>">
<table width="100%">
	<tr>
		<td>
			<table width="100%">
				<tr>
					<%ssql = "select * from sce_tipos where tipo_id <> "& rec("tipo_id") &" order by tipo_descricao"
					set rec2 = conn.execute(Ssql)
					if not rec2.eof then%>
						<td class="texto">Filho de:&nbsp;
							<select name="super_tipo" class="form">
								<option value=""></option>
								<%while not rec2.eof%>
									<option value="<%=rec2("tipo_id")%>" <%if rec("TIPO_supertipo") = rec2("tipo_id") then response.write " selected"%>><%=rec2("tipo_descricao")%></option>
									<%rec2.movenext
								wend%>
							</select>
						</td>
					<%end if%>
				</tr>
			</table>
		</td>
	</tr>
	 <tr> 
	 	<td bgcolor="#FFFFFF" class="texto">Tipo:<br><input type="text" class="form" name="tipo_descricao" style="width:600" maxlength="100" value="<%=rec("tipo_descricao")%>"><br><br></td>
	</tr>
	<script>
		function func(){
			document.formulario.action = "exc_tipos.asp"
		}
	</script>
	<tr>
		<td><input type="submit" name="Submit" value=" Alterar " class="form">&nbsp;&nbsp;<input type="submit" name="Submit" value=" Excluir " class="form" onclick="func();"></td>
	</tr>
 </table>
</form>
