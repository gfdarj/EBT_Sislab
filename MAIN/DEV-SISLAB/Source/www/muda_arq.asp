<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Call Tela.ImprimeCabecalho2("Alteração de Arquivo", MENU_OFF, false, "100%", "Alteração de Arquivo", "NENHUM", "")
%>
	<form method="post" action="muda_arq_salva.asp" name="formulario" enctype="multipart/form-data">
	<input type="hidden" name="proc" value="É hora de processar!">
	<input type="hidden" name="codarq" value="<%=request("codarq")%>">
	<input type="hidden" name="arq_ant" value="<%=request("ant")%>">
	<input type="hidden" name="ag_numero" value="<%=request("ag_numero")%>">
	<script language="JavaScript" src="includes/anexo.js"></script>
	<script type="text/javascript">
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
	<table class="table-bordered" align="center">
	<tr>
		<td><b>Arquivo Antigo:</b></td>
		<td><%=request( "ant" ) %></td>
	</tr>
	<tr>
		<td><b>Novo Arquivo:</b></td>
		<td>
			<input type="File" name="arq" size="30" >
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<button  style="width: 70px;" onclick="javascript:return atualiza();">&nbsp;OK&nbsp;</button>
			&nbsp;&nbsp;
			<button style="width: 70px;" onclick="javascript:window.close();" >Cancelar</button>
		</td>
	</tr>
	</table>
	</form>
<%
Call Tela.MostraRodape()
%>
