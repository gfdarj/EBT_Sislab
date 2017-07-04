<!--#include file="../includes/conexao.inc"-->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/bib_bd.asp"-->
<%
'-- GRAVO O ACEITE/NAO ACEITE NA TELA DE CONSULTA RESERVA, CASO TODOS OS ITENS ESTEJAM 
'-- COMO ACEITE = SIM, ENTAO CHAMO AUTOMATICAMENTE A TELA QUE EXIBE A LISTA DE ITENS
'-- PARA MOVIMENTAR

Call StoredProcedure(True, objSP, "sp_SCE_CADASTRA_ACEITE_RESERVA", Conn)
With objSP
	.Parameters.item("@lista_itens") = request("lista_itens")
	.Parameters.item("@AG_NUMERO") = request("ag_numero")
	.Parameters.item("@user_id") = session("user_id")
	on error resume next
	.Execute
	on error goto 0
End With
Call StoredProcedure(False, objSP, "sp_SCE_CADASTRA_ACEITE_RESERVA", Null)
%>
<html>
<body>
	<script language="JavaScript">
<%
If conn.Errors.Count > 0 Then%>
	alert("ERRO DE GRAVAÇÂO:\n\n<%=conn.Errors(0).Description%>");
<%
else%>
<%
	'-- gravou o aceite, nao verifico se existe algum nao aceito pois na tela SEL_CAD_RESERVA2.ASP
	'-- o mesmo já é verificado, entao eu apenas verifico o parametro que indica tal situacao
	if UCase(request("tudoAceitoOK")) = "SIM" then%>
		window.parent.location.href = "sel_cad_reserva2_mov.asp?ag_numero=<%=request("ag_numero")%>&lista_itens=<%=request("lista_itens")%>";
<%	else%>
		alert("Os itens foram gravados com sucesso");
<%	end if
End If
%>
	</script>
</body>
</html>
