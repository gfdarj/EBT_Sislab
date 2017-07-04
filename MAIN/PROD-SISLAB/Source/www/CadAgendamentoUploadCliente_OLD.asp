<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_str.asp" -->
<%
Dim agendamento
agendamento =  request("agendamento")

call ImprimeCabecalho2("Cadastro de Agendamento - Upload de Arquivos", MENU_OFF, false, "100%", "Agendamento " & agendamento & " - Upload de Arquivos e Diagramas", "NENHUM", "")

'-- este arquivo de upload deve ser executado dentro de uma janela
if agendamento = "" then%>
<script language="JavaScript">
	alert("Nenhum agendamento definido !");
	window.close();
</script>
<%
end if
%>
<form method="Post" enctype="multipart/form-data" name="frmEnviarArq" action="uploaddiag.asp">
<input type="Hidden" name="vezes" value="0">
<input type="hidden" name="cod_AS" value=<%=agendamento%>>
<input type="hidden" name="username" value="<%=UCase(trim(mid(Request.ServerVariables("REMOTE_USER"),10)))%>">
<input type="hidden" name="ip" value="<%=UCase(request.ServerVariables("REMOTE_ADDR"))%>">
<table border="0" width="100%" class="tabela1" cellpadding="3" cellspacing="3">
<tr>
	<td>
		&nbsp;<span class="vermelho2">&raquo;</span>&nbsp;<span class="texto1b" style="font-size: 12px;">Selecione até 3 diagramas associados ao teste</span>
	</td>
</tr>
<tr>
	<td>Arquivo 1:&nbsp;<INPUT TYPE=FILE SIZE=40 NAME="FILE1" class="texto1"></td>
</tr>
<tr>
	<td>Arquivo 2:&nbsp;<INPUT TYPE=FILE SIZE=40 NAME="FILE2" class="texto1"></td>
</tr>
<tr>
	<td>Arquivo 3:&nbsp;<INPUT TYPE=FILE SIZE=40 NAME="FILE3" class="texto1"></td>
</tr>
<tr>
	<td><INPUT TYPE=SUBMIT VALUE="Enviar Arquivo(s)"></td>
</tr>
</table>
</form>
<p align="justify" class="texto1">
<span class="vermelho2">
O Upload de arquivo pode demorar alguns minutos.  Não recomendamos o upload de arquivos maiores de 2MBytes.  Neste caso, por favor envie o arquivo compactado.
</span>
</p>
<%
call imprimeRodape(RODAPE_OFF)
%>
