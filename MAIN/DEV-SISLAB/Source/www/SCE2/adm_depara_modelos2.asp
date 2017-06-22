<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Dim objSP

Call Env.StoredProcedure(True, objSP, "sp_SCE_DEPARA_MODELOS")
With objSP
	.Parameters.item("@mod_id_old").Value = request("mod_id_old")
	.Parameters.item("@mod_id_new").Value = request("mod_id_new")
	on error resume next
	.Execute
	on error goto 0
End With
Call Env.StoredProcedure(False, objSP, "sp_SCE_DEPARA_MODELOS")

If Env.oConn.Errors.Count > 0 Then
    Tela.SetNomeTela = "SCE > Movimentação > Recepção de Carga" : Tela.SetCaminhoRelativo = "../"
    Call Tela.MostraCabecalho()
    Call Tela.ImprimeMenuSce()
	Call Tela.Mensagem.ErroSql()
    Call Tela.MostraRodape()
    Response.End
Else
    Env.SetModulo = "SCE"
    Call Env.Log("Modelo de ID=" & request("mod_id_old") & " alterado para o ID=" & request("mod_id_new"))
	response.redirect "adm_depara_modelos.asp?msg=1"
End If
%>
