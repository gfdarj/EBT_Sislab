<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
'-- GRAVO O ACEITE/NAO ACEITE NA TELA DE CONSULTA RESERVA, CASO TODOS OS ITENS ESTEJAM 
'-- COMO ACEITE = SIM, ENTAO CHAMO AUTOMATICAMENTE A TELA QUE EXIBE A LISTA DE ITENS
'-- PARA MOVIMENTAR
Dim objSP

Call Env.StoredProcedure(True, objSP, "sp_SCE_CADASTRA_ACEITE_RESERVA")
With objSP
	.Parameters.item("@lista_itens") = request("lista_itens")
	.Parameters.item("@AG_NUMERO") = request("ag_numero")
	.Parameters.item("@user_id") = Env.Usuario
	on error resume next
	.Execute
	on error goto 0
End With
Call Env.StoredProcedure(False, objSP, "sp_SCE_CADASTRA_ACEITE_RESERVA")
%>
<html>
<body>
    <form method="post" action="sel_cad_reserva2_mov.asp">

        <input type="hidden" name="ag_numero" value="<%=request("ag_numero")%>" />
        <input type="hidden" name="lista_itens" value="<%=request("lista_itens")%>" />

    	<script type="text/javascript">
<%
If Env.oconn.Errors.Count > 0 Then%>
	        alert("ERRO DE GRAVAÇÂO:\n\n<%=Env.oconn.Errors(0).Description%>");
<%
else%>
<%
	'-- gravou o aceite, nao verifico se existe algum nao aceito pois na tela SEL_CAD_RESERVA2.ASP
	'-- o mesmo já é verificado, entao eu apenas verifico o parametro que indica tal situacao
    if UCase(request("tudoAceitoOK")) = "SIM" then %>
        //window.parent.location.href = "sel_cad_reserva2_mov.asp?ag_numero=<%=request("ag_numero")%>&lista_itens=<%=request("lista_itens")%>";
            document.forms[0].submit();
<%	else%>
		    alert("Os itens foram gravados com sucesso");
<%	end if
End If
%>
    	</script>
    </form>
</body>
</html>
