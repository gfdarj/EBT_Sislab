<!-- #include file="includes/controlesHTML_SCE.asp" -->
<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<script language="javascript">
function ValidaCampos()
{
	var frm = document.formulario;
	if (frm.mod_codnome.value.length == 0)
	{
		alert("Defina o Modelo!");
		frm.mod_codnome.focus();
		return false;
	}
	else if (frm.fab_id.value.length == 0)
	{
		alert("Defina o fabricante do Modelo!");
		frm.fab_id.focus();
		return false;
	}
	return true;
}
</script>
<%
call ImprimeCabecalho ("", MENU_ON, true, "Alterar Modelo", "", "history.go(-1);")

ssql = "select * from sce_modelos where mod_id = " & request("mod_id")
set recm = conn.execute(ssql)
%>
<form method=post action="alt_modelos2.asp" name="formulario"  onsubmit="return ValidaCampos();">
<input type=hidden name=mod_id value="<%=recm("mod_id")%>">
<div align="left">
<table width="790px">
	<tr>
		<td>
			<table width="100%" class="texto" cellpadding=0 cellspacing=0>
			<tr>
				<td>
					Modelo:&nbsp;<input type="text" class="form" name="mod_codnome" size=35 maxlength="50" value="<%=recm("mod_codnome")%>">
				</td>
				<td>
					Fabricante:&nbsp;<%call comboBDSQL("fab_id", conn, "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", cstr(recm("fab_id")), "N")%>
				</td>
			</table>
		</td>
	</tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr>
		<td>
  			<table width="100%" class="texto" cellpadding=0 cellspacing=0>
			<tr> 
				<td class="texto">SaP:&nbsp;
					<input type="text" class="form" name="mod_net" maxlength="100" value="<%=recm("mod_net")%>">
				</td>
				<td class="texto">Área de Utilização:
				  <%ssql = "select * from sce_areautilizacao order by au_descricao"
				  set rec = conn.execute(ssql)
				  if not rec.eof then%>
					<select name="au_id" class="form">
					<%i = 0
					while not rec.eof
						ssql = "select * from sce_areasutil_modelo where mod_id = "& recm("mod_id") &" and au_id = "& rec("au_id")
						set rec2 = conn.execute(ssql)%>
						<option value="<%=rec("au_id")%>" <%if not rec2.eof then response.write "selected"%>><%=rec("au_descricao")%></option>
						<%rec.movenext
					wend%>
					</select>
				  <%end if%>
			   </td>
	    	</tr>
			</table>
	  	</td>
    </tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr> 
		<td class="texto">
			Família Tipo:&nbsp;
					<%ssql = "select * from sce_tipos order by tipo_descricao"
					set rec = conn.execute(ssql)
					if not rec.eof then%>
			<select name="tipo_id" class="form">
				<option value=""></option>
						<%while not rec.eof%>					
				<option value="<%=rec("tipo_id")%>" <%if recm("tipo_id") = rec("tipo_id") then response.write " selected"%>><%=rec("tipo_descricao")%></option>
							<%rec.movenext
						wend%>
			</select>
					<%end if%>
		</td>	
	</tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr> 
		<td bgcolor="#FFFFFF" class="texto">Descrição do Modelo<br><textarea style="width:550" cols="80" rows="5" name="mod_descricao" class="form"><%=recm("mod_descricao")%></textarea></td>
	</tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr> 
      	<td bgcolor="#FFFFFF" class="texto">Observações<br>
		<textarea class="form" name="mod_obs" style="width:550" cols="80" rows="5"><%=recm("mod_obs")%></textarea></td>
	</tr>
	<%ssql = "select * from sce_partnumbermodelo where mod_id = "& recm("mod_id")
	set rec = conn.execute(ssql)%>
	<tr> 
      	<td bgcolor="#FFFFFF"  class="texto"><br>Part Number:<br>
		<input type="text" class="form" name="p_number" size="100" maxlength="100"  <%if not rec.eof then%>value="<%=rec("pn_partnumber")%>"<%end if%>></td>
	</tr>

	<tr>
		<td class="texto"><br><input type="checkbox" name="sgp" value="1" <%if recm("sgp") = 1 then response.write " checked"%>>&nbsp;atualizar pelo SGP</td>
	</tr>
	<script>
		function func2(){
			document.formulario.action = "exc_modelos.asp";
		}
	</script>
	 <tr> 
      <td><br><input type="submit" name="Submit" value=" Alterar " class="form">&nbsp;&nbsp;<input type="submit" name="Submit" value=" Excluir " class="form" onClick="func2();"></td>
    </tr>
  </table>
  </form>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
