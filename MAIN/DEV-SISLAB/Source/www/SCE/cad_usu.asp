<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Cadastra Usuário", "", "history.go(-1);")
%>
<SCRIPT Language="JScript">
	<!--#include file="includes/vform.js"-->
</SCRIPT>
<form method=post action="cad_usu2.asp" name="formulario" onsubmit="vdform('formulario','nome','Nome','R','login','Login','R','email','Email','Email','senha','Senha','R'); return document.ValorPassou;">
<table width="100%">
	<tr>
		<td class=texto>
		<%if request("msg") <> "" then response.write "<strong>Usuário cadastrado com sucesso!<br><br></strong>"%></td>
	</tr>
	<tr class="texto"> 
    	<td>
		  <table width="100%" cellpadding=0 cellspacing=0 class="texto">
			  <tr> 
			      <td>Nome<br>
						<input type=text name=nome class=form style="width:300" maxlength="50">
			      </td>
			      <td>Email<br>
				  <input type="text" class="form" name="email" style="width:300" maxlength="50"></td>
			    </tr>
				<tr class="texto"><td>&nbsp;</td></tr>
				<tr> 
			      <td>Login<br>
						<input type=text name=login class=form style="width:300" maxlength="50">
			      </td>
			      <td>Senha<br>
				  <input type="password" class="form" name="senha" style="width:300" maxlength="50"></td>
			    </tr>
			</table>
	  </td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr class="texto">
		<td>Status<br>
			<select name=status class=form>
				<option value=1 selected>Administrador</option>
				<option value=2>Operador</option>
				<option value=3>Responsável Técnico</option>
			</select>
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr><td><input type="submit" name="Submit" value=" Cadastrar " class="form" ></td></tr>
 </table>
</form>
<%
call ImprimeRodape (RODAPE_OFF)
%>