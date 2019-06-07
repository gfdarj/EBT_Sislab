<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/Geral_Lib.asp" -->
<!--#include file="../includes/EmailHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Call Tela.MostraCabecalho()

Dim RS, SQL, Ebt1, conta, contaNaoAchei
Dim tbNaoTem

	tbNaoTem = "<table><tr><th>Username</th><th>Status</th></tr>" & VbCrLf

	conta = 0
	contaNaoAchei = 0
    Set ebt1 = new TEbt

    SQL = "SELECT DISTINCT /*top 20*/ AG_USERNAME FROM AGENDAMENTO"
    Call Env.RecordSet(true, RS, SQL)


'Call Ebt1.LoginUsuario("joacar@embratel.com.br")
'Response.Write "Usuario: " & Ebt1.Usuario() & "<BR>"
'Response.Write "Nome: " & Ebt1.NomeReduzido & "<BR>"
'Response.Write "Matricula: " & Ebt1.Matricula & "<BR>"
'Response.Write "Ramal: " & Ebt1.Ramal & "<BR>"
'Response.Write "Orgão: " & Ebt1.SiglaOrgao & "<BR><BR>"
'Response.End



    While Not RS.Eof

        Response.Write "AG_USERNAME: " & RS("AG_USERNAME") & "<BR><br>"

		On Error Resume Next
        Call Ebt1.LoginUsuario(RS("AG_USERNAME"))
		If Err.Number <> 0 Then
			erro = True
		Else
			erro = False
		End If
		On Error Goto 0

		If Not erro Then
			If Ebt1.NomeReduzido <> "" Then
				Response.Write "Usuario: " & Ebt1.Usuario() & "<BR>"
				Response.Write "Nome: " & Ebt1.NomeReduzido & "<BR>"
				Response.Write "Matricula: " & Ebt1.Matricula & "<BR>"
				Response.Write "Ramal: " & Ebt1.Ramal & "<BR>"
				Response.Write "Orgão: " & Ebt1.SiglaOrgao & "<BR><BR>"

				SQL = "UPDATE Agendamento SET AG_USERNAME_MATRICULA = '" & Ebt1.Matricula & "', " & VbCrLf & _
					  "		AG_USERNAME_NOME = '" & Ebt1.NomeReduzido & "', " & VbCrLf & _
					  "		AG_USERNAME_TELEFONE = '" & Ebt1.Ramal & "' " & VbCrLf & _
					  "WHERE AG_USERNAME = '" & RS("AG_USERNAME") & "'"
				Call Env.oConn.Execute(SQL)

				SQL = "UPDATE Agendamento SET AG_ORGAO = '" & Ebt1.SiglaOrgao & "' " & VbCrLf & _
					  "WHERE AG_USERNAME = '" & RS("AG_USERNAME") & "' AND AG_ORGAO IS NULL"
				Call Env.oConn.Execute(SQL)
			Else
				Response.Write "** Não achei **<br><br>"
				tbNaoTem = tbNaoTem & "<tr><td>" & RS("AG_USERNAME") & "</td><td>NÃO ACHEI</td></tr>" & VbCrLf
				contaNaoAchei = contaNaoAchei + 1
			End If
		Else
			tbNaoTem = tbNaoTem & "<tr><td>" & RS("AG_USERNAME") & "</td><td>ERRO</td></tr>" & VbCrLf
			Response.Write "** ERRO **<br><br>"
		End If
        Response.Write "NOW: " & now & " <br>-----------------------<br><br>"

        RS.MoveNext
		conta = conta + 1

		If conta Mod 100 Then 
			Response.Flush
		End If
    WEnd

	tbNaoTem = tbNaoTem & "</table>" & VbCrLf

	Response.Write "<br>FIM !!!<br><br>Não achei: " & contaNaoAchei & " registros<br><br>"
	Response.Write tbNaoTem & "<br>"
%>
<%
Call Tela.MostraRodape()
%>