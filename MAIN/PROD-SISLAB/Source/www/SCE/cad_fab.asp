<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#INCLUDE file="includes/abre.asp" -->
<!-- #INCLUDE FILE="includes/estado.asp" -->
<!--#include file="includes/func.asp"-->
<script language="javascript">
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
<%
call ImprimeCabecalho ("", MENU_ON, true, "Cadastra Fabricante", "", "history.go(-1);")
%>
<form method=post action="cad_fab2.asp" name="formulario"  onsubmit="vdform('formulario','nome','Nome','R'); return document.ValorPassou;">
<div align="center">
<table width="100%">	
	<tr>
		<td class=texto>
		<%if request("msg") <> "" then response.write "<br><strong>Fabricante cadastrado com sucesso!</strong><br><br>"%></td>
	</tr>
    <tr> 
      <td>
  		<table width="100%" cellpadding=0 cellspacing=0>
    		<tr> 
      			<td bgcolor="#FFFFFF" align="left" class="texto">Fabricante<br>
					<input type="text" class="form" name="nome" style="width:600px" maxlength="100"></td>
    		</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
      			<td><input type="submit" name="Submit" value="Cadastrar" class="form"></td>
		    </tr>
		</table>
      </td>
    </tr>
</form>
  </table>
<%
conn.close
set conn=nothing

call ImprimeRodape (RODAPE_OFF)
%>
