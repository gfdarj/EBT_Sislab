<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SCE = True
Tela.SetNomeTela = "Consulta > Altera Família Tipo" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    'Call Tela.ImprimeMenuSce()
%>
<script type="text/javascript">
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
<%
ssql = "select * from sce_tipos where tipo_id = "& request("tipo_id")
set rec = Env.oconn.execute(ssql)
%>
<form method=post action="alt_tipos2.asp" name="formulario"  onsubmit="return ValidaCampos();">
<input type=hidden name=tipo_id value="<%=request("tipo_id")%>">
<table width="100%">
	<tr>
		<td>
			<table width="100%">
				<tr>
					<%ssql = "select * from sce_tipos where tipo_id <> "& rec("tipo_id") &" order by tipo_descricao"
					set rec2 = Env.oconn.execute(Ssql)
					if not rec2.eof then%>
						<td >Filho de:<br />
							<select name="super_tipo" >
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
	 	<td bgcolor="#FFFFFF" >Tipo<br><input type="text"  name="tipo_descricao" style="width:600" maxlength="100" value="<%=rec("tipo_descricao")%>"><br><br></td>
	</tr>
	<script>
		function func(){
			document.formulario.action = "exc_tipos.asp"
		}
	</script>
	<tr>
		<td><input type="submit" class="btn btn-primary" name="Submit" value=" Alterar " >&nbsp;&nbsp;<input type="submit" name="Submit" value=" Excluir "  onclick="func();"></td>
	</tr>
 </table>
</form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
