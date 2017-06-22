<!--#include file="../includes/funcoes.asp" -->
<!--#include file="includes/controlesHTML_SCE.asp" -->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Relatório de Passagem de Carga", "", "history.go(-1);")

'Response.write "<br><p class='texto'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Página em construção...</b></p>"
'Response.end
%>
<form name="formulario" action="rel_pas2.asp" method="post">
<table width="100%" class="texto">
<tr>
	<td><span class="titulo">Agendamento:</span><br>
		<%call comboAgendamento("txtAS", "ag_numero", conn, "", "N")%>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td><span class="titulo">Respons&aacute;vel</span><br>
	<%call comboUSERCRT("ag_responsavel", Conn, "N")%>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr><td><input type="Submit" class="form" value=" Gerar "></td></tr>
</table>
</form>
<%
conn.close
set conn=nothing

call ImprimeRodape (RODAPE_OFF)
%>
