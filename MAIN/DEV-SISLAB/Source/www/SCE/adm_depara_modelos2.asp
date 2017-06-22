<!--#INCLUDE FILE="../includes/conexao.inc" -->
<!--#INCLUDE FILE="includes/bib_bd.asp" -->
<%
Dim objConn, objSP
Call Connection(true, ObjConn)
Call StoredProcedure(True, objSP, "sp_SCE_DEPARA_MODELOS", objConn)
With objSP
	.Parameters.item("@mod_id_old").Value = request("mod_id_old")
	.Parameters.item("@mod_id_new").Value = request("mod_id_new")
	on error resume next
	.Execute
	on error goto 0
End With
Call StoredProcedure(False, objSP, "sp_SCE_DEPARA_MODELOS", objConn)

If objConn.Errors.Count > 0 Then
	Call erroDB (objConn.Errors, "")
	Call Connection(false, ObjConn)
else
	Call Connection(false, ObjConn)
	response.redirect "adm_depara_modelos.asp?msg=1"
End If
%>
