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
Dim erroID, erroMSG, sql

eq_destino = Trim(Request("listaEquipamentos"))
If VVVNZ(eq_Destino) Then 
    eq_destino = null
Else
    eq_destino = Replace(Replace(Replace(eq_destino, VbCrLf, ""), VbCr, ""), vbTab, "")
    eq_destino = Replace(eq_destino, " ", "")
    eq_destino = RetiraCaracteres(eq_destino)
End If

ag_numero = request("ag_numero_destino")
If VVVNZ(ag_numero) Then ag_numero = null 

'response.write eq_destino & "<BR>"
'response.write LEN(eq_destino) & "<BR>"
'response.write ag_numero & "<BR>"
'response.write Env.Usuario
'response.end


Call Env.StoredProcedure(True, objSP, "sp_SCE_RECEBE_CARGA")
With objSP
	.Parameters.item("@eq_id") = eq_destino
	.Parameters.item("@ag_numero_dest") = ag_numero
	.Parameters.item("@user_id") = Env.Usuario
	on error resume next
	.Execute
    erroID = Err.number
    erroMSG = Err.Description
   on error goto 0
End With
Call Env.StoredProcedure(False, objSP, Null)

If Env.oConn.Errors.Count > 0 Then
    Tela.SCE = True
    Tela.SetNomeTela = "Movimentação > Erro na Recepção de Carga" : Tela.SetCaminhoRelativo = "../"
    Call Tela.MostraCabecalho()
    'Call Tela.ImprimeMenuSce()
	RW "<div class='margem-10'>"
	RW "    <br /><br />Erro: " & erroID
	RW "    <br /><br />Mensagem: " & erroMSG
	RW "</div>"
    Call Tela.MostraRodape()
Else
    Tela.SCE = True
    Tela.SetNomeTela = "Movimentação > Recepção de Carga" : Tela.SetCaminhoRelativo = "../"
    Call Tela.MostraCabecalho()
    'Call Tela.ImprimeMenuSce()
	RW "<div class='margem-10'>"
	RW "    <br />Carga recebida com sucesso."
	RW "    <br /><br />"
	RW "    <input type='button' value='Voltar' onclick='location.href=""mov_recebecarga.asp"";' />"
	RW "    <br />"
	RW "</div>"
    Call Tela.MostraRodape()
	'Response.Redirect "./mov_recebecarga.asp?msg=1"
End If
%>
