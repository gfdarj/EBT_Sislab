<!-- #INCLUDE FILE="includes/abre.asp" -->
<!-- #INCLUDE FILE="includes/conexao.inc" -->
<!-- #INCLUDE FILE="includes/bib_bd.asp" -->
<%
Dim categoria, ag_numero, s, rec

ag_numero = request("ag_numero")

If ag_numero <> "" then
	Call StoredProcedure(True, objSP, "SP_SCE_EXCLUI_RESERVA", Conn)
	With objSP
		.Parameters.item("@ag_numero") = ag_numero
		.Parameters.item("@USER_ID") = session("user_id")
		on error resume next
		.Execute
		on error goto 0
	End With
	Call StoredProcedure(False, objSP, "SP_SCE_EXCLUI_RESERVA", Null)
End If

	'-- verifica se ocorreu algum erro
If conn.Errors.Count > 0 Then
	erroDB conn.Errors, "location.href='cad_reserva.asp?ag_numero=" & ag_numero
else
	response.redirect "cad_reserva.asp?excluiu=1"
End If

Conn.Close
set Conn = nothing
%>
