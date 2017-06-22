<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
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

Call Env.StoredProcedure(True, objSP, "sp_SCE_RECEBE_CARGA")
With objSP
	.Parameters.item("@eq_id") = eq_destino
	.Parameters.item("@ag_numero_dest") = ag_numero
	.Parameters.item("@user_id") = Env.Usuario
	on error resume next
	.Execute
	on error goto 0
End With
Call Env.StoredProcedure(False, objSP, Null)

If Env.oConn.Errors.Count > 0 Then
    Tela.SetNomeTela = "SCE > Movimentação > Recepção de Carga" : Tela.SetCaminhoRelativo = "../"
    Call Tela.MostraCabecalho()
    Call Tela.ImprimeMenuSce()
	Call Tela.Mensagem.ErroSql()
    Call Tela.MostraRodape()
    Response.End
Else
	Response.Redirect "mov_recebecarga.asp?msg=1"
End If

%>