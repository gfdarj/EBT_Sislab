<!------- LIB ------->
<!--#include file="../Lib/Classe_Combo.asp"-->
<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Cadastro > Modelo" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()
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
<form method=post action="cad_modelos2.asp" name="formulario"  onsubmit="return ValidaCampos();">
<table width="100%">
	<tr>
		<td class="texto1">
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
			      <td class="texto1">
	        		Modelo:&nbsp;<input type="text" class="texto1" name="mod_codnome" size=35 maxlength="50">
					</td>
			      <td class="texto1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fabricante:&nbsp;
					<%RW Combo.PadraoSql("fab_id", "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "N")%>
				</td>
	      		   
	    		</tr>
			</table>
	  	</td>
    </tr>
	<tr>
		<td>
  			<table width="600" cellpadding=0 cellspacing=0>
	  			<tr> 
	      		   <td bgcolor="#FFFFFF" class="texto1">SaP:&nbsp;
					<input type="text" class="texto1" name="mod_net" style="width:100" maxlength="100">
					</td>
				  <td bgcolor="#FFFFFF" class="texto1">Área de Utilização:
				  <%ssql = "select * from sce_areautilizacao order by au_descricao"
				  set rec = Env.oconn.execute(ssql)
				  if not rec.eof then%>
					<select name="au_id" class="texto1">
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
    			<!--  <td bgcolor="#FFFFFF" class="texto1">
				  	Código do SGP:&nbsp;
					<input type="text" class="form" name="cod_sgp" size="20" maxlength="100"><br><br>
				</td>-->
				<td bgcolor="#FFFFFF" class="texto1">Família Tipo:&nbsp;
					<%ssql = "select * from sce_tipos order by tipo_descricao"
					set rec = Env.oconn.execute(ssql)
					if not rec.eof then%>
						<select name="tipo_id" class="texto1">
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
      <td bgcolor="#FFFFFF" class="texto1">Descrição do Modelo<br><textarea style="width:550" cols="80" rows="5" name="mod_descricao" class="form"></textarea><br><br></td>
	 </tr>
	<tr> 
      	<td bgcolor="#FFFFFF" class="texto1">Observações<br>
		<textarea class="texto1" name="mod_obs" style="width:550" cols="80" rows="5"></textarea></td>
	</tr>
	<tr> 
      	<td bgcolor="#FFFFFF"  class="texto1"><br>Part Number:<br>
		<input type="text" class="texto1" name="p_number" size="100" maxlength="100"></td>
	</tr>
	<tr>
		<td class="texto1"><br><input type="checkbox" name="sgp" value="1" checked>&nbsp;atualizar pelo SGP</td>
	</tr>
	 <tr> 
      <td><br><%if n <> 1 then%><input type="submit" name="Submit" value=" Cadastrar " class="texto1"><%end if%></td>
    </tr>
  </table>
  </form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
