<%
'-----------------------------------------------------------------------------
'-- Funcoes de banco de dados - SCE --
'
' Requer a inclusão dos arquivos
'
'<!--#include file="../../includes/Sislab_Lib.asp" -->
'<!--#include file="../../includes/controlesHTML.asp" -->
'-----------------------------------------------------------------------------

Function Bool2Str(valor)
	if valor then Bool2Str = "Sim" else Bool2Str = "Não"
End Function

'-- UTILIZADA PELAS TELAS DE CADASTRO DE RESERVA DE ITENS --
Function MarcaItemReservado(reservado, linhaTabela)
	Dim color
	if reservado then color = "#FF0000" else color = "#000000"
%>	<script type="text/javascript">
	f.document.all["linha_<%=linhaTabela%>"].style.color = '<%=color%>';
	f.document.all["item_<%=linhaTabela%>"].style.color = '<%=color%>';
	f.document.all["dt_ini_<%=linhaTabela%>"].style.color = '<%=color%>';
	f.document.all["dt_fim_<%=linhaTabela%>"].style.color = '<%=color%>';
	f.document.all["cmb_setup_<%=linhaTabela%>"].style.color = '<%=color%>';
	</script>
<%
End Function


%>
