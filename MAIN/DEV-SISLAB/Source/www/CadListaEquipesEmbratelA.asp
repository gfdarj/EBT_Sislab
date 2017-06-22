<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<!-- #include file="includes/bib_mensagem.asp" -->
<%
Dim gerente, descricao, rsRET, ssql, usadoporag, novo_gerente
Dim chr_URL

if Request("excluir") = "1" Then 'exclusao
	gerente = UCase(request("gerente"))
Else
	gerente = UCase(request("novo_gerente"))
End If
chr_URL = "CadListaEquipesEmbratel.asp?gerente=" & gerente

If VVVNZ(gerente) = "" Then Response.Redirect chr_URL

Env.oConn.BeginTrans

'### Exclui os itens antes de incluir novamente
ssql = "DELETE FROM EquipeEmbratel WHERE UPPER(UserId_Gerente) = '" & gerente & "'"

'rw "<BR><BR><BR>"&ssql & "<BR>"
'rw "<BR><BR><BR>"&Request("excluir")& "<BR>"

On error resume next
Call Env.oConn.Execute(ssql)
On error goto 0

If Env.oConn.Errors.Count > 0 Then
	Env.oConn.RollbackTrans
	Call erroDB(true, false, true, Env.oConn.Errors, chr_URL, "")
	Response.End
End If

if Request("excluir") <> "1" then
	lista = Split(UCase(Request("lista_participante")), ",")
'RW "aqui:" & Request("lista") & "<br>"
'RW "aqui 1:" & Request("lista_participante") & "<br>"
'RW "aqui 2:" & UBOUND(lista) & "<br>"
're

	For i = 0 To UBound(lista)
		If Not VVVNZ(lista(i)) Then

			ssql = _
				"INSERT INTO EquipeEmbratel (UserId_Gerente, UserId_Membro) " & _
				"VALUES ('" & gerente & "','" & lista(i) & "');"
'rw ssql & "<BR>"
			on error resume next
			Call Env.oConn.execute(sSQL)
			on error goto 0

			If Env.oConn.Errors.Count > 0 Then
				Env.oConn.RollbackTrans
				Call ErroDB(true, false, true, Env.oConn.Errors, chr_URL, "")
				'Response.End
			end if

		End If
	Next

end if

Env.oConn.CommitTrans

Response.Redirect chr_URL

set rsRET = nothing
%>