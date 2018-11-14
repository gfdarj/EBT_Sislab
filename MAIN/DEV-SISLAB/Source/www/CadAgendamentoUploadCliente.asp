<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_str.asp" -->
<%
Dim agendamento
agendamento =  request("agendamento")

Call Tela.ImprimeCabecalho2("Cadastro de Agendamento - Upload de Arquivos", MENU_OFF, false, "100%", "Agendamento " & agendamento & " - Upload de Arquivos e Diagramas", "NENHUM", "")

'-- este arquivo de upload deve ser executado dentro de uma janela
if agendamento = "" then%>
<script type="text/javascript">
	alert("Nenhum agendamento definido !");
	window.close();
</script>
<%
end if
%>
<script language="javascript" src="includes/anexo.js"></script>
<script type="text/javascript">
function validaArquivos()
{
	var f = document.forms[0];
	var msg = "O nome do arquivo está inválido. Retire acentuação e espaços antes de prosseguir.";

	if((f.FILE1.value == '') && (f.FILE2.value == '') && (f.FILE3.value == ''))
	{
		alert('Selecione um arquivo para upload.');
		return false;
	}
	if(f.FILE1.value != '')
	{
		if( !validaNomeArquivo(extractFileName(f.FILE1.value)) ) {
			alert(msg);
			f.FILE1.focus();
			return false;
		}
	}
	if(f.FILE2.value != '')
	{
		if( !validaNomeArquivo(extractFileName(f.FILE2.value)) ) {
			alert(msg);
			f.FILE2.focus();
			return false;
		}
	}
	if(f.FILE3.value != '')
	{
		if( !validaNomeArquivo(extractFileName(f.FILE3.value)) ) {
			alert(msg);
			f.FILE3.focus();
			return false;
		}
	}
    return true;
}
</script>

<form method="Post" enctype="multipart/form-data" OnSubmit="return validaArquivos();" name="frmEnviarArq" action="uploaddiag.asp">
    <input type="hidden" name="vezes" value="0">
    <input type="hidden" name="cod_AS" value=<%=agendamento%>>
    <input type="hidden" name="username" value="<%=UCase(trim(mid(Request.ServerVariables("REMOTE_USER"),10)))%>">
    <input type="hidden" name="ip" value="<%=UCase(request.ServerVariables("REMOTE_ADDR"))%>">

    <table border="0" cellpadding="3" cellspacing="3" style="width: 100%;">
    <tr>
	    <td>
		    &nbsp;<span class="texto-vermelho-bold">&raquo;</span>&nbsp;Selecione até 3 diagramas associados ao teste
	    </td>
    </tr>
    <tr>
	    <td>Arquivo 1:&nbsp;<INPUT TYPE=FILE SIZE=40 NAME="FILE1"></td>
    </tr>
    <tr>
	    <td>Arquivo 2:&nbsp;<INPUT TYPE=FILE SIZE=40 NAME="FILE2"></td>
    </tr>
    <tr>
	    <td>Arquivo 3:&nbsp;<INPUT TYPE=FILE SIZE=40 NAME="FILE3"></td>
    </tr>
    <tr>
	    <td><INPUT type="submit" VALUE="Enviar Arquivo(s)"></td>
    </tr>
    </table>
</form>

<p align="justify">
    <span class="texto-vermelho-bold">
        O Upload de arquivo pode demorar alguns minutos.  Não recomendamos o upload de arquivos maiores de 2MBytes.  Neste caso, por favor envie o arquivo compactado.
    </span>
</p>
<%
Call Tela.MostraRodape()
%>
