<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Call ImprimeCabecalho2("Alteração de Arquivo", MENU_OFF, false, "100%", "Alteração de Arquivo", "NENHUM", "")
%>
	<form method="post" action="muda_arq_salva.asp" name="formulario" enctype="multipart/form-data">
	<input type="Hidden" name="proc" value="É hora de processar!">
	<input type="Hidden" name="codarq" value="<%=request("codarq")%>">
	<input type="Hidden" name="arq_ant" value="<%=request("ant")%>">
	<input type="Hidden" name="ag_numero" value="<%=request("ag_numero")%>">
	<script language="JavaScript" src="includes/anexo.js"></script>
	<script language="JavaScript">
	function atualiza()
	{
		var f = document.formulario;
		if( f.arq.value == '' )
			alert( 'Por favor, escolha um arquivo' );
		else if (!validaNomeArquivo(extractFileName(f.arq.value)))
			alert('O nome do arquivo está inválido. Retire acentuação e espaços antes de prosseguir.');
		else {
			f.submit();
		}
	}
	</script>
	<table class="tabela1" align="center">
	<tr>
		<td><b>Arquivo Antigo:</b></td>
		<td><%=request( "ant" ) %></td>
	</tr>
	<tr>
		<td><b>Novo Arquivo:</b></td>
		<td>
			<input type="File" name="arq" size="30" class="texto1">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<button class="texto1" style="width: 70px;" onclick="javascript:return atualiza();">&nbsp;OK&nbsp;</button>
			&nbsp;&nbsp;
			<button style="width: 70px;" onclick="javascript:window.close();" class="texto1">Cancelar</button>
		</td>
	</tr>
	</table>
	</form>
<%
call ImprimeRodape(RODAPE_OFF)
%>
