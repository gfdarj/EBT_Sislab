<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
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

Call Env.StoredProcedure(True, objSP, "sp_SCE_PASSA_CARGA")
With objSP
	.Parameters.item("@eq_id") = eq_destino
	.Parameters.item("@ag_numero_orig") = ag_origem
	.Parameters.item("@ag_numero_dest") = ag_destino
	.Parameters.item("@user_id") = Env.Usuario
	on error resume next
	.Execute
	on error goto 0
End With
Call Env.StoredProcedure(False, objSP, Null)

If Env.oConn.Errors.Count > 0 Then
    Tela.SetNomeTela = "SCE > Movimentação > Passagem de Carga" : Tela.SetCaminhoRelativo = "../"
    Call Tela.MostraCabecalho()
    Call Tela.ImprimeMenuSce()
	Call Tela.Mensagem.ErroSql()
    Call Tela.MostraRodape()
    Response.End
else
	Response.Redirect "mov_passacarga.asp?msg=1"
End If

%>