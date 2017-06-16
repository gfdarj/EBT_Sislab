<!--#include file="../includes/conexao.inc"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/bib_bd.asp"-->
<%
Dim s, objSP
Dim eq_Destino, ag_origem, ag_destino

eq_destino = request("eq_destino")
if eq_Destino = "" then eq_destino = null
ag_destino = request("ag_numero_destino")
if ag_destino = "" then ag_destino = null 
ag_origem = request("ag_numero_origem")
if ag_origem = "" then ag_origem = null

'response.write eq_destino & " 1 <BR>"
'response.write ag_destino & "<BR>"
'response.write ag_origem & "<BR>"
'response.end

Call StoredProcedure(True, objSP, "SP_SCE_PASSA_CARGA", Conn)
With objSP
	.Parameters.item("@eq_id") = eq_destino
	.Parameters.item("@ag_numero_orig") = ag_origem
	.Parameters.item("@ag_numero_dest") = ag_destino
	.Parameters.item("@user_id") = session("user_id")
	on error resume next
	.Execute
	on error goto 0
End With
Call StoredProcedure(False, objSP, Null, Null)

If conn.Errors.Count > 0 Then
	erroDB conn.Errors, ""
else
	response.redirect "mov_passacarga.asp?msg=1"
End If

Conn.close
Set Conn = Nothing

%>