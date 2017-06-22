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
Tela.SetNomeTela = "SCE > Consulta > Alterar Modelo" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()

    Dim ssql, recm

    ssql = "select * from sce_modelos where mod_id = " & request("mod_id")
    set recm = Env.oconn.execute(ssql)
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
<form method=post action="alt_modelos2.asp" name="formulario"  onsubmit="return ValidaCampos();">
<input type=hidden name=mod_id value="<%=recm("mod_id")%>">
<div align="left">
<table width="790px">
	<tr>
		<td>
			<table width="100%" class="texto1" cellpadding=0 cellspacing=0>
			<tr>
				<td>
					Modelo:&nbsp;<input type="text" class="texto1" name="mod_codnome" size=35 maxlength="50" value="<%=recm("mod_codnome")%>">
				</td>
				<td>
					Fabricante:&nbsp;<%RW Combo.PadraoSql("fab_id", "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", cstr(recm("fab_id")), "N")%>
				</td>
			</table>
		</td>
	</tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr>
		<td>
  			<table width="100%" class="texto1" cellpadding=0 cellspacing=0>
			<tr> 
				<td class="texto1">SaP:&nbsp;
					<input type="text" class="texto1" name="mod_net" maxlength="100" value="<%=recm("mod_net")%>">
				</td>
				<td class="texto1">Área de Utilização:
				  <%ssql = "select * from sce_areautilizacao order by au_descricao"
				  set rec = Env.oconn.execute(ssql)
				  if not rec.eof then%>
					<select name="au_id" class="texto1">
					<%i = 0
					while not rec.eof
						ssql = "select * from sce_areasutil_modelo where mod_id = "& recm("mod_id") &" and au_id = "& rec("au_id")
						set rec2 = Env.oconn.execute(ssql)%>
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
	<tr><td class="texto1">&nbsp;</td></tr>
	<tr> 
		<td class="texto1">
			Família Tipo:&nbsp;
					<%ssql = "select * from sce_tipos order by tipo_descricao"
					set rec = Env.oconn.execute(ssql)
					if not rec.eof then%>
			<select name="tipo_id" class="texto1">
				<option value=""></option>
						<%while not rec.eof%>					
				<option value="<%=rec("tipo_id")%>" <%if recm("tipo_id") = rec("tipo_id") then response.write " selected"%>><%=rec("tipo_descricao")%></option>
							<%rec.movenext
						wend%>
			</select>
					<%end if%>
		</td>	
	</tr>
	<tr><td class="texto1">&nbsp;</td></tr>
	<tr> 
		<td bgcolor="#FFFFFF" class="texto1">Descrição do Modelo<br><textarea style="width:550" cols="80" rows="5" name="mod_descricao" class="texto1"><%=recm("mod_descricao")%></textarea></td>
	</tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr> 
      	<td bgcolor="#FFFFFF" class="texto1">Observações<br>
		<textarea class="texto1" name="mod_obs" style="width:550" cols="80" rows="5"><%=recm("mod_obs")%></textarea></td>
	</tr>
	<%ssql = "select * from sce_partnumbermodelo where mod_id = "& recm("mod_id")
	set rec = Env.oconn.execute(ssql)%>
	<tr> 
      	<td bgcolor="#FFFFFF"  class="texto1"><br>Part Number:<br>
		<input type="text" class="texto1" name="p_number" size="100" maxlength="100"  <%if not rec.eof then%>value="<%=rec("pn_partnumber")%>"<%end if%>></td>
	</tr>

	<tr>
		<td class="texto1"><br><input type="checkbox" name="sgp" value="1" <%if recm("sgp") = 1 then response.write " checked"%>>&nbsp;atualizar pelo SGP</td>
	</tr>
	<script>
		function func2(){
			document.formulario.action = "exc_modelos.asp";
		}
	</script>
	 <tr> 
      <td><br>
        <input type="submit" name="Submit" value=" Alterar " class="texto1">&nbsp;&nbsp;
        <input type="submit" name="Submit" value=" Excluir " class="texto1" onClick="func2();">
      </td>
    </tr>
  </table>
  </form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>