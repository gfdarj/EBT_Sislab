<!--#include file="../includes/conexao.inc"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/bib_bd.asp"-->
<%
Dim objSP, eq_Destino, ag_numero

eq_destino = request("eq_destino")
if eq_Destino = "" then eq_destino = null
ag_numero = request("ag_numero_destino")
if ag_numero = "" then ag_numero = null 

'response.write eq_destino & " 1 <BR>"
'response.write ag_numero & "<BR>"
'response.write  session("user_id")
'response.end

Call StoredProcedure(True, objSP, "SP_SCE_RECEBE_CARGA", Conn)
With objSP
	.Parameters.item("@eq_id") = eq_destino
	.Parameters.item("@ag_numero_dest") = ag_numero
	.Parameters.item("@user_id") = session("user_id")
	on error resume next
	.Execute
	on error goto 0
End With
Call StoredProcedure(False, objSP, Null, Null)

If conn.Errors.Count > 0 Then
	erroDB conn.Errors, ""
else
	response.redirect "mov_recebecarga.asp?msg=1"
End If

Conn.close
Set Conn = Nothing

%>