<!-- #INCLUDE FILE="includes/abre.asp" -->


<!--#include file="interface_s.inc"-->

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
</script>
<form method=post action="alt_cad_nf.asp" name="formulario"  onsubmit="return ValidaCampos();">
<input type="hidden" name="tipocomando" value="">
<input type="hidden" name="enf_id" value="">
<div align="center">
<table width="780">	
	<tr>
		<td width="780"><!--#include file="includes/menu_rel.asp"--></td>
	</tr>
   <tr>
	    <td class="titulo">Relatório de por Status<br><br></td>
  	</tr>
    <tr> 
      <td align="center">
  		<table width="100%" cellpadding=0 cellspacing=0>
    		  <tr>
				 <td class="texto" align="center"><br><a href="alt_acessorios.asp">item 1</a></td>
			  </tr>
			  <tr>
				 <td class="texto" align="center"><br><a href="alt_acessorios.asp">item 1</a></td>
			  </tr>
			  <tr>
				 <td class="texto" align="center"><br><a href="alt_acessorios.asp">item 1</a></td>
			  </tr>
			  <tr>
				 <td class="texto" align="center"><br><a href="alt_acessorios.asp">item 1</a></td>
			  </tr>
			  <tr>
				 <td class="texto" align="center"><br><a href="alt_acessorios.asp">item 1</a></td>
			  </tr>
			  <tr>
				 <td class="texto" align="center"><br><a href="alt_acessorios.asp">item 1</a></td>
			  </tr>
			  <tr>
				 <td class="texto" align="center"><br><a href="alt_acessorios.asp">item 1</a></td>
			  </tr>
			  </table>
      </td>
    </tr>
    
</form>
  </table>



<!--#include file="interface_i.inc"-->
