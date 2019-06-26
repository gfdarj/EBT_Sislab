<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->

<!------- SISLAB ---->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Dim categoria, ag_numero, s, rec

ag_numero = request("ag_numero")

If ag_numero <> "" then
	Call Env.StoredProcedure(True, objSP, "SP_SCE_EXCLUI_RESERVA")
	With objSP
		.Parameters.item("@ag_numero") = ag_numero
		.Parameters.item("@USER_ID") = Env.Usuario
		on error resume next
		.Execute
		on error goto 0
	End With
	Call Env.StoredProcedure(False, objSP, "SP_SCE_EXCLUI_RESERVA")
End If

	'-- verifica se ocorreu algum erro
If Env.oConn.Errors.Count > 0 Then
    Call erroDB(true, true, true, Env.oConn.Errors, "cad_reserva.asp?ag_numero=" & ag_numero, "../")
else
	response.redirect "cad_reserva.asp?excluiu=1"
End If

%>
