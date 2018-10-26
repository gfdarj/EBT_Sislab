<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<script language="javascript" src="includes/anexo.js"></script>
<% 
Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Arquivos - " & auxaltera & " " & auxlink, "", "")

Dim RS
Dim chr_SQL
Dim chr_Arquivo
Dim int_Conta
Dim objFSO
Dim chr_Folder

Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
'Set Folder = ObjFso.GetFolder(Server.mapPath(".") & "\arquivos\")

chr_Folder = Server.mapPath(".") & "\arquivos\"
'RW chr_Folder & "<BR>"

chr_SQL = "" & _
	"SELECT a.arq_codarq, a.arq_codarqtipo, a.arq_link, a.arq_nomearq, a.arq_responsavel," & VbCrLf & _
	"	ta.tar_tipoarquivo, d.ag_numero" & VbCrLf & _
	"FROM arquivos a INNER JOIN TipoArquivo ta ON ta.tar_codtipoarquivo = a.arq_codarqtipo" & VbCrLf & _
	"LEFT JOIN diagramas d ON d.arq_codarq = a.arq_codarq" & VbCrLf & _
	"/*WHERE a.arq_codarq = 3256*/ " & VbCrLf & _
	"ORDER BY ta.tar_tipoarquivo, d.ag_numero DESC, a.arq_link"

Set RS = Env.oConn.Execute(chr_SQL)

'chr_arquivo = "arquivo de mae doce.pdf"
'RW chr_arquivo & "<BR>"
'RW ValidaNomeArquivo(chr_arquivo, true) & "<BR>"
'RW chr_arquivo & "<BR>"
int_Conta = 0
%>
<table width="100%" border="0" class="table-bordered">
<tr>
	<th>Arquivo</th>
</tr>
<%
'Env.oConn.BeginTrans

While Not RS.Eof
	chr_Arquivo = RS("arq_nomearq")

	If Not ValidaNomeArquivo(chr_Arquivo, True) Then

'		Set file = objFSO.GetFile(chr_Folder & RS("arq_nomearq"))

		'RW "<tr><td>UPDATE Arquivos SET arq_nomearq='" & chr_Arquivo & "'  WHERE arq_codarq = " & RS("arq_codarq") & "</td></tr>"

'		rw "AQUI:" & chr_Folder & RS("arq_nomearq")
'		re
'''''		On Error Resume Next
'		RW  """" & chr_Folder & RS("arq_nomearq") & """" & " = "&  """" & chr_Folder & chr_Arquivo & """"
'		re
'''''		objFSO.Movefile chr_Folder & RS("arq_nomearq"), chr_Folder & chr_Arquivo
'''''		int_Erro = Err.Number
'''''		On Error Goto 0

'''''		If int_Erro <> 0 Then
'''''			RW "<tr><td><font color='red'><B>Arquivo " & RS("arq_nomearq") & " não alterado !!!</B></font><BR><BR></td></tr>"
'''''		Else
'''''			'RW "<tr><td>UPDATE Arquivos SET arq_nomearq='" & chr_Arquivo & "'  WHERE arq_codarq = " & RS("arq_codarq") & "</td></tr>"
'''''			Env.oConn.Execute("UPDATE Arquivos SET arq_nomearq='" & chr_Arquivo & "'  WHERE arq_codarq = " & RS("arq_codarq"))
'''''		End If


		'se o arquivo antigo nao existe, testa se o novo existe para dar o update
		If Not objFSO.FileExists(chr_Folder & RS("arq_nomearq")) Then
			If objFSO.FileExists(chr_Folder & chr_Arquivo) Then
				'Env.oConn.Execute("UPDATE Arquivos SET arq_nomearq='" & chr_Arquivo & "'  WHERE arq_codarq = " & RS("arq_codarq"))
				RW "<tr><td><font color='red'>ATUALIZEI " & RS("arq_nomearq") & "</font><BR><BR></td></tr>"
			Else
				RW "<tr><td><font color='red'>nao encontrei o novo: " & chr_Arquivo & "</font><BR><BR></td></tr>"
			End If
		Else
			RW "<tr><td><font color='red'>Achei o antigo: " & RS("arq_nomearq") & "</font><BR><BR></td></tr>"
		End If
%>
<tr>
	<td>Código Interno: <%=RS("arq_codarq")%><BR><BR>
		Tipo de arquivo: <%=RS("tar_tipoarquivo")%><BR><BR>
		Nome: <%=RS("arq_link")%> <BR><BR>
		Link: <%=RS("arq_nomearq")%><BR><BR>
		Sugestão: <b><%=chr_Arquivo%></b><BR><BR>
		AS: <%=RS("ag_numero")%><BR><BR>
		Responsável: <%=RS("arq_responsavel")%><BR>
		<hr>
	</td>
</tr>
<%		int_Conta = int_Conta + 1
	End If

	RS.MoveNext
WEnd

'Env.oConn.RollbackTrans
%>
</table>
<%
RW "<BR>Total encontrado: " & int_Conta & "<BR><BR>"

Set objFSO = Nothing


Call Tela.MostraRodape()


Function ValidaNomeArquivo(ByRef chr_arquivo, bln_TrocaNome)
	Dim ComAcentos
	Dim SemAcentos
	Dim int_Indice

	ComAcentos = "!@#$%¨&*()-?:{}][ÄÅÁÂÀÃäáâàãÉÊËÈéêëèÍÎÏÌíîïìÖÓÔÒÕöóôòõÜÚÛüúûùÇç "
	SemAcentos = "_________________AAAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUuuuuCc_"

	ValidaNomeArquivo = True
	For i=1 To Len(ComAcentos)

		int_Indice = InStr(1, chr_arquivo, Mid(ComAcentos, i, 1))
		If int_Indice <> 0 Then
			ValidaNomeArquivo = False

			'Somente valida, entao sai do loop
			If Not bln_TrocaNome Then
				i = Len(ComAcentos)
			Else
				chr_arquivo = Replace(chr_arquivo, Mid(ComAcentos, i, 1), Mid(SemAcentos, i, 1))
			End If
		End If
		'ValidaNomeArquivo = i & " = " & chr_arquivo & " = " & Mid(ComAcentos, i, 1) & " = " & InStr(1, chr_arquivo, Mid(ComAcentos, i, 1)) & "<BR>"
	Next

End Function
%>
