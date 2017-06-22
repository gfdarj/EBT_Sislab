<!--#include file="includes/controlesHTML_SCE.asp" -->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#INCLUDE file="includes/abre.asp" -->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Cadastra Modelo", "", "history.go(-1);")
%>
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
<form method=post action="insCad_modelos.asp" name="formulario"  onsubmit="return ValidaCampos();">
<table width="100%">
	<tr>
		<td class=texto>
<%		msg =  request("msg")
		if msg = 1 then
		response.write "Modelo inserido com sucesso!<br><br>"
		elseif msg = 2 then
		response.write "Este Part Number já existe<br><br>"
		end if%></td>
	</tr>
	<tr>
		<td>
  			<table cellpadding=0 cellspacing=0>
	  			<tr>
			      <td class="texto">
	        		Modelo:&nbsp;<input type="text" class="form" name="mod_codnome" size=35 maxlength="50">
					</td>
			      <td class="texto">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fabricante:&nbsp;
					<%call comboBDSQL( "fab_id", conn, "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "N")%>
				</td>
	      		   
	    		</tr>
			</table>
	  	</td>
    </tr>
	<tr>
		<td>
  			<table width="600" cellpadding=0 cellspacing=0>
	  			<tr> 
	      		   <td bgcolor="#FFFFFF" class="texto">SaP:&nbsp;
					<input type="text" class="form" name="mod_net" style="width:100" maxlength="100">
					</td>
				  <td bgcolor="#FFFFFF" class="texto">Área de Utilização:
				  <%ssql = "select * from sce_areautilizacao order by au_descricao"
				  set rec = conn.execute(ssql)
				  if not rec.eof then%>
					<select name="au_id" class="form">
					<%i = 0
					while not rec.eof%>
						<option value="<%=rec("au_id")%>" <%if i = 0 then response.write "selected"%>><%=rec("au_descricao")%></option>
						<%rec.movenext
					wend%>
					</select>
				   <%else%>
				   	<strong>Para cadastrar, clique <a href="cad_areasutilizacao.asp">aqui.</a></strong>
				   <%n = 1
				   end if%><br><br>
				   </td>
	    		</tr>
			</table><br>
	  	</td>
    </tr>
	 
	<tr> 
		<td>
  			<table width="600" cellpadding=0 cellspacing=0>
	  			<tr> 
    			<!--  <td bgcolor="#FFFFFF" class="texto">
				  	Código do SGP:&nbsp;
					<input type="text" class="form" name="cod_sgp" size="20" maxlength="100"><br><br>
				</td>-->
				<td bgcolor="#FFFFFF" class="texto">Família Tipo:&nbsp;
					<%ssql = "select * from sce_tipos order by tipo_descricao"
					set rec = conn.execute(ssql)
					if not rec.eof then%>
						<select name="tipo_id" class="form">
						<option value=""></option>
						<%while not rec.eof%>					
							<option value="<%=rec("tipo_id")%>"><%=rec("tipo_descricao")%></option>
							<%rec.movenext
						wend%>
						</select>
					<%else%>
						<strong> Para cadastrar, clique <a href="cad_tipos.asp">aqui.</a></strong>
					<%n = 1
					end if%><br><br>
					</td>	
				 </tr>
			</table>
		</td>
	</tr>
	<tr> 
      <td bgcolor="#FFFFFF" class="texto">Descrição do Modelo<br><textarea style="width:550" cols="80" rows="5" name="mod_descricao" class="form"></textarea><br><br></td>
	 </tr>
	<tr> 
      	<td bgcolor="#FFFFFF" class="texto">Observações<br>
		<textarea class="form" name="mod_obs" style="width:550" cols="80" rows="5"></textarea></td>
	</tr>
	<tr> 
      	<td bgcolor="#FFFFFF"  class="texto"><br>Part Number:<br>
		<input type="text" class="form" name="p_number" size="100" maxlength="100"></td>
	</tr>
	<tr>
		<td class="texto"><br><input type="checkbox" name="sgp" value="1" checked>&nbsp;atualizar pelo SGP</td>
	</tr>
	 <tr> 
      <td><br><%if n <> 1 then%><input type="submit" name="Submit" value=" Cadastrar " class="form"><%end if%></td>
    </tr>
  </table>
  </form>
<%
conn.close
set conn=nothing

call ImprimeRodape (RODAPE_OFF)
%>
