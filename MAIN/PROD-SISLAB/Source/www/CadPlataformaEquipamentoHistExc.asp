<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_mensagem.asp" -->
<%
Dim hpe_id

hpe_id = Request("hpe_id")

If hpe_id <> "" Then

	On Error Resume Next
	Env.oConn.Execute "DELETE FROM Historico_Plataforma_Equipamentos WHERE HPE_ID = " & hpe_id
	On Error Goto 0

	If Err.Number <> 0 Then
		Call ErroHtml(True, False, "Erro ao tentar excluir item do histórico" , "", "")
	Else
		Response.Redirect "CadPlataformaEquipamentoHist.asp?plataforma=" & request("plataforma")
	End If
Else
	Response.Redirect "CadPlataformaEquipamentoHist.asp?plataforma=" & request("plataforma")
End If
%>
