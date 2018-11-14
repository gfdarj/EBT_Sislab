<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!--#include file="includes/Estado.asp"-->
<!--#include file="includes/Func.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Cadastro > Fabricante" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Call Tela.ImprimeMenuSce()
%>
<script type="text/javascript">
function ValidaCampos()
{
	var frm = document.formulario;
	if (frm.enf_nome.value.length == 0)
	{
		alert("Defina o Nome da Empresa!");
		frm.enf_nome.focus()
		return false;
	}
	return true;
}

function Mascara (keypress, objeto){
	campo = eval (objeto);
	separador = '-'; 
	conjunto1 = 5;
	if (campo.value.length == conjunto1){
		campo.value = campo.value + separador;
	}
}

function Mascara2 (keypress, objeto){
	campo = eval (objeto);
	separador = '-'; 
	conjunto1 = 4;
	if (campo.value.length == conjunto1){
		campo.value = campo.value + separador;
	}
}
<!--#include file="includes/vform.js"-->
</script>

<div class="margem-10">

<form method="post" action="cad_fab2.asp" name="formulario"  onsubmit="vdform('formulario','nome','Nome','R'); return document.ValorPassou;">
<table>
	<tr>
		<td >
		<%if request("msg") <> "" then response.write "<br><strong>Fabricante cadastrado com sucesso!</strong><br><br>"%></td>
	</tr>
    <tr> 
      <td>
  		<table >
    		<tr> 
      			<td bgcolor="#FFFFFF" align="left" >Fabricante<br>
					<input type="text"  name="nome" style="width:600px" maxlength="100"></td>
    		</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
      			<td><input type="submit" name="Submit" value="Cadastrar" ></td>
		    </tr>
		</table>
      </td>
    </tr>
  </table>
</form>
</div>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
