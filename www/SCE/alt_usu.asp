<!-- #include file="includes/controlesHTML_SCE.asp" -->
<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Altera Usuário", "", "history.go(-1);")
%>
<SCRIPT Language="JScript">
	<!--#include file="includes/vform.js"-->
</SCRIPT>
<form method=post action="alt_usu2.asp" name="formulario" onsubmit="vdform('formulario','nome','Nome','R','login','Login','R','email','Email','REmail','senha','Senha','R'); return document.ValorPassou;">
<table width="100%">
	<tr>
		<td class=texto>
		<%if request("msg") = "1" then response.write "<strong>Usuário alterado com sucesso!<br><br></strong>"%>
		<%if request("msg") = "2" then response.write "<strong>Usuário excluído com sucesso!<br><br></strong>"%></td>
	</tr>
	<tr>
		<td class="texto">
			Escolha usuário:&nbsp;
			<%call comboBDSQL( "id", conn, "select user_id as VALOR, user_nome as DESCRICAO from sce_usuarios order by user_nome", "", "S")%>
		  </td>
	</tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr> 
	<script>
	function func(){
	document.formulario.action="exc_usu.asp"
	}
	</script>
	   <td><input type="submit" name="Submit" value=" Alterar " class="form" >&nbsp;&nbsp;<input type="submit" name="Submit" value=" Excluir " class="form" onclick="func();"></td>
    </tr>
 </table>
</form>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
