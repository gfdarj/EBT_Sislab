<!-- #include file="../includes/funcoes.asp" -->
<!--#include file="includes/controlesHTML_SCE.asp" -->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/bib_str.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Histórico Geral", "", "history.go(-1);")
%>
<script language=javascript>
	<!--#include file="includes/vform.js"-->
</script>

<form name="formulario" method="post" action="log2.asp" >
<input type=hidden name=busca value=1>
 <table width="100%" class="texto">
	<tr>
	    <td  valign="middle" class="titulo">Informe o usuário e/ou a data:<br><br></td>
	</tr>
	 <tr>
		<td> 
      		<table border="0" class="texto">
	  			<tr>
	    			<td colspan="2">
						Usuário (username):&nbsp;
						<input type="text" class="form" name="username" style="width:200px" maxlength="50">&nbsp;&nbsp;<br><br>
					</td>
				</tr>
				<tr>
	    			<td colspan="2">
						Usuário (nome):&nbsp;
						<input type="text" class="form" name="nome" style="width:200px" maxlength="50">&nbsp;&nbsp;<br><br>
					</td>
				</tr>
				<tr>
	    			<td colspan="2">
						Data:&nbsp;<%Call ComboData("")%>
						<br><br>
					</td>
				</tr>
	  			<tr>
					<td colspan="2"><br></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" name="buscar" value="buscar &gt;&gt;" class="form"></td>
				</tr>
			</table>
      	</td>
    </tr>
  </table>
</form>

</center>
<script>
var frm = document.formulario;
<%if bpT then%>
frm.tia_id.value = "<%=tia_id%>";
<%end if%>
</script>
<%
'conn.close
'set conn=nothing

call ImprimeRodape (RODAPE_OFF)
%>
