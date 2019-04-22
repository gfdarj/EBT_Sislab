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
Dim erroID, erroMSG

eq_destino = request("eq_destino")
If VVVNZ(eq_Destino) Then 
    eq_destino = null
Else
    eq_destino = Replace(Replace(Replace(eq_destino, VbCrLf, ""), VbCr, ""), vbTab, "")
    eq_destino = Replace(eq_destino, " ", "")
    eq_destino = RetiraCaracteres(eq_destino)
End If

ag_destino = request("ag_numero_destino")
if ag_destino = "" then ag_destino = null 
ag_origem = request("ag_numero_origem")
if ag_origem = "" then ag_origem = null

'response.write "eq_destino: " & eq_destino & " <BR>"
'response.write "ag_destino: " & ag_destino & "<BR>"
'response.write "ag_origem: " & ag_origem & "<BR>"
'response.write "Env.Usuario: " & Env.Usuario & "<BR>"
'response.end

Call Env.StoredProcedure(True, objSP, "sp_SCE_PASSA_CARGA")
With objSP
	.Parameters.item("@eq_id") = eq_destino
	.Parameters.item("@ag_numero_orig") = ag_origem
	.Parameters.item("@ag_numero_dest") = ag_destino
	.Parameters.item("@user_id") = Env.Usuario
	on error resume next
	.Execute
    erroID = Err.number
    erroMSG = Err.Description
	on error goto 0
End With
Call Env.StoredProcedure(False, objSP, Null)

If Env.oConn.Errors.Count > 0 Then
    Tela.SetNomeTela = "SCE > Movimentação > Erro na Passagem de Carga" : Tela.SetCaminhoRelativo = "../"
    Call Tela.MostraCabecalho()
    Call Tela.ImprimeMenuSce()
    erroID = Err.number
    erroMSG = Err.Description
    Call Tela.MostraRodape()
    Response.End
Else
    Tela.SetNomeTela = "SCE > Movimentação > Recepção de Carga" : Tela.SetCaminhoRelativo = "../"
    Call Tela.MostraCabecalho()
    Call Tela.ImprimeMenuSce()
	RW "<div class='margem-10'>"
	RW "    <br />Carga passada com sucesso."
	RW "    <br /><br />"
	RW "    <input type='button' value='Voltar' onclick='location.href=""mov_passacarga.asp"";' />"
	RW "    <br />"
	RW "</div>"
    Call Tela.MostraRodape()
	'Response.Redirect "./mov_passacarga.asp?msg=1"
End If
%>