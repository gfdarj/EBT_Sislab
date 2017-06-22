<!-- #include file="includes/controlesHTML_SCE.asp" -->
<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!-- #include file="includes/global_SCE.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Altera Usuário", "", "history.go(-1);")
%>
<SCRIPT Language="JScript">
<!--#include file="includes/vform.js"-->
</SCRIPT>
<form method=post action="alt_usu3.asp" name="formulario" onsubmit="vdform('formulario','nome','Nome','R','login','Login','R','email','Email','REmail','senha','Senha','R'); return document.ValorPassou;">
<input type=hidden name=id value="<%=request("id")%>">
<table width="100%">
<%ssql = "select *, cast(user_senha as VARCHAR) as senha from sce_usuarios where user_id = "& request("id")
set rec = conn.execute(ssql)%>
  	<tr>
		<td class="titulo">Alterar Usuário:</td>
	</tr>
	<tr> 
    	<td>
		  <table width="100%" cellpadding=0 cellspacing=0 height=80 class="texto">
			  <tr> 
			      <td>Nome<br>
						<input type=text name=nome class=form style="width:300" maxlength="50" value="<%=rec("user_nome")%>">
			      </td>
			      <td class="texto">Email<br>
				  <input type="text" class="form" name="email" style="width:300" maxlength="50" value="<%=rec("user_email")%>"></td>
			    </tr>
				<tr><td>&nbsp;</td></tr>
				<tr> 
			      <td>Login<br>
						<input type=text name=login class=form style="width:300" maxlength="50" value="<%=rec("user_login")%>">
			      </td>
			      <td>Senha<br>
				  <input type="password" class="form" name="senha" style="width:300" maxlength="50" value="<%=rec("senha")%>"></td>
			    </tr>
				<tr><td>&nbsp;</td></tr>
				<tr> 
			      <td class="texto">Status<br>
						<select name="status" class="form">
							<option value="<%=PERFIL_ADM%>" <%if rec("user_status") = PERFIL_ADM then response.write "selected"%>>Adiministrador</option>
							<option value="<%=PERFIL_LOG%>" <%if rec("user_status") = PERFIL_LOG then response.write "selected"%>>Operador Log&iacute;stica</option>
							<option value="<%=PERFIL_RAT%>" <%if rec("user_status") = PERFIL_RAT then response.write "selected"%>>Responsável Técnico</option>
						</select>
			      </td>
			    </tr>
			</table>
	  </td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr> 
	   <td><input type="submit" name="Submit" value=" Alterar " class="form" ></td>
    </tr>
 </table>
</form>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
