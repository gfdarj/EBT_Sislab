<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/bib_str.asp" -->
<script language="javascript" src="includes/anexo.js"></script>
<% 
Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Arquivos - " & auxaltera & " " & auxlink, "", "")

Dim RS
Dim chr_SQL
Dim chr_Arquivo
Dim int_Conta
Dim objFSO
Dim chr_Folder
Dim chr_SubFolder
Dim ag_numero

Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
'Set Folder = ObjFso.GetFolder(Server.mapPath(".") & "\arquivos\")

chr_Folder = Server.mapPath(".") & "\arquivos\"
'RW chr_Folder & "<BR>"

chr_SQL = "" & _
	"SELECT a.arq_codarq, a.arq_codarqtipo, a.arq_link, a.arq_nomearq, a.arq_responsavel," & VbCrLf & _
	"	ta.tar_tipoarquivo, d.ag_numero " & VbCrLf & _
	"FROM arquivos a INNER JOIN TipoArquivo ta ON ta.tar_codtipoarquivo = a.arq_codarqtipo " & VbCrLf & _
	"LEFT JOIN diagramas d ON d.arq_codarq = a.arq_codarq" & VbCrLf & _
	"/*WHERE a.arq_codarq = 3256*/ " & VbCrLf & _
	"--WHERE d.ag_numero = 2712 " & VbCrLf & _
	"--WHERE d.ag_numero >= 2600 and d.ag_numero < 2687 " & VbCrLf & _
	"WHERE d.ag_numero >= 1 and d.ag_numero < 2600 " & VbCrLf & _
	"--WHERE d.ag_numero = 2705 " & VbCrLf & _
	"--WHERE d.ag_numero = 2700 " & VbCrLf & _
	"ORDER BY d.ag_numero DESC, ta.tar_tipoarquivo, a.arq_link"
'	"ORDER BY ta.tar_tipoarquivo, d.ag_numero DESC, a.arq_link"

Set RS = Env.oConn.Execute(chr_SQL)

'chr_arquivo = "arquivo de ma�� doce.pdf"
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
	id_arquivo = RS("arq_codarq")
	chr_Arquivo = RS("arq_nomearq")
	ag_numero = RS("ag_numero")

	chr_SubFolder = "AS_" & Zeros(ag_numero, 5) & "\"

	'mover o arquivo para a nova pasta
	If objFSO.FileExists(chr_Folder & chr_Arquivo) Then
		'criar a pasta
		If Not objFSO.FolderExists(chr_Folder & chr_SubFolder) Then
			Call objFSO.CreateFolder(chr_Folder & chr_SubFolder)
			RW "<tr><td><font color='red'>Criei O folder ! " & chr_SubFolder & "</font><BR><BR></td></tr>"
		End If

		On Error Resume Next
		objFSO.Movefile chr_Folder & chr_Arquivo, chr_Folder & chr_SubFolder & chr_Arquivo
		If Err.number <> 0 Then
			RW "<tr><td><font color='red'>ARQUIVO NAO ENCONTRADO !!!" &  "</font><BR><BR></td></tr>"
			RW "<tr><td><font color='red'>Err.number: " & Err.Number & "</font><BR><BR></td></tr>"
			RW "<tr><td><font color='red'>Err.Description: " & Err.Description & "</font><BR><BR></td></tr>"
		Else
			RW "<tr><td><font color='red'>Movi o arquivo ! " & chr_Arquivo & "</font><BR><BR></td></tr>"
		End If
		On Error Goto 0

		chr_SQL = "" & _
			"UPDATE arquivos SET arq_nomearq = '" & chr_SubFolder & chr_Arquivo & "'" & VbCrLf & _
			"WHERE arq_codarq = " & id_arquivo & "" & VbCrLf
		Call Env.oConn.Execute(chr_SQL)

		RW "<tr><td><font color='red'>SQL: " & chr_SQL & "</font><BR><BR></td></tr>"
	Else
		RW "<tr><td><font color='red'>--> NAO ENCONTREI O ARQUIVO " & chr_Arquivo & "</font><BR><BR></td></tr>"
	End If

	RW "<tr><td><font color='red'>Arquivo: " & chr_SubFolder & chr_Arquivo & "</font><BR><BR></td></tr>"
%>
<tr>
	<td>C�digo Interno: <%=RS("arq_codarq")%><BR><BR>
		Tipo de arquivo: <%=RS("tar_tipoarquivo")%><BR><BR>
		Nome: <%=RS("arq_link")%> <BR><BR>
		Link: <%=chr_Arquivo%><BR><BR>
		Sugest�o: <b><%=chr_Arquivo%></b><BR><BR>
		AS: <%=ag_numero%><BR><BR>
		Respons�vel: <%=RS("arq_responsavel")%><BR>
		<hr>
	</td>
</tr>
<%		int_Conta = int_Conta + 1
'	End If

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

	ComAcentos = "!@#$%�&*()-?:{}][���������������������������������������������� "
	SemAcentos = "_________________AAAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUuuuuCc_"

'	ComAcentos = "+!@#$%�&*()?:{}][����������������������������������������������"
'	SemAcentos = "_________________AAAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUuuuuCc"

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
